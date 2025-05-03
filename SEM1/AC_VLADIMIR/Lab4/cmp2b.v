module cmp2b(
  input [1:0] x, y,
  output reg eq, lt, gt
);

always @(*) begin
  if(x == y) begin
    eq = 1;
    lt = 0;
    gt = 0;
  end
  else if(x < y) begin
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