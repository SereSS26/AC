module mux_2s #(
  parameter w = 4
)(
  input [w-1:0] d0, d1, d2, d3,
  input [1:0] s,
  output reg [w-1:0] o
);

assign o = (s == 2'b00) ? d0 : {w{1'bz}};
assign o = (s == 2'b01) ? d1 : {w{1'bz}};
assign o = (s == 2'b10) ? d2 : {w{1'bz}};
assign o = (s == 2'b11) ? d3 : {w{1'bz}};
  
endmodule