module prod (
    input wire clk,         
    input wire rst_b,      
    output reg val,        
    output reg [7:0] data  
);

    localparam IDLE = 2'b00;       
    localparam PRODUCE = 2'b01;
    localparam WAIT = 2'b10;        

    reg [1:0] current_state, next_state;  

    integer count;        
    integer wait_count;   
    integer ok;           

    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            current_state <= IDLE;  
            count <= 0;             
            wait_count <= 0;        
            val <= 0;               
            data <= 0;              
        end else begin
            current_state <= next_state;  
            if (current_state == PRODUCE) begin
                count <= count + 1;  
            end else if (current_state == WAIT) begin
                wait_count <= wait_count + 1;  
            end else if (current_state == IDLE) begin
                count <= 0;          
                wait_count <= 0;     
            end
        end
    end

    always @(*) begin
        next_state = current_state;  
        val = 0;                     

        case (current_state)
            IDLE: begin
                if (wait_count == 0) begin       
                    count = $urandom_range(3, 5); 
                    next_state = PRODUCE;  
                end else begin
                    wait_count = wait_count - 1;  
                end
            end

            PRODUCE: begin
                val = 1;                    
                data = $urandom_range(0, 5); 
                
                if (count == 1) begin   
                    wait_count = $urandom_range(1, 4);  
                    next_state = WAIT;  
                end else begin
                    count = count - 1;  
                end
            end

            WAIT: begin
                val = 0;  
                if (wait_count == 0) begin
                    next_state = IDLE;  
                end else begin
                    wait_count = wait_count - 1;  
                end
            end
        endcase
    end
endmodule

module prod_tb;

    reg clk;            
    reg rst_b;         
    wire val;          
    wire [7:0] data;   

    prod uut (
        .clk(clk),
        .rst_b(rst_b),
        .val(val),
        .data(data)
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
        $monitor("La timpul %t: val=%b, data=%h", $time, val, data);
    end
endmodule

