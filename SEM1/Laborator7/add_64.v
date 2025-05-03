module add_64 (
    input [63:0] a,  
    input [63:0] b,   
    output reg [63:0] sum
);

    always@(*) begin
     sum = a + b;  
   end  

endmodule
