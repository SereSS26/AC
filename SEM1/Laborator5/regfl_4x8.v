module regfl_4x8 (
    input wire clk,              
    input wire rst_b,            
    input wire [7:0] wr_data,    
    input wire [1:0] wr_addr,    
    input wire wr_e,             
    output reg [7:0] rd_data,   
    input wire [1:0] rd_addr    
);

    
    wire [7:0] q0, q1, q2, q3;

    
    wire [3:0] ld;

    
    decoder_1to4 decoder (
        .addr(wr_addr),  
        .enable(wr_e),   
        .out(ld)         
    );

    
    rgst #(8) reg0 (
        .clk(clk),
        .rst_b(rst_b),
        .ld(ld[0]),              
        .clr(1'b0),              
        .d(wr_data),             
        .q(q0)                   
    );

    rgst #(8) reg1 (
        .clk(clk),
        .rst_b(rst_b),
        .ld(ld[1]),              
        .clr(1'b0),
        .d(wr_data),
        .q(q1)
    );

    rgst #(8) reg2 (
        .clk(clk),
        .rst_b(rst_b),
        .ld(ld[2]),              
        .clr(1'b0),
        .d(wr_data),
        .q(q2)
    );

    rgst #(8) reg3 (
        .clk(clk),
        .rst_b(rst_b),
        .ld(ld[3]),              
        .clr(1'b0),
        .d(wr_data),
        .q(q3)
    );

    always @(*) begin
      case (rd_addr)
          2'b00: rd_data = q0;
          2'b01: rd_data = q1;
          2'b10: rd_data = q2;
          2'b11: rd_data = q3;
          default: rd_data = 8'b0; 
      endcase
    end
endmodule


module regfl_4x8_tb;

    reg clk;                     
    reg rst_b;                   
    reg [7:0] wr_data;           
    reg [1:0] wr_addr;           
    reg wr_e;                    
    reg [1:0] rd_addr;           
    wire [7:0] rd_data;          

    regfl_4x8 uut (
        .clk(clk),
        .rst_b(rst_b),
        .wr_data(wr_data),
        .wr_addr(wr_addr),
        .wr_e(wr_e),
        .rd_data(rd_data),
        .rd_addr(rd_addr)
    );

    localparam CLK_PERIOD = 100;
    localparam RUNNING_CYCLES = 9;
    initial begin
        clk = 1'd0;
        repeat (2*RUNNING_CYCLES) #(CLK_PERIOD/2) clk = ~clk;
    end
    
    localparam RST_DURATION = 5;
    initial begin
      rst_b = 1'd0;
      #RST_DURATION rst_b = 1'd1;
    end
    
    initial begin
        $monitor("Time:%t | wr_addr: %d | wr_data: %d | rd_addr: %d | rd_data: %d", 
                 $time, wr_addr, wr_data, rd_addr, rd_data);
    end
    
    initial begin
        wr_addr = 2'h0; 
        #100 wr_addr = 2'h2;
        #100 wr_addr = 2'h1;
        #100 wr_addr = 2'h3;
        #100 wr_addr = 2'h0;
        #100 wr_addr = 2'h1;
        #100 wr_addr = 2'h3;
        #100 wr_addr = 2'h2;
        #100 wr_addr = 2'h3;
    end
    
    initial begin
        wr_data = 8'ha2; 
        #100 wr_data = 8'h2e;
        #100 wr_data = 8'h98;
        #100 wr_data = 8'h55;
        #100 wr_data = 8'h20;
        #100 wr_data = 8'hff;
        #100 wr_data = 8'hc7;
        #100 wr_data = 8'hb5;
        #100 wr_data = 8'h91;
    end
    
    initial begin
        wr_e=1;
        #200 wr_e=0;
        #100 wr_e=1;
        #400 wr_e=0;
        #100 wr_e=1;
    end
    
    initial begin
        rd_addr = 2'h3; 
        #100 rd_addr = 2'h0;
        #100 rd_addr = 2'h1;
        #100 rd_addr = 2'h2;
        #100 rd_addr = 2'h0;
        #100 rd_addr = 2'h3;
        #100 rd_addr = 2'h1;
        #100 rd_addr = 2'h2;
        #100 rd_addr = 2'h3;
    end
endmodule


