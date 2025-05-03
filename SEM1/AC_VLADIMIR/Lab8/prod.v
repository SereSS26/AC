module prod(
  input clk, rst_b,
  output reg val,
  output reg [7:0] data
);

task urand8(output reg [7:0] r);
  begin
    r[7:0] = $urandom;
  end
endtask

task urand8Mod(output reg [7:0] r);
  begin
    r[7:0] = $urandom % 6;
  end
endtask

reg [2:0] randClock, randWait, counterClock, counterWait;

initial begin
  urand8Mod(randClock);
  while(randClock < 3 || randClock > 5) urand8Mod(randClock);
  urand8Mod(randWait);
  while(randWait < 1 || randWait > 4) urand8Mod(randWait);
end

always @(posedge clk or negedge rst_b) begin
  if(!rst_b) begin
    val <= 0;
    data <= 0;
    counterClock <= 0;
    counterWait <= 0;
  end
  else begin
    if(counterClock < randClock) begin
      urand8(data);
      val <= 1;
      counterClock <= counterClock + 1;
    end
    else if(counterWait < randWait) begin
      val <= 0;
      data <= 0;
      counterWait <= counterWait + 1;
    end
    else begin
      urand8Mod(randClock);
      while(randClock < 3 || randClock > 5) urand8Mod(randClock);
      urand8Mod(randWait);
      while(randWait < 1 || randWait > 4) urand8Mod(randWait);
      counterClock <= 0;
      counterWait <= 0;
    end
  end
end

endmodule

module prod_tb;
reg clk, rst_b;
wire [7:0] data;
wire val;

prod cut(
  .clk(clk),
  .rst_b(rst_b),
  .val(val),
  .data(data)
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