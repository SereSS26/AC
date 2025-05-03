module counter #(
  parameter latime = 4,
  parameter start = {latime{1'b0}}
)(
  input clk, rst_b, c_up, clr,
  output reg [latime-1:0] q
);

always @(posedge clk or negedge rst_b) begin
  if(!rst_b)
    q <= start;
  else if(clr)
    q <= start;
  else if(c_up)
    q <= q + 1; 
end

endmodule

module counter_tb;
  reg clk, rst_b, c_up, clr;
  wire [7:0] q;
  
  counter #(
    .latime(8),
    .start(8'hff)
  ) cut (
    .clk(clk),
    .rst_b(rst_b),
    .c_up(c_up),
    .clr(clr),
    .q(q)
  );
  
  initial begin
    clk = 0;
    rst_b = 0;
    c_up = 1;
    clr = 0;
  end
  
  integer i;
  initial begin
    for(i = 1; i <= 14; i=i+1) begin
      #50; clk = ~clk;
    end
  end
  
  initial begin
    #5; rst_b = 1;
  end
  
  initial begin
    #425; c_up = 0;
    #100; c_up = 1;
  end
  
  initial begin
    #225; clr = 1;
    #100; clr = 0;
  end
  
endmodule