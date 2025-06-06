`define S0 2'b00  //asteptare
`define S1 2'b01 //starea cand genreaza data
`define S2 2'b10  // starea de pauza

module prod(
  input clk,
  input rst_b,
  output reg val, 
  output reg [7:0]data
  
  );

reg [1:0] state_next,state_reg;
reg [2:0] valid_count, pause_count;

always @(posedge clk or negedge rst_b) begin
  if(rst_b==0) begin
    state_reg<=`S0;
    valid_count<=0;
    pause_count<=0;
    val<=0;
    data<=0;
  end
else begin
state_reg<=state_next;
end

  case(state_reg)
    `S0:begin
      val<=0;
      if(pause_count==0)begin
        valid_count<=$urandom_range(3, 5); //fixam secventa la un nr intre 3-5 cicluri 
        state_next<=`S1;
      end
    else
      begin
        pause_count<=pause_count-1;
      end
    end
    
    `S1:begin
      val<=1;
      data<=$urandom_range(0, 5);
      if(valid_count==1) begin
        pause_count<=$urandom_range(1, 4);
        state_next<=`S2;
    end
  else
    begin 
      valid_count<=valid_count-1;
    end 
  end
  
  `S2: begin
    val<=0;
    if(pause_count==0) begin
      state_next<=`S0;
    end
  else begin
    pause_count <= pause_count - 1;
  end 
  end
 endcase
end

endmodule

`timescale 1ns/1ps

module prod_tb;

reg clk;
reg rst_b;
wire val;
wire [7:0]data;

prod uut (
 .clk(clk),
 .rst_b(rst_b),
  .val(val),
  .data(data)
);

initial begin
  clk=0;
  rst_b=0;
  #25 rst_b=1;  

    #1000 $finish;
end

always #50 clk = ~clk;  // Ciclul de ceas de 20 unit??i de timp (50 MHz)

endmodule






