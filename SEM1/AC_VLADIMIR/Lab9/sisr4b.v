`include "dff.v"

module sisr4b(
  input clk, rst_b, i,
  output [3:0] q
);

d_ff D0(
  .clk(clk),
  .rst_b(rst_b),
  .set_b(1'b0),
  .d(i ^ q[3]),
  .q(q[0])
);

d_ff D1(
  .clk(clk),
  .rst_b(rst_b),
  .set_b(1'b0),
  .d(q[0] ^ q[3]),
  .q(q[1])
);

d_ff D2(
  .clk(clk),
  .rst_b(rst_b),
  .set_b(1'b0),
  .d(q[1]),
  .q(q[2])
);

d_ff D3(
  .clk(clk),
  .rst_b(rst_b),
  .set_b(1'b0),
  .d(q[2]),
  .q(q[3])
);

endmodule