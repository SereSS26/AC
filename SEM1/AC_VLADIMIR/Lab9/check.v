module check(
  input [4:0] i,
  output reg o
);

always @(*) begin
  o = 0;
  case(i)
    1,5,9,13,17,21,25,29: o = 1;
    default: o = 0;
  endcase
end

endmodule