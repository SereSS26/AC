module fdivby3 (
    input clk,
    input rst_b,
    input clr,
    input c_up,
    output reg tdclk
);

    localparam S0 = 3'b001; 
    localparam S1 = 3'b010; 
    localparam S2 = 3'b100; 

    reg [2:0] st;  
    reg [2:0] st_next; 

    always @(*) begin
        case (st)
            S0: tdclk = 1;
            S1: tdclk = 0;
            S2: tdclk = 0;
            default: tdclk = 0; 
        endcase
    end

    always @(*) begin
        case (st)
            S0: begin
                if (~c_up | clr)
                    st_next = S0;
                else if (c_up & ~clr)
                    st_next = S1;
            end
            S1: begin
                if (~c_up & ~clr)
                    st_next = S1;
                else if (c_up & ~clr)
                    st_next = S2;
                if (clr)
                    st_next = S0;
            end
            S2: begin
                if (~c_up & ~clr)
                    st_next = S0;
                else if (c_up | clr)
                    st_next = S0;
            end
            default: st_next = S0; 
        endcase
    end

    always @(posedge clk or negedge rst_b) begin
        if (!rst_b)
            st <= S0; 
        else
            st <= st_next; 
    end

endmodule



module fdivby3_tb;
    reg clk;
    reg rst_b;
    reg clr;
    reg c_up;
    wire tdclk;

    fdivby3 uut (
        .clk(clk),
        .rst_b(rst_b),
        .clr(clr),
        .c_up(c_up),
        .tdclk(tdclk)
    );

    localparam CLK_PERIOD = 100;
    localparam RUNNING_CYCLES = 18;

    initial begin
        clk = 1'b0;
        repeat (2*RUNNING_CYCLES) #(CLK_PERIOD/2) clk = ~clk;
    end

    initial begin
        rst_b = 1'b0;
        #25 rst_b = 1'b1; 
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
        $monitor("Time: %0t | Reset: %b | Clear: %b | Count Up: %b | Output: %b", 
                  $time, rst_b, clr, c_up, tdclk);
    end
endmodule

