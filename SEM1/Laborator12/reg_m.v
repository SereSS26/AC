module reg_m(
  input clk , rst_b , ldibus , [7:0] ibus ,
  output reg [7:0] q
);
   always @(posedge clk ,negedge rst_b )
   if(!rst_b) q <= 0 ;
  else if(ldibus) q <= ibus ;
endmodule