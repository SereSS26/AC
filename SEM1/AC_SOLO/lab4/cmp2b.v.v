module cmp2b(
  input [1:0]x,
  input [1:0]y,
  output eq,
  output lt,
  output gt
  );
  
  assign eq=(x==y);
  assign lt=(x<y);
  assign gt=(x>y);
  
endmodule

`timescale 1ns/1ps
module cmp2b_tb;
  reg [1:0]x,y;
  wire eq,lt,gt;
  cmp2b uut(
  .x(x),
  .y(y),
  .eq(eq),
  .lt(lt),
  .gt(gt)
  );
  initial begin
  x=2'b00;
  y=2'b00;
  
  repeat(16) begin
    #10
    $display("%b %b | %b %b %b", x, y, eq, lt, gt);
     {x,y}={x,y}+1;
  end

end
endmodule