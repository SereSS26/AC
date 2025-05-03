module fdivby3(
  input clk, rst_b, clr, c_up,
  output fdclk
);

localparam S0 = 0;
localparam S1 = 1;
localparam S2 = 2;

reg [2:0] st;
wire [2:0] st_nxt;

assign st_nxt[S0] = (st[S0] & (~(c_up) |clr)) | (st[S1] & clr) | (st[S2] & (c_up | clr));
assign st_nxt[S1] = (st[S0] & (c_up & ~(clr))) | (st[S1] & (~(c_up) & ~(clr)));
assign st_nxt[S2] = (st[S1] & (c_up & ~(clr))) | (st[S2] & (~(c_up) & ~(clr)));

assign fdclk = st[S0];

always @(posedge clk or negedge rst_b) begin
  if(rst_b == 0) begin
    st <= 0;
    st[S0] <= 1;
  end
  else
    st <= st_nxt;
end

endmodule

module fdivby3_tb;
reg clk, rst_b, clr, c_up;
wire fdclk;

fdivby3 cut(
  .clk(clk),
  .rst_b(rst_b),
  .clr(clr),
  .c_up(c_up),
  .fdclk(fdclk)
);

initial begin
  clk = 0;
  rst_b = 0;
  clr = 0;
  c_up = 1;
end

integer i;
initial begin
  for(i = 1; i <= 34; i = i + 1) begin
    #50; clk = ~clk;
  end
end

initial begin
  #25; rst_b = 1;
end

initial begin
  #400; clr = 1;
  #100; clr = 0;
end

initial begin
  #600; c_up = 0;
  #100; c_up = 1;
  #400; c_up = 0;
  #200; c_up = 1;
end

endmodule