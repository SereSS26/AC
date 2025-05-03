module seq3b (
  input [3:0] i,
  output reg o
);
  integer j;
  integer aux;
  integer count;
  integer ok;
  always @(*) begin
    aux=0;
    count=1;
    aux=i[0];
    ok=0;
    for(j=1;j<4;j=j+1) begin
      if(i[j]==aux)
        count=count+1;
      if(count>=3)
        ok=1;
      if(i[j]!=aux) begin
        aux=i[j];
        count=1;
      end
    end
    o=ok;
  end
        
endmodule

module seq3b_tb;
  reg [3:0] i;
  wire o;

  seq3b seq3b_i (.i(i), .o(o));

  integer k;
  initial begin
    $display("Time\ti\t\to");
    $monitor("%0t\t%b(%2d)\t%b", $time, i, i, o);
    i = 0;
    for (k = 1; k < 16; k = k + 1)
      #10 i = k;
  end
endmodule