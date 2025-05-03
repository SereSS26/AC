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
module lss5b(
  input clk,rst,
  output [4:0] q
  );
  
  generate
     genvar k;
     for(k=0;k<5;k=k+1)begin:v
	   if(k==0)
	   generator G(
	     .clk(clk),
	     .rst(1'b1),
	     .s(rst),
	     .d(q[4]),
	     .q(q[0])
	     );
	   else if(k==3)
	   generator G(
	     .clk(clk),
	     .rst(1'b1),
	     .s(rst),
	     .d(q[k-1]|q[4]),
	     .q(q[k])
	     );
	   else if(k==4)
	     generator G(
	     .clk(clk),
	     .rst(1'b1),
	     .s(rst),
	     .d(q[k-1]^q[4]),
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

module lss5b_tb;
  reg clk,rst;
  wire[4:0] q;
  
  lss5b uut(
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
  
  