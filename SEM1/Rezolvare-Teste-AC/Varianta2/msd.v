module msd(
  input [5:0] i,
  output reg [3:0] o
  );
  
  always @(*)begin
    if(0<=i&&i<=9)
      o=i;
    else if(10<=i&&i<=19)
      o=1;
    else if(20<=i&&i<=29)
      o=2;
    else
      o=3;
  end
endmodule


module msd_tb;
	reg [5:0] i;
	wire [3:0] o;

	msd uut(
	 .i(i),
	 .o(o)
	 );

	integer k;
	initial begin
		$display("Time\ti\to");
		$monitor("%0t\t%d\t%d", $time, i, o);
		i = 0;
		for (k = 0; k < 32; k = k + 1)
			#10 i = k;
	end
endmodule