module fac (
    input x,    
    input y,   
    input ci,   
    output z,   
    output co   
);
    assign z = x ^ y ^ ci;
    assign co = (x & y) | (x & ci) | (y & ci);
endmodule


module fac_tb;
  reg x, y, ci;  
  wire z, co;   
  
  fac fac_i (
    .x(x), 
    .y(y), 
    .ci(ci), 
    .z(z), 
    .co(co)
  );

  integer k;
  initial begin
    $display("Time\tx y ci\tz co");
    $monitor("%0t\t%b %b %b\t%b %b", $time, x, y, ci, z, co);
    
    x = 0; y = 0; ci = 0;
    
    for (k = 0; k < 8; k = k + 1) begin
        {x, y, ci} = k; 
        #10; 
    end
  end
endmodule
