module mul4(
  input [3:0] i,
  output reg o
  );
  
  integer aux;
  always @(*) begin
    aux=i;
    while(aux>=4)begin
      aux=aux-4;
    end
    if(aux==0)
      o=1;
    else
      o=0;
  end
endmodule

module mul4_tb;
  reg [3:0] i;
  wire o;
  
  mul4 uut(
  .i(i),
  .o(o)
  );
  
  initial begin
    i=4'b0001;
    #10;
    $display("Input: %b Output: %b", i,o);
    i=4'b1100;
    #10;
    $display("Input: %b, Output: %b", i,o);
    
  end
endmodule
