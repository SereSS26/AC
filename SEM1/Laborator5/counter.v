module counter #(
    parameter WIDTH = 8,       
    parameter INIT_VAL = 8'hff 
) (
    input clk,                
    input rst_b,              
    input c_up,                 
    input clr,                
    output reg [WIDTH-1:0] q  
);

    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            q <= INIT_VAL;   
        end
        else if (clr) begin
            q <= INIT_VAL;   
        end
        else if (c_up) begin
            q <= q + 1;      
        end
    end
endmodule

module counter_tb;
    parameter WIDTH = 8;              
    parameter INIT_VAL = 8'hff;       

    reg clk;                           
    reg rst_b;                         
    reg c_up;                            
    reg clr;                          
    wire [WIDTH-1:0] q;               

    counter #(.WIDTH(WIDTH), .INIT_VAL(INIT_VAL)) uut (
        .clk(clk),
        .rst_b(rst_b),
        .c_up(c_up),
        .clr(clr),
        .q(q)
    );

    localparam CLK_PERIOD = 100;
    localparam RUNNING_CYCLES = 7;
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
        c_up=1;
        #400 c_up = 0;
        #100 c_up = 1;  
    end
    
    initial begin
        clr=0;
        #200 clr=1;
        #100 clr=0;
    end

    initial begin
        $monitor("Time: %0t | rst_b: %b | up: %b | clr: %b | q: %d", $time, rst_b, c_up, clr, q);
    end
endmodule
