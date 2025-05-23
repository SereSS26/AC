module ex1b (
	input a, b, c, d,
	output f2
);
	assign f2=(b&d)|(~c&d)|(a&~b);
endmodule

module ex1b_tb;
	reg a, b, c, d;
	wire f2;

	ex1b ex1b_i (.a(a), .b(b), .c(c), .d(d), .f2(f2));

	integer k;
	initial begin
		$display("Time\ta\tb\tc\td\tabcd_10\tf2");
		$monitor("%0t\t%b\t%b\t%b\t%b\t%0d\t%b", $time, a, b, c, d, {a,b,c,d}, f2);
		{a, b, c, d} = 0;
		for (k = 1; k < 16; k = k + 1)
			#10 {a, b, c, d} = k;
	end
endmodule