module switch(
  input [7:0] x,
  input [7:0] y,
  output reg [15:0] o
  );
  
  always @(*) begin
    if(x[7]==y[7])begin
      o={y[3:0],x[3:0],y[7:4],x[7:4]};
    end
    else begin
      o={x[7:4],y[7:4],x[3:0],y[3:0]}; 
    end
  end
endmodule

module switch_tb;
  reg [7:0] x;
  reg [7:0] y;
  wire [15:0] o;
  
  switch uut(
  .x(x),
  .y(y),
  .o(o)
  );
  
  initial begin
    x=8'b00000000;
    y=8'b11111111;
    #10;
    $display("Input: %b %b, Output: %b", x,y,o);
    x=8'b10000000;
    y=8'b11111111;
    #10;
    $display("Input: %b %b, Output: %b", x,y, o);
    
  end
endmodule