module fac(
  input x, y, ci,
  output z, co
);

  assign z = x ^ y ^ ci;
  assign co = (x & y) | (x & ci) | (y & ci);

endmodule

module fac_tb;
  reg x, y, ci;
  wire z, co;
  
  fac cut(
    .x(x),
    .y(y),
    .ci(ci),
    .z(z),
    .co(co)
  );
  
  integer i;
  initial begin
    for(i = 0; i < 8; i = i + 1) begin
      {x, y, ci} = i;
      #50;
    end
  end
endmodule