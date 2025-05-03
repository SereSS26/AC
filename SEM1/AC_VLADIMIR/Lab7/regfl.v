module dec #(parameter w=2)(
	input [w-1:0] s,
	input e,
	output reg [2**w-1:0] o
);
	always @ (*) begin
		o = 0;
		if (e)
  		  o[s] = 1;
	end
endmodule

module rgst #(parameter w=8)(
    input clk, rst_b, ld, clr, 
    input [w-1:0] d, 
    output reg [w-1:0] q
);
    always @ (posedge clk, negedge rst_b)
        if (!rst_b)                 q <= 0;
        else if (clr)               q <= 0;
        else if (ld)                q <= d;
endmodule

module regfl(
  input [63:0] d,
  input [2:0] s,
  input we, clk, rst_b,
  output [511:0] q
);

wire [7:0] o;

dec #(.w(3)) 
DEC(
  .s(s),
  .e(we),
  .o(o)
);

genvar i;

generate
  for(i = 0; i < 8; i = i + 1) begin
    rgst #(.w(64))
    REG(
      .ld(o[i]),
      .d(d),
      .clk(clk),
      .rst_b(rst_b),
      .clr(1'b0),
      .q(q[((64*(8-i))-1) : ((64*(7-i)))])
    );
  end
endgenerate

endmodule

module regfl_tb;
reg [63:0] d;
reg [2:0] s;
reg we, clk, rst_b;
wire [511:0] q;

task urand64(output reg [63:0] r);
  begin
    r[63:32] = $urandom;
    r[31:0] = $urandom;
  end
endtask

regfl cut(
  .d(d),
  .s(s),
  .we(we),
  .clk(clk),
  .rst_b(rst_b),
  .q(q)
);

initial begin
  clk = 0;
  rst_b = 0;
  we = 1;
  urand64(s);
  urand64(d);
end

integer i;
initial begin
  for(i = 1; i <= 26; i = i + 1) begin
    #50; clk = ~clk;
  end
end

initial begin
  #25; rst_b = 1;
end

initial begin
  #600; we = 0;
  #100; we = 1;
end

integer j;
initial begin
  for(j = 1; j <= 12; j = j + 1) begin
    #100; urand64(s); urand64(d);
  end
end

endmodule