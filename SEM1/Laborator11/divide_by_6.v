module divide_by_6 (
    input wire clk,       
    input wire rst_b,     
    input wire c_up,      
    input wire clr,       
    output reg fdclk      
);

    reg [5:0] state;      
    localparam S0 = 6'b000001; 
    localparam S1 = 6'b000010; 
    localparam S2 = 6'b000100; 
    localparam S3 = 6'b001000; 
    localparam S4 = 6'b010000; 
    localparam S5 = 6'b100000; 

    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            state <= S0; 
            fdclk <= 0;  
        end else if (clr) begin
            state <= S0; 
            fdclk <= 0;  
        end else if (c_up) begin
            case (state)
                S0: state <= S1;
                S1: state <= S2;
                S2: state <= S3;
                S3: state <= S4;
                S4: state <= S5;
                S5: state <= S0; 
                default: state <= S0; 
            endcase
        end
    end

    always @(*) begin
        if (state == S0 || state == S1 || state == S2 || state == S3) begin
            fdclk = 1; 
        end else begin
            fdclk = 0; 
        end
    end
endmodule



module divide_by_6_tb;
    reg clk;
    reg rst_b;
    reg c_up;
    reg clr;
    wire fdclk;

    divide_by_6 uut (
        .clk(clk),
        .rst_b(rst_b),
        .c_up(c_up),
        .clr(clr),
        .fdclk(fdclk)
    );

    localparam CLK_PERIOD = 100;
    localparam RUNNING_CYCLES = 50;
    initial begin
        clk = 1'd0;
        repeat (2*RUNNING_CYCLES) #(CLK_PERIOD/2) clk = ~clk;
    end
    
    localparam RST_DURATION = 25;
    initial begin
      rst_b = 1'd0;
      #RST_DURATION rst_b = 1'd1;
    end

    initial begin
        clr = 0;
        #400 clr = 1; 
        #100 clr = 0;
    end

    initial begin
        c_up = 1;
        #600 c_up = 0; 
        #100 c_up = 1; 
        #400 c_up = 0; 
        #200 c_up = 1; 
    end

    initial begin
        $monitor("Time: %0t | fdclk: %b | c_up: %b | clr: %b", $time, fdclk, c_up, clr);
    end
endmodule

