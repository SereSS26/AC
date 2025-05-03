module c1_add4b(
  input [3:0]x,
  input [3:0]y,
  input ci,
  output [3:0]z
  );
  
  wire [4:0]sum;
  
  assign sum={1'b0,x}+{1'b0,y}+ci;
  
  assign z=sum[3:0];
endmodule 

`timescale 1ns/1ps
module c1_add4b_tb;
  reg [3:0]x,y;
  reg ci;
  wire [3:0]z;
  c1_add4b uut(
  .x(x),
  .y(y),
  .ci(ci),
  .z(z)
  );
  initial begin
    x=4'b0000;
    y=4'b0000;
    ci=0;
  
  repeat(256) begin
    #10
    $display("%b %b  %b  | %b  ", x, y, ci, z);
     {x,y,ci}={x,y,ci}+1;
  end
  
end
endmodule