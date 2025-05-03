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

module cmp4b(
  input[3:0]x,
  input[3:0]y,
  output eq,
  output lt,
  output gt
  );
  
  wire eq_low;
  wire lt_low;
  wire gt_low;
  
  wire eq_high;
  wire lt_high;
  wire gt_high;
  
  cmp2b cmp_low(
  .x(x[1:0]),
  .y(y[1:0]),     
  .eq(eq_low),     
  .lt(lt_low),    
  .gt(gt_low)
  );
  
  cmp2b cmp_high(
  .x(x[3:2]),
  .y(y[3:2]),     
  .eq(eq_high),     
  .lt(lt_high),    
  .gt(gt_high)
  );
  
  assign eq=eq_low&eq_high;
  assign lt=lt_high|(eq_high&lt_low);
  assign gt=gt_high|(eq_high&gt_low);
  
endmodule
  
`timescale 1ns/1ps
module cmp4b_tb;
  reg [3:0]x,y;
  wire eq,lt,gt;
  cmp4b uut(
  .x(x),
  .y(y),
  .eq(eq),
  .lt(lt),
  .gt(gt)
  );
  initial begin
  x=4'b0000;
  y=4'b0000;
  
  repeat(256) begin
    #10
    $display("%b %b | %b %b %b", x, y, eq, lt, gt);
     {x,y}={x,y}+1;
  end

end
endmodule
