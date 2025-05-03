module dff_ar(
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
module reg_parl(
  input clk,rst,
  output [3:0] q
  );
  
  dff_ar G0(
    .clk(clk),
    .rst(1'b1),
    .s(rst),
    .d(q[3]),
    .q(q[0])
    );
  dff_ar G1(
    .clk(clk),
    .rst(1'b1),
    .s(rst),
    .d(q[0]^q[3]),
    .q(q[1])
    );
  dff_ar G2(
    .clk(clk),
    .rst(1'b1),
    .s(rst),
    .d(q[1]^q[3]),
    .q(q[2])
    );
  dff_ar G3(
    .clk(clk),
    .rst(1'b1),
    .s(rst),
    .d(q[2]^q[3]),
    .q(q[3])
    );
endmodule

module reg_parl_tb;
  reg clk,rst;
  wire[3:0] q;
  
  reg_parl uut(
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
  
  