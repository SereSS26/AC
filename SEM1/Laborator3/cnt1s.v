module cnt1s (
  input [5:0] i,
  output reg [2:0] o
);
  integer aux;
  always @(*) begin
    aux=0;
    if(i[0]==1)
      aux=aux+1;
    if(i[1]==1)
      aux=aux+1;
    if(i[2]==1)
      aux=aux+1;
    if(i[3]==1)
      aux=aux+1;
    if(i[4]==1)
      aux=aux+1;
    if(i[5]==1)
      aux=aux+1;
    o =aux;
  end
endmodule

module cnt1s_tb;
  reg [5:0] i;
  wire [2:0] o;

  cnt1s cnt1s_i (.i(i), .o(o));

  integer k;
  initial begin
    $display("Time\ti\t\to");
    $monitor("%0t\t%b(%2d)\t%b(%0d)", $time, i, i, o, o);
    i = 0;
    for (k = 1; k < 64; k = k + 1)
      #10 i = k;
  end
endmodule