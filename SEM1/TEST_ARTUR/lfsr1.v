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
     for(k=0;k<3;k=k+1)begin:v
	   if(k==0)
	   generator G(
	     .clk(clk),
	     .rst(1'b1),
	     .s(~q[0]),
	     .d(q[3]),
	     .q(q[0])
	     );
	   else if(k==1)
	   generator G(
	     .clk(clk),
	     .rst(1'b1),
	     .s(~q[1]),
	     .d((q[1]&~q[0])|(q[0]&~q[1]&~q[3])),
	     .q(q[1])
	     );
	    else if(k==2)
	      generator G(
	     .clk(clk),
	     .rst(1'b1),
	     .s(~q[2]),
	     .d((q[2]&~q[1])|(q[2]&~q[0])|(q[0]&q[1]&~q[2])),
	     .q(q[2])
	     );
	   else if(k==3)
	   generator G(
	     .clk(clk),
	     .rst(1'b1),
	     .s(~q[3]),
	     .d((q[3]&~q[0])|(q[2]&q[1]&q[0])),
	     .q(q[3])
	     );
     end 
    endgenerate
  
endmodule

module lfsr1_tb;
  reg clk,rst;
  wire[3:0] q;
  
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
  
  