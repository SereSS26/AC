module ex3 (
	input [3:0] i,
	output reg [3:0] o
);
	always @(*) begin
	  case(i)
	    4'b0000: o=4'b0000;
	    4'b0001: o=4'b0111;
	    4'b0010: o=4'b0110;
	    4'b0011: o=4'b0101;
	    4'b0100: o=4'b0100;
	    4'b0101: o=4'b1011;
	    4'b0110: o=4'b1010;
	    4'b0111: o=4'b1001;
	    4'b1000: o=4'b1000;
	    4'b1001: o=4'b1111;
	    default: o=4'b0000;
	   endcase
	  end
endmodule

module ex3_tb;
	reg [3:0] i;
	wire [3:0] o;

	ex3 ex3_i (.i(i), .o(o));

	integer k;
	initial begin
		$display("Time\ti\to");
		$monitor("%0t\t%b\t%b", $time, i, o);
		i = 0;
		for (k = 1; k < 10; k = k + 1)
			#10 i = k;
	end
endmodule