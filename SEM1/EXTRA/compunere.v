module generator(
  input clk,rst,s,d,
  output reg q
  );
  
  always @(posedge clk or negedge rst or negedge s)begin
    if(!s)
      q<=1;
    else if(!rst)
      q<=0;
    else
      q<=d;
  end
endmodule
module lfsr(
  input clk,rst,
  output [3:0] q
  );
  
  generate
     genvar k;
     for(k=0;k<4;k=k+1)begin:v
	   if(k==0)
	   generator G(
	     .clk(clk),
	     .rst(1'b1),
	     .s(rst),
	     .d(q[3]),
	     .q(q[0])
	     );
	   else if(k==1||k==3)
	   generator G(
	     .clk(clk),
	     .rst(1'b1),
	     .s(rst),
	     .d(q[k-1]^q[3]),
	     .q(q[k])
	     );
	   else
	   generator G(
	     .clk(clk),
	     .rst(1'b1),
	     .s(rst),
	     .d(q[k-1]),
	     .q(q[k])
	     );
     end 
    endgenerate
  
endmodule

module minimization(
  input i3,i2,i1,i0,
  output o2,o1,o0
  );
  
  assign o2=(~i1&i0)|(i1&~i0);
  assign o1=(~i1&~i0)|(i1&i0);
  assign o0=(i0);
  
endmodule

module rgst #(
    parameter w=8
)(
    input clk, rst, input [w-1:0] d, output reg [w-1:0] q
);
    always @ (posedge clk, negedge rst)
        if (!rst)                 q <= 0;
        else                 q <= d;
endmodule

module compunere(
  input clk,
  input rst,
  output [2:0] q
  );
  
  wire [3:0] q1;
  wire [2:0] q2;
  lfsr tpg(
    .clk(clk),
    .rst(rst),
    .q(q1)
    );
  minimization dut(
    .i3(q1[3]),
    .i2(q1[2]),
    .i1(q1[1]),
    .i0(q1[0]),
    .o2(q[2]),
    .o1(q[1]),
    .o0(q[0])
    );
   rgst #(3) reg0 (
        .clk(clk),
        .rst(rst),                            
        .d(q2),             
        .q(q)                   
    );
  endmodule
  module compunere_tb;
  reg clk,rst;
  wire[2:0] q;
  
  lfsr uut(
    .clk(clk),
    .rst(rst),
    .q(q)
    );
  localparam CLK_PERIOD = 100;
  localparam RUNNING_CYCLES = 50;
    initial begin
        clk = 1'd0;
        repeat (2*RUNNING_CYCLES) #(CLK_PERIOD/2) clk = ~clk;
    end
    
  localparam RST_DURATION = 25;
    initial begin
      rst = 1'd0;
      #RST_DURATION rst = 1'd1;
    end
  initial begin
      $monitor("Timp: %0t | q = %b", $time, q);
  end
    
endmodule
  