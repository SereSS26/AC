module minimization(
  input i2,i1,i0,
  output o1,o0
  );
  
  assign o1=(i2&~i1)|(~i0);
  assign o0=(i1&~i2)|(i0)|(~i0&~i2&i1);
  
endmodule

module minimization_tb;
	reg i2,i1,i0;
	wire o1,o0;

	minimization uut(
	 .i2(i2),
	 .i1(i1),
	 .i0(i0),
	 .o1(o1),
	 .o0(o0)
	 );

	integer k;
	initial begin
	  $display("Time\ti2 \ti1\ti0\to1\to0");
		$monitor("%0t\t%b\t%b\t%b\t%b\t%b", $time, i2, i1, i0,o1,o0);
		{i2, i1, i0} = 0;
		for (k = 1; k < 8; k = k + 1)
			#10 {i2, i1, i0} = k;
	end
endmodule