`include "cmp2b.v"

module cmp4b(
  input [3:0] x, y,
  output reg eq, lt, gt
);

wire eql, ltl, gtl, eqh, lth, gth;

cmp2b cmp2bl(
  .x({x[1], x[0]}),
  .y({y[1], y[0]}),
  .eq(eql),
  .lt(ltl),
  .gt(gtl)
);

cmp2b cmp2bh(
  .x({x[3], x[2]}),
  .y({y[3], y[2]}),
  .eq(eqh),
  .lt(lth),
  .gt(gth)
);

always @(*) begin
  if((eql == 1) && (eqh == 1)) begin
    eq = 1;
    lt = 0;
    gt = 0;
  end
  else if((lth == 1) || (eqh == 1 && ltl == 1)) begin
    eq = 0;
    lt = 1;
    gt = 0;
  end
  else begin
    eq = 0;
    lt = 0;
    gt = 1;
  end
end

endmodule

module cmp4b_tb;
  reg [3:0] x, y;
  wire eq, lt, gt;
  
  cmp4b cut(
    .x(x),
    .y(y),
    .eq(eq),
    .lt(lt),
    .gt(gt)
  );
  
  integer i;
  initial begin
    for(i = 0; i < 256; i = i + 1) begin
      {x, y} = i;
      #50;
    end
  end
endmodule