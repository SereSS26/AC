module mlopadd(
  input clk, 
  input rst_b,
  input [9:0] i,
  output [15:0] a
);

wire [9:0] temp;

rgst #(.w(10)) reg1 (
  .clk(clk),
  .rst_b(rst_b),
  .ld(1'b1),
  .clr(1'b0),
  .d(i),
  .q(temp)
);

rgst #(.w(16)) reg2 (
  .clk(clk),
  .rst_b(rst_b),
  .ld(1'b1),
  .clr(1'b0),
  .d(temp + a),
  .q(a)
);

endmodule

module mlopadd_tb;

  reg clk;
  reg rst_b;
  reg [9:0] i;
  wire [15:0] a; 

  mlopadd uut (
    .clk(clk),
    .rst_b(rst_b),
    .i(i),
    .a(a)
  );
  localparam CLK_PERIOD = 100;
    localparam RUNNING_CYCLES = 101;
    initial begin
        clk = 1'd0;
        repeat (2*RUNNING_CYCLES) #(CLK_PERIOD/2) clk = ~clk;
    end
    
    localparam RST_DURATION = 25;
    initial begin
      rst_b = 1'd0;
      #RST_DURATION rst_b = 1'd1;
    end
    
    integer k;
    initial begin
      for(k = 0; k <= 99; k = k + 1) begin
        i = 2 * k + 1; # 100;
      end
    end

    initial begin
        $monitor("Timpul: %0t | Suma: %d", $time, a);
    end
endmodule

/*module mlopadd (
    input clk,
    input rst_b,
    output reg [13:0] a 
);

    reg [6:0] i; 

    always @(posedge clk or negedge rst_b) begin
      if (!rst_b) begin
        a <= 0;      
        i <= 0;      
      end else if (i < 100) begin
        a <= a + (2 * i + 1);  
        i <= i + 1;            
      end
    end
  endmodule

module mlopadd_tb;

  reg clk;
  reg rst_b;
  wire [13:0] a; 

  mlopadd uut (
    .clk(clk),
    .rst_b(rst_b),
    .a(a)
  );
  localparam CLK_PERIOD = 100;
    localparam RUNNING_CYCLES = 100;
    initial begin
        clk = 1'd0;
        repeat (2*RUNNING_CYCLES) #(CLK_PERIOD/2) clk = ~clk;
    end
    
    localparam RST_DURATION = 25;
    initial begin
      rst_b = 1'd0;
      #RST_DURATION rst_b = 1'd1;
    end

    initial begin
        $monitor("Timpul: %0t | Suma: %d", $time, a);
    end
endmodule*/

