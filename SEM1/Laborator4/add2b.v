module add2b (
  input [1:0] x,    
  input [1:0] y,    
  input ci,         
  output [1:0] s,   
  output co         
);
  wire carry1;  

  fac fac0 (
    .x(x[0]), 
    .y(y[0]), 
    .ci(ci),     
    .z(s[0]),    
    .co(carry1)  
  );

  fac fac1 (
    .x(x[1]), 
    .y(y[1]), 
    .ci(carry1), 
    .z(s[1]),    
    .co(co)      
  );
endmodule

module add2b_tb;
  reg [1:0] x, y;   
  reg ci;           
  wire [1:0] s;     
  wire co;          

  add2b uut (       
    .x(x), 
    .y(y), 
    .ci(ci), 
    .s(s), 
    .co(co)
  );
  integer i; 
  
  initial begin
    $display("Time\t x   y   ci\t s  co");  
    $monitor("%0t\t%b %b %b\t%b %b", $time, x, y, ci, s, co);
    
    for (i = 0; i < 32; i = i + 1) begin
      {x, y, ci} = i;  
      #10;             
    end      
  end
endmodule
