module c1_add4b(
  input [3:0] x, y,
  input ci,
  output [3:0] z
);

wire [4:0] sum;

assign sum = x + y + ci;
assign z = sum[3:0] + sum[4];

endmodule

module c1add4b_tb;
  reg [3:0] x, y;
  reg ci;
  wire [3:0] z;
  
  c1_add4b cut(
    .x(x),
    .y(y),
    .ci(ci),
    .z(z)
  );
  
  integer i;
  initial begin
    for(i = 0; i < 512;i = i + 1) begin
      {x,y,ci} = i;
      #20;
    end
  end
endmodule