`include "prod.v"

module cons(
  input clk, rst_b, val,
  input [7:0] data,
  output reg [7:0] sum
);

reg [7:0] anterior;

always @(posedge clk or negedge rst_b) begin
  if(!rst_b) begin sum <= 0; anterior <= 0; end
  else if(val == 1) begin
      if(data >= anterior) begin
        sum <= sum + data;
      end
      anterior <= data;
  end
end

endmodule

module cons_tb;
reg clk, rst_b;
wire [7:0] data, sum;
wire val;

prod circ1(
  .clk(clk),
  .rst_b(rst_b),
  .val(val),
  .data(data)
);

cons circ2(
  .clk(clk),
  .rst_b(rst_b),
  .val(val),
  .data(data),
  .sum(sum)
);

initial begin
  clk = 0;
  rst_b = 0;
end

integer i;
initial begin
  for(i = 1; i <= 200; i = i + 1) begin
    #50; clk = ~clk;
  end
end

initial begin
  #25; rst_b = 1;
end

endmodule