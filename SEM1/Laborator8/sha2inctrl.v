module sha2inctrl(
  input clk, 
  input rst_b, 
  input lst_pkt, 
  input clr, 
  input [2:0] idx,
  output reg blk_val, 
  output reg msg_end, 
  output reg mgln_pkt, 
  output reg pad_pkt, 
  output reg st_pkt, 
  output reg zero_pkt
);

  localparam START_ST = 0;
  localparam RX_PKT_ST = 1;
  localparam PAD_ST = 2;
  localparam ZERO_ST = 3;
  localparam MGLN_ST = 4;
  localparam MSG_END_ST = 5;
  localparam STOP_ST = 6;

  reg [2:0] current_state, next_state;

always @(*) begin
  case(current_state)
    START_ST: 
      if(lst_pkt == 1) 
        next_state = PAD_ST; 
      else 
        next_state = RX_PKT_ST;
    RX_PKT_ST: begin
      if((idx != 0) && (lst_pkt == 1)) begin
        next_state = PAD_ST;
      end else if((idx == 0) && (lst_pkt == 1)) begin
        next_state = PAD_ST;
      end else if((idx != 0) && (lst_pkt == 0)) begin
        next_state = RX_PKT_ST;
      end else if((idx == 0) && (lst_pkt == 0)) begin
        next_state = RX_PKT_ST;
      end
    end
    PAD_ST: begin
      if((idx == 0)) begin
        next_state = ZERO_ST;
      end else if((idx != 0) && (idx != 7)) begin
        next_state = ZERO_ST;
      end else if(idx == 7) begin
        next_state = MGLN_ST;
      end
    end
    ZERO_ST: begin
      if(idx != 7) begin
        next_state = ZERO_ST;
      end else if(idx == 7) begin
        next_state = MGLN_ST;
      end
    end
    MGLN_ST: begin
      next_state = MSG_END_ST;
    end
    MSG_END_ST: begin
      next_state = STOP_ST;
    end
    STOP_ST: begin
      next_state = STOP_ST;
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
  case(current_state)
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
    current_state <= START_ST;
  else 
    current_state <= next_state;
end

endmodule


    module sha2inctrl_tb;
    reg clk, rst_b, lst_pkt, clr;
    reg [63:0] pkt;
    wire [2:0]idx;
    wire blk_val, msg_end, mgln_pkt, pad_pkt, st_pkt, zero_pkt;
    wire [511:0] blk;

    sha2indpath uut1(
      .clk(clk),
      .rst_b(rst_b),
      .st_pkt(st_pkt),
      .clr(clr),
      .pkt(pkt),
      .pad_pkt(pad_pkt),
      .zero_pkt(zero_pkt),
      .mgln_pkt(mgln_pkt),
      .msg_len(msg_len),
      .idx(idx),
      .blk(blk)                                                                                                           
    );

    sha2inctrl uut2(
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
      pkt = "abcd0123";
      lst_pkt = 1;
      clr = 0;
    end

    localparam CLK_PERIOD = 100;
    localparam RUNNING_CYCLES = 10;
    initial begin
        clk = 1'd0;
        repeat (2*RUNNING_CYCLES) #(CLK_PERIOD/2) clk = ~clk;
    end
    
    localparam RST_DURATION = 25;
    initial begin
      rst_b = 1'd0;
      #RST_DURATION rst_b = 1'd1;
    end

    initial begin
      #200; pkt = 0;
    end

    initial begin
      #100; lst_pkt = 0;
    end
    initial begin
        $monitor("Time: %0t | clk = %b | rst_b = %b | lst_pkt = %b | pkt = %h | idx = %b | blk_val = %b | msg_end = %b | mgln_pkt = %b | pad_pkt = %b | st_pkt = %b | zero_pkt = %b", 
                 $time, clk, rst_b, lst_pkt, pkt, idx, blk_val, msg_end, mgln_pkt, pad_pkt, st_pkt, zero_pkt);
    end

endmodule