module sisr4b (
    input wire clk,     
    input wire rst_b,   
    input wire i,       
    output reg [4:0] q  
);

   generate
     genvar k;
     for(k=0;k<4;k=k+1) begin:v
       if(k==0)
         d_ff gu(.clk(clk),.rst_b(1'd1),.d(i^q[4]),.q(q[k]);
       else if(k==1)
         d_ff gu(.clk(clk),.rst_b(1'd1),.d(q[0]^q[3]),.q[q[k]);
      else
        d_ff gu(.clk(clk),.rst(1'd1),.d(q[k-1],.q[q[k]);
      end
    endgenerate
  endmodule
endmodule


