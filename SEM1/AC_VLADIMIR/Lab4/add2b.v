`include "fac.v"

module add2b(
  input [1:0] x, y,
  input ci,
  output [1:0] z,
  output co
);

wire coInt;

fac fac1(
  .x(x[0]),
  .y(y[0]),
  .ci(ci),
  .z(z[0]),
  .co(coInt)
);

fac fac2(
  .x(x[1]),
  .y(y[1]),
  .ci(coInt),
  .z(z[1]),
  .co(co)
);
endmodule

module add2b_tb;
  reg [1:0] x, y;
  reg ci;
  wire [1:0] z;
  wire co;
  
  add2b cut(
    .x(x),
    .y(y),
    .ci(ci),
    .z(z),
    .co(co)
  );
  
  integer i;
  initial begin
    for(i = 0; i < 32; i = i + 1) begin
      {x, y, ci} = i;
      #50;
    end
  end
endmodule