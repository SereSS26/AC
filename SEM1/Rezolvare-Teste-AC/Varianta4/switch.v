module switch(
  input [3:0] i,
  output reg [2:0] o
  );
  
  always @(*) begin
    if(i<=3)
      o=(2*i+7)%6;
    if(i>=4&&i<=10)
      o=(3*i+2)%8;
    if(i>=11&&i<=15)
      o=i/3;
  end
endmodule

module switch_tb;
  reg [3:0] i;
  wire [2:0] o;
  
  switch uut(
  .i(i),
  .o(o)
  );
  
  integer k;
	initial begin
		$display("Time\ti\to");
		$monitor("%0t\t%d\t%d", $time, i, o);
		i = 0;
		for (k = 0; k < 16; k = k + 1)
			#10 i = k;
	end
endmodule