module ex2 (
	input [2:0]i,
	output reg o
);
	///assign o = (i==3'b011)||(i==3'b111);
	always @(*)begin
	  if(i == 3'b011 || i == 3'b111)
	    o = 1;
	  else
	    o = 0;
	 end
endmodule

module ex2_tb;
	reg [2:0] i;
	wire o;

	ex2 ex2_i (.i(i), .o(o));

	integer k;
	initial begin
		$display("Time\ti\to");
		$monitor("%0t\t%b\t%b", $time, i, o);
		i = 0;
		for (k = 1; k < 8; k = k + 1)
			#10 i = k;
	end
endmodule