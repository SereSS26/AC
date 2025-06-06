module ex1d (
	input a, b, c, d,
	output f4
);
	assign f4=(~c&d)|(a&b)|(b&~c);
endmodule

module ex1d_tb;
	reg a, b, c, d;
	wire f4;

	ex1d ex1d_i (.a(a), .b(b), .c(c), .d(d), .f4(f4));

	integer k;
	initial begin
		$display("Time\ta\tb\tc\td\tabcd_10\tf4");
		$monitor("%0t\t%b\t%b\t%b\t%b\t%0d\t%b", $time, a, b, c, d, {a,b,c,d}, f4);
		{a, b, c, d} = 0;
		for (k = 1; k < 16; k = k + 1)
			#10 {a, b, c, d} = k;
	end
endmodule