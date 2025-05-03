module reg_m(
  input clk, rst_b, ld_ibus, [7:0] ibus,
  output reg [7:0] q
);

always @(posedge clk or negedge rst_b)
  if(!rst_b) q <= 0;
  else if(ld_ibus) q <= ibus;
endmodule