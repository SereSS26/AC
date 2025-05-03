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

module div_by_6(
  input clr, c_up, clk, rst_b,
  output dclk
);

wire [2:0] q;

rgst #(.w(3)) REG(
  .clk(clk),
  .rst_b(rst_b),
  .ld(c_up),
  .clr(clr | (q[2]&q[0])),
  .d({q[2] ^ (q[1] & q[0]), q[1] ^ q[0], ~q[0]}),
  .q(q)
);

assign dclk = ~(q[2] | q[1] | q[0]);

endmodule

module div_by_6_tb;
reg clk, rst_b, clr, c_up;
wire dclk;

div_by_6 uut(
  .clr(clr),
  .c_up(c_up),
  .clk(clk),
  .rst_b(rst_b),
  .dclk(dclk)
);

initial begin
  clk = 0;
  rst_b = 0;
  clr = 0;
  c_up = 1;
end

integer i;
initial begin
  for(i = 1; i <= 30; i = i + 1) begin
    #50; clk = ~clk;
  end
end

initial begin
  #25; rst_b = 1;
end

initial begin
  #700; clr = 1;
  #100; clr = 0;
  #600; clr = 1;
  #100; clr = 0;
end

 initial begin
    $monitor("Timp: %t | clk: %b | rst_b: %b | clr: %b | c_up: %b | dclk: %b", $time, clk, rst_b, clr, c_up, dclk);
  end


endmodule
  
  