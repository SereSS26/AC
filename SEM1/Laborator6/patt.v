module patt (
    input clk,
    input rst_b,
    input i,
    output reg o
);

    localparam S0 = 3'b000;  
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100;
    

    reg [2:0] state;                
    reg [2:0] next_state;          

    always @(posedge clk or negedge rst_b) begin
        if (!rst_b)
            state <= S0;  
        else
            state <= next_state; 
    end

   always @(*) begin
        case (state)
            S0: begin
                if (i)
                    next_state = S1;  
                else
                    next_state = S0;  
            end
            S1: begin
                if (i)
                    next_state = S1;  
                else
                    next_state = S2;  
            end
            S2: begin
                if (i)
                    next_state = S3;  
                else
                    next_state = S0;  
            end
            S3: begin
                if (i)
                    next_state = S4;  
                else
                    next_state = S2;  
            end
            S4: begin
                if (i)
                    next_state = S1;  
                else
                    next_state = S2;  
            end
            default: next_state = S0;  
        endcase
    end
    
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b)
            o <= 1'b0;  
        else
            o <= (state == S4);  
    end
endmodule

module patt_tb;

    reg clk;
    reg rst_b;
    reg i;  
    wire o; 

    patt uut (
        .clk(clk),
        .rst_b(rst_b),
        .i(i),
        .o(o)
    );
    
    localparam CLK_PERIOD = 100;
    localparam RUNNING_CYCLES = 8;
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
        i=1;
        #100 i=0;
        #100 i=1;
        #200 i=0;
        #100 i=1;      
    end

    initial begin
        $monitor("Timp=%0t | rst_b=%b | i=%b | o=%b", $time, rst_b, i, o);
    end
endmodule


