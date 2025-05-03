module switch(
  input [7:0] i,
  output reg [7:0] o
  );
  
  integer k;
  reg ok;
  always @(*) begin
    ok=0;
    for(k=0;k<7;k=k+1)begin
      if(i[k]!=i[k+1])
        ok=1;
    end
  
    if(ok==1)begin
      o[7:4]=i[3:0];
      o[3:0]=i[7:4];
    end
    else begin
      for(k=0;k<7;k=k+1)begin
        o[k]=i[7-k];
      end
    end
  end
endmodule

module switch_tb;
  reg [7:0] i;
  wire [7:0] o;
  
  switch uut(
  .i(i),
  .o(o)
  );
  
  initial begin
    i=8'b10101010;
    #10;
    $display("Input: %b, Output: %b", i, o);
    i=8'b11110000;
    #10;
    $display("Input: %b, Output: %b", i, o);
    i=8'b11111110;
    #10;
    $display("Input: %b, Output: %b", i, o);
  end
endmodule