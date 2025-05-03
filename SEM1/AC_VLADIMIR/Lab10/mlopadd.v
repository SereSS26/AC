module rgst #(
    parameter w=8
)(
    input clk, rst_b, ld, clr, 
    input [w-1:0] d, 
    output reg [w-1:0] q
);
    always @ (posedge clk, negedge rst_b)
        if (!rst_b)                 q <= 0;
        else if (clr)               q <= 0;
        else if (ld)                q <= d;
endmodule

module mlopadd(
  input clk, rst_b,
  input [9:0] x,
  output [15:0] a
);

wire [9:0] temp;

rgst #(.w(10)) REG1 (
  .clk(clk),
  .rst_b(rst_b),
  .ld(1'b1),
  .clr(1'b0),
  .d(x),
  .q(temp)
);

rgst #(.w(16)) REG2 (
  .clk(clk),
  .rst_b(rst_b),
  .ld(1'b1),
  .clr(1'b0),
  .d(temp + a),
  .q(a)
);

endmodule

module mlopadd_tb;
reg clk, rst_b;
reg [9:0] x;
wire [15:0] a;

mlopadd cut(
  .clk(clk),
  .rst_b(rst_b),
  .x(x),
  .a(a)
);

initial begin
  clk = 0;
  rst_b = 0;
end

integer i;
initial begin
  for(i = 1; i <= 202; i = i + 1) begin
    #50; clk = ~clk;
  end
end

integer j;
initial begin
  for(j = 0; j <= 99; j = j + 1) begin
    x = 2 * j + 1; # 100;
  end
end

initial begin
  #25; rst_b = 1;
end

endmodule