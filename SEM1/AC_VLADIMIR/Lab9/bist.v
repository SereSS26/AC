`include "lfsr5b.v"
`include "check.v"
`include "sisr4b.v"

module bist(
  input clk, rst_b,
  output [3:0] sig
);

wire [4:0] q;
wire o;

lfsr5b circ1(
  .clk(clk),
  .rst_b(rst_b),
  .q(q)
);

check circ2(
  .i(q),
  .o(o)
);

sisr4b circ3(
  .clk(clk),
  .rst_b(rst_b),
  .i(i),
  .q(sig)
);

endmodule

module bist_tb;
reg clk, rst_b;
wire [3:0] sig;

bist cut(
  .clk(clk),
  .rst_b(rst_b),
  .sig(sig)
);

initial begin
  clk = 0;
  rst_b = 0;
end

integer i;
initial begin
  for(i = 1; i <= 62; i = i + 1) begin
    #50; clk = ~clk;
  end
end

initial begin
  #25; rst_b = 1;
end

endmodule