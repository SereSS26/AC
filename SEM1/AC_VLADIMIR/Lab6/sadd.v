module sadd(
  input x, y, clk, rst_b,
  output reg s
);

localparam S0_ST = 0;
localparam S1_ST = 1;

reg st, st_next;

always @(*) begin
  case (st)
    S0_ST: 
      if((x == 1) && (y == 1)) st_next = S1_ST;
      else st_next = S0_ST;
    S1_ST:
      if((x == 0) && (y == 0)) st_next = S0_ST;
      else st_next = S1_ST;
  endcase
end

always @(*) begin
  s = 0;
  case (st)
    S0_ST:
      if((x == 0) && (y == 0)) s = 0;
      else if ((x == 0) && (y == 1)) s = 1;
      else if ((x == 1) && (y == 0)) s = 1;
      else s = 0;
    S1_ST:
      if((x == 0) && (y == 0)) s = 1;
      else if ((x == 0) && (y == 1)) s = 0;
      else if ((x == 1) && (y == 0)) s = 0;
      else s = 1;
  endcase
end

always @(posedge clk or negedge rst_b) begin
  if(!rst_b) st <= S0_ST;
else st <= st_next;
end

endmodule

module sadd_tb;
reg clk, rst_b, x, y;
wire s;

sadd cut(
  .clk(clk),
  .rst_b(rst_b),
  .x(x),
  .y(y),
  .s(s)
);  

initial begin
  clk = 0;
  rst_b = 0;
  x = 0;
  y = 1;  
end

integer i;
initial begin
  for(i = 1; i <=9; i = i + 1) begin
    #50; clk = ~clk;
  end
end

initial begin
  #25; rst_b = 1;
end

initial begin
  #100; x = 1;
  #200; x = 0;
end

initial begin
  #200; y = 0;
end

endmodule


// Logica pentru ieșiri (specifică pentru Moore)
    always @(*) begin
        case (state)
            S3: detected = 1'b1;  // Ieșirea este activă doar în starea S3
            default: detected = 1'b0;  // În toate celelalte stări, ieșirea este 0
        endcase
    end
