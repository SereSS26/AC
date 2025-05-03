module patt(
  input i, clk, rst_b,
  output reg o
);

localparam S0_ST = 2'b00;
localparam S1_ST = 2'b01;
localparam S2_ST = 2'b10;
localparam S3_ST = 2'b11;

reg [1:0] st, st_nxt;

always @(*) begin
  case(st)
    S0_ST: if(i == 0) st_nxt = S0_ST; else st_nxt = S1_ST;
    S1_ST: if(i == 0) st_nxt = S2_ST; else st_nxt = S1_ST;
    S2_ST: if(i == 0) st_nxt = S0_ST; else st_nxt = S3_ST;
    S3_ST: if(i == 0) st_nxt = S0_ST; else st_nxt = S1_ST;
  endcase
end

always @(*) begin
  o = 0;
  case(st)
    S0_ST: if(i == 0) o = 0; else o = 0;
    S1_ST: if(i == 0) o = 0; else o = 0;
    S2_ST: if(i == 0) o = 0; else o = 0;
    S3_ST: if(i == 0) o = 0; else o = 1;
  endcase
end

always @(posedge clk or negedge rst_b) begin
  if(!rst_b) st <= S0_ST;
else st <= st_nxt;
end

endmodule

module patt_tb;
reg clk, rst_b, i;
wire o;

patt cut(
  .clk(clk),
  .rst_b(rst_b),
  .i(i),
  .o(o)
);  

initial begin
  clk = 0;
  rst_b = 0;
  i = 1;
end

integer c;

initial begin
  for(c = 1; c <=15; c = c + 1) begin
    #50; clk = ~clk;
  end
end

initial begin
  #25; rst_b = 1;
end

initial begin
  #100; i = 0;
  #100; i = 1;
  #200; i = 0;
  #100; i = 1;
end

endmodule