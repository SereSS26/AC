`include "generator1.v"
module ex_bistabil1(
  input clk,rst,
  output [5:0] q
);

generator1 G0(
  .clk(clk),
  .rst(1'b1),
  .s(rst),
  .d(q[5]),
  .q(q[0])
);
generator1 G1(
  .clk(clk),
  .rst(1'b1),
  .s(rst),
  .d(q[0]^q[5]),
  .q(q[1])
);
generator1 G2(
  .clk(clk),
  .rst(1'b1),
  .s(rst),
  .d(q[1]^q[5]),
  .q(q[2])
);
generator1 G3(
  .clk(clk),
  .rst(1'b1),
  .s(rst),
  .d(q[2]),
  .q(q[3])
);
generator1 G4(
  .clk(clk),
  .rst(1'b1),
  .s(rst),
  .d(q[3]^q[5]),
  .q(q[4])
);
generator1 G5(
  .clk(clk),
  .rst(1'b1),
  .s(rst),
  .d(q[4]),
  .q(q[5])
);
endmodule;

module ex_bistabil_tb1;
  reg clk,rst;
  wire [5:0] q;
  
  ex_bistabil uut(
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
    
