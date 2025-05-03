module mul4(
  input [3:0] i,
  output reg o
);
  integer aux;
  always @(*) begin
    aux=i;
    o=0;
    while(aux>=4)
    begin
      aux=aux-4;
    end
    if(aux==0)
      o=1;
  end
    
endmodule

module mul4_tb;
  reg [3:0] i;
  wire o;

  mul4 uut (.i(i), .o(o));

  integer k;
  initial begin
    $display("Time\ti\t\to");
    $monitor("%0t\t%b(%2d)\t%b", $time, i, i, o);
    i = 0;
    for (k = 1; k < 16; k = k + 1)
      #10 i = k;
  end
endmodule