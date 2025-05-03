module minimization(
  input i3,i2,i1,i0,
  output o1,o0
  );
  
  assign o0=(~i1&i0)|(i0&~i3);
  assign o1=(~i1&i0)|(~i3&i1&~i0);
  
endmodule

module minimization_tb;
	reg i3,i2,i1,i0;
	wire o1,o0;

	minimization uut(
	 .i3(i3),
	 .i2(i2),
	 .i1(i1),
	 .i0(i0),
	 .o1(o1),
	 .o0(o0)
	 );

	integer k;
	initial begin
		$monitor("%0t\t%b\t%b\t%b\t%b\t%0d\t%b\t%b", $time, i3, i2, i1, i0, {i3,i2,i1,i0}, o1,o0);
		{i3, i2, i1, i0} = 0;
		for (k = 1; k < 10; k = k + 1)
			#10 {i3, i2, i1, i0} = k;
	end
endmodule