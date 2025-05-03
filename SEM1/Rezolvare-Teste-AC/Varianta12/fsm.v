module fsm(
  input clk, rst_b, clr, c_up,
  output dclk
);

localparam S0 = 3'b000;
localparam S1 = 3'b001;
localparam S2 = 3'b010;
localparam S3 = 3'b011;
localparam S4 = 3'b100;
localparam S5 = 3'b101;


reg [5:0] st;
wire [5:0] st_nxt;

assign st_nxt[S0] = (st[S0] & (~(c_up) |clr)) | (st[S1] & (clr)) | (st[S2] & (clr)) | (st[S3] &(clr)) | (st[S4] &(clr)) |(st[S5]&(c_up|clr));
assign st_nxt[S1] = (st[S0] & (c_up & ~(clr))) | (st[S1] & (~(c_up) & ~(clr)));
assign st_nxt[S2] = (st[S1] & (c_up & ~(clr))) | (st[S2] & (~(c_up) & ~(clr)));
assign st_nxt[S3] = (st[S2] & (c_up & ~(clr))) | (st[S3] & (~(c_up) & ~(clr)));
assign st_nxt[S4] = (st[S3] & (c_up & ~(clr))) | (st[S4] & (~(c_up) & ~(clr)));
assign st_nxt[S5] = (st[S4] & (c_up & ~(clr))) | (st[S5] & (~(c_up) & ~(clr)));

assign dclk = st[S0];

always @(posedge clk or negedge rst_b) begin
  if(rst_b == 0) begin
    st <= 0;
    st[S0] <= 1;
  end
  else
    st <= st_nxt;
end

endmodule

module fsm_tb;
reg clk, rst_b, clr, c_up;
wire dclk;

fsm uut(
  .clk(clk),
  .rst_b(rst_b),
  .clr(clr),
  .c_up(c_up),
  .dclk(dclk)
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

initial begin
    $monitor("Timp: %t | clk: %b | rst_b: %b | clr: %b | c_up: %b | dclk: %b ", $time, clk, rst_b, clr, c_up, dclk);
  end

endmodule
  
  