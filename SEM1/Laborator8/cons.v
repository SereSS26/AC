module cons (
    input wire clk,         
    input wire rst_b,      
    input wire val,        
    input wire [7:0] data, 
    output reg [7:0] sum   
);

    reg [7:0] last_data;  

    initial begin
        sum = 0;            
        last_data = 0;      
    end

    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            sum <= 0;        
            last_data <= 0;  
        end else if (val) begin
            if (data >= last_data) begin
                sum <= sum + data; 
                last_data <= data;  
            end
        end
    end
endmodule

module cons_tb;

    reg clk;              
    reg rst_b;           
    wire val;            
    wire [7:0] data;     
    wire [7:0] sum;      

    prod producer (
        .clk(clk),
        .rst_b(rst_b),
        .val(val),
        .data(data)
    );

    cons consumer (
        .clk(clk),
        .rst_b(rst_b),
        .val(val),
        .data(data),
        .sum(sum)
    );

    localparam CLK_PERIOD = 100;
    localparam RUNNING_CYCLES = 100;
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
        $monitor("La timpul %t: val=%b, data=%h, sum=%d", $time, val, data, sum);
    end

endmodule


