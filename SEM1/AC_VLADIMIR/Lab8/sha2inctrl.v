`include "sha2indpath.v"

module sha2inctrl(
  input clk, rst_b, lst_pkt, clr, 
  input [2:0] idx,
  output reg blk_val, msg_end, mgln_pkt, pad_pkt, st_pkt, zero_pkt
);

localparam START_ST = 0;
localparam RX_PKT_ST = 1;
localparam PAD_ST = 2;
localparam ZERO_ST = 3;
localparam MGLN_ST = 4;
localparam MSG_END_ST = 5;
localparam STOP_ST = 6;

reg [2:0] st, st_nxt;

always @(*) begin
  case(st)
    START_ST: 
      if(lst_pkt == 1) 
        st_nxt = PAD_ST; 
      else 
        st_nxt = RX_PKT_ST;
    RX_PKT_ST: begin
      if((idx != 0) && (lst_pkt == 1)) begin
        st_nxt = PAD_ST;
      end else if((idx == 0) && (lst_pkt == 1)) begin
        st_nxt = PAD_ST;
      end else if((idx != 0) && (lst_pkt == 0)) begin
        st_nxt = RX_PKT_ST;
      end else if((idx == 0) && (lst_pkt == 0)) begin
        st_nxt = RX_PKT_ST;
      end
    end
    PAD_ST: begin
      if((idx == 0)) begin
        st_nxt = ZERO_ST;
      end else if((idx != 0) && (idx != 7)) begin
        st_nxt = ZERO_ST;
      end else if(idx == 7) begin
        st_nxt = MGLN_ST;
      end
    end
    ZERO_ST: begin
      if(idx != 7) begin
        st_nxt = ZERO_ST;
      end else if(idx == 7) begin
        st_nxt = MGLN_ST;
      end
    end
    MGLN_ST: begin
      st_nxt = MSG_END_ST;
    end
    MSG_END_ST: begin
      st_nxt = STOP_ST;
    end
    STOP_ST: begin
      st_nxt = STOP_ST;
    end
  endcase
end

always @(*) begin
  blk_val = 0;
  msg_end = 0;
  mgln_pkt = 0;
  pad_pkt = 0;
  st_pkt = 0;
  zero_pkt = 0;
  case(st)
    START_ST: begin
      if(lst_pkt == 1) begin
        st_pkt = 1;
        pad_pkt = 0;
        zero_pkt = 0;
        mgln_pkt = 0;
      end else begin
        st_pkt = 1;
        pad_pkt = 0;
        zero_pkt = 0;
        mgln_pkt = 0;
      end
    end
    RX_PKT_ST: begin
      if((idx != 0) && (lst_pkt == 1)) begin
        st_pkt = 1;
        pad_pkt = 0;
        zero_pkt = 0;
        mgln_pkt = 0;
      end else if((idx == 0) && (lst_pkt == 1)) begin
        blk_val = 1;
        st_pkt = 1;
        pad_pkt = 0;
        zero_pkt = 0;
        mgln_pkt = 0;
      end else if((idx != 0) && (lst_pkt == 0)) begin
        st_pkt = 1;
        pad_pkt = 0;
        zero_pkt = 0;
        mgln_pkt = 0;
      end else if((idx == 0) && (lst_pkt == 0)) begin
        blk_val = 1;
        st_pkt = 1;
        pad_pkt = 0;
        zero_pkt = 0;
        mgln_pkt = 0;
      end
    end
    PAD_ST: begin
      if((idx == 0)) begin
        blk_val = 1;
        pad_pkt = 1;
        zero_pkt = 0;
        mgln_pkt = 0;
        st_pkt = 1;
      end else if((idx != 0) && (idx != 7)) begin
        st_pkt = 1;
        pad_pkt = 1;
        zero_pkt = 0;
        mgln_pkt = 0;
      end else if(idx == 7) begin
        st_pkt = 1;
        pad_pkt = 1;
        zero_pkt = 0;
        mgln_pkt = 0;
      end
    end
    ZERO_ST: begin
      if(idx != 7) begin
        st_pkt = 1;
        pad_pkt = 0;
        zero_pkt = 1;
        mgln_pkt = 0;
      end else if(idx == 7) begin
        st_pkt = 1;
        pad_pkt = 0;
        zero_pkt = 1;
        mgln_pkt = 0;
      end
    end
    MGLN_ST: begin
      st_pkt = 1;
      pad_pkt = 0;
      zero_pkt = 0;
      mgln_pkt = 1;
    end
    MSG_END_ST: begin
      blk_val = 1;
      msg_end = 1;
    end
  endcase
end

always @(posedge clk or negedge rst_b) begin
  if (!rst_b) 
    st <= START_ST;
  else 
    st <= st_nxt;
end

endmodule

module sha2inctrl_tb;
reg clk, rst_b, lst_pkt, clr;
reg [63:0] pkt;
wire [2:0]idx;
wire blk_val, msg_end, mgln_pkt, pad_pkt, st_pkt, zero_pkt;
wire [511:0] blk;

sha2indpath circ1(
  .clk(clk),
  .rst_b(rst_b),
  .st_pkt(st_pkt),
  .clr(clr),
  .pkt(pkt),
  .pad_pkt(pad_pkt),
  .zero_pkt(zero_pkt),
  .mgln_pkt(mgln_pkt),
  .idx(idx),
  .blk(blk)
);

sha2inctrl circ2(
  .clk(clk),
  .rst_b(rst_b),
  .lst_pkt(lst_pkt),
  .clr(clr),
  .idx(idx),
  .blk_val(blk_val),
  .msg_end(msg_end),
  .pad_pkt(pad_pkt),
  .zero_pkt(zero_pkt),
  .mgln_pkt(mgln_pkt),
  .st_pkt(st_pkt)
);

initial begin
  clk = 0;
  rst_b = 0;
  pkt = "abcd0123";
  lst_pkt = 1;
  clr = 0;
end

integer i;
initial begin
  for(i = 1; i <= 200; i = i + 1) begin
    #50; clk = ~clk;
  end
end

initial begin
  #25; rst_b = 1;
end

initial begin
  #160; pkt = 0;
end

initial begin
  #100; lst_pkt = 0;
end

endmodule