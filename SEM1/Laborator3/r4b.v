module r4b (
  input clk, rst_b, ld, sh, sh_in,
  input [3:0] d,
  output reg [3:0] q
);
  always @(posedge clk,negedge rst_b) begin
    if(rst_b==0)
      q <=4'b0000;
    else begin
      if(ld==1)
        q <=d;
      if(sh==1)
        q <=(q>>1)|(sh_in<<3);
    end
  end
endmodule

module r4b_tb;
  reg clk, rst_b, ld, sh, sh_in;
  reg [3:0] d;
  wire [3:0] q;

  r4b r4b_i (.clk(clk), .rst_b(rst_b), .ld(ld), .sh(sh), .sh_in(sh_in), .d(d), .q(q));

  initial begin
    {clk, rst_b} = 0;
    #5 rst_b = 1;
    #45 clk = 1;
    repeat (40)
      #50 clk = ~clk;
  end

  integer k, l;
  initial begin
    $display("Time\top\td\tsh_in\tq");
    {d, sh_in} = 0; {ld, sh} = 0;
    for (k = 0; k < 32; k = k + 1) begin
      $display("%0t\t%s\t%b\t%b\t%b", $time, (ld) ? "LOAD" : (sh) ? "SHIFT" : "NO_OP", d, sh_in, q);
      #100 l = $urandom; {d, sh_in} = l[6:2]; {ld, sh} = l[1:0] % 3;
    end
    $display("%0t\t%s\t%b\t%b\t%b", $time, (ld) ? "LOAD" : (sh) ? "SHIFT" : "NO_OP", d, sh_in, q);
  end
endmodule
