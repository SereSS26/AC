`include "reg_a.v"
`include "reg_q.v"
`include "reg_m.v"
`include "ctrl_u.v"

module full_adder (
  input a, b, cin,
  output sum, cout
);
  assign sum = a ^ b ^ cin;
  assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module parallel_adder(
  input [6:0] a, b,
  input cin,
  output [6:0] sum,
  output cout
);
  wire [6:0] carry;

  full_adder fa0 (a[0], b[0], cin, sum[0], carry[0]);
  full_adder fa1 (a[1], b[1], carry[0], sum[1], carry[1]);
  full_adder fa2 (a[2], b[2], carry[1], sum[2], carry[2]);
  full_adder fa3 (a[3], b[3], carry[2], sum[3], carry[3]);
  full_adder fa4 (a[4], b[4], carry[3], sum[4], carry[4]);
  full_adder fa5 (a[5], b[5], carry[4], sum[5], carry[5]);
  full_adder fa6 (a[6], b[6], carry[5], sum[6], cout);
endmodule

module cntr #(parameter w=8)(
    input clk, rst_b, c_up, clr,
    output reg [w-1:0] q
);
    always @ (posedge clk, negedge rst_b)
        if (!rst_b)					q <= 0;
        else if (c_up)				q <= q+1;
        else if (clr)				q <= 0;
endmodule

module sm_unit (
	input clk, rst_b, bgn, [7:0] ibus,
	output fin, [7:0] obus
);
  //implementation here
  
  wire [7:0] A, Q, M;
  wire [2:0] COUNTER;
  wire c0, c1, c2, c3, c4, c5, c6, cout;
  wire [6:0] sum;
  
  reg_a circ1(
    .clr(c0),
    .ld_sum(c2),
    .ld_sgn(c4),
    .sh_r(c3),
    .clk(clk),
    .rst_b(rst_b),
    .ld_obus(c5),
    .sh_i(1'b0),
    .sgn(Q[0] ^ M[7]),
    .sum({cout, sum}),
    .obus(obus),
    .q(A)
  );
  
  reg_q circ2(
    .clk(clk),
    .rst_b(rst_b),
    .clr_lsb(c4),
    .ld_ibus(c1),
    .ld_obus(c6),
    .sh_r(c3),
    .sh_i(A[0]),
    .ibus(ibus),
    .obus(obus),
    .q(Q)
  );
  
  reg_m circ3(
    .clk(clk),
    .rst_b(rst_b),
    .ld_ibus(c0),
    .ibus(ibus),
    .q(M)
  );
  
  parallel_adder circ4(
    .a(A[6:0]),
    .b(M[6:0]),
    .cin(1'b0),
    .sum(sum),
    .cout(cout)
  );
  
  cntr #(.w(3))circ5(
    .clk(clk),
    .rst_b(rst_b),
    .c_up(c3),
    .clr(c0),
    .q(COUNTER)
  );
  
  ctrl_u circ6(
    .clk(clk),
    .rst_b(rst_b),
    .bgn(bgn),
    .q_0(Q[0]),
    .cnt_is_7(COUNTER[2] & COUNTER[1] & COUNTER[0]),
    .c0(c0),
    .c1(c1),
    .c2(c2),
    .c3(c3),
    .c4(c4),
    .c5(c5),
    .c6(c6),
    .fin(fin)
  );
  
endmodule

module sm_unit_tb;
    reg clk, rst_b, bgn; reg [7:0] ibus; wire fin; wire [7:0] obus;

    sm_unit test (.clk(clk), .rst_b(rst_b), .bgn(bgn), .ibus(ibus),
        .fin(fin), .obus(obus));
    localparam CLK_PERIOD=100, CLK_CYCLES=17, RST_PULSE=25;
    localparam X=8'b10010111/*=-23*2^(-7)*/, Y=8'b10000011;/*=-3*2^(-7)*/
    initial begin clk=1'd0; repeat (CLK_CYCLES*2) #(CLK_PERIOD/2) clk=~clk; end
    initial begin rst_b=1'd0; #(RST_PULSE); rst_b=1'd1; end
    initial begin bgn=1'd1; #200; bgn=1'd0; end
    initial begin ibus=0; #100 ibus=X; #100 ibus=Y; end
endmodule