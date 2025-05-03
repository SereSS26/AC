`include "d_ff.v"

module lfsr5b(
  input clk, rst_b,
  output [4:0] q
);

d_ff D0(
  .clk(clk),
  .rst_b(1'b1),
  .set_b(rst_b),
  .d(q[4]),
  .q(q[0])
);

d_ff D1(
  .clk(clk),
  .rst_b(1'b1),
  .set_b(rst_b),
  .d(q[0]),
  .q(q[1])
);

d_ff D2(
  .clk(clk),
  .rst_b(1'b1),
  .set_b(rst_b),
  .d(q[4] ^ q[1]),
  .q(q[2])
);

d_ff D3(
  .clk(clk),
  .rst_b(1'b1),
  .set_b(rst_b),
  .d(q[2]),
  .q(q[3])
);

d_ff D4(
  .clk(clk),
  .rst_b(1'b1),
  .set_b(rst_b),
  .d(q[3]),
  .q(q[4])
);

endmodule

module lfsr5b_tb;
reg clk, rst_b;
wire [4:0] q;

lfsr5b cut(
  .clk(clk),
  .rst_b(rst_b),
  .q(q)
);

initial begin
  clk = 0;
  rst_b = 0;
end

integer i;
initial begin
  for(i = 1; i <= 70; i = i + 1) begin
    #50; clk = ~clk;
  end
end

initial begin
  #25; rst_b = 1;
end

initial begin
      $monitor("Timp: %0t | q = %b", $time, q);
  end
endmodule
