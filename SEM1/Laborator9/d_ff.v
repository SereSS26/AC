module d_ff (
    input wire clk,       
    input wire rst_b,     
    input wire set_b,     
    input wire d,        
    output reg q         
);

    always @(posedge clk or negedge rst_b or negedge set_b) begin
        if (!rst_b) begin
            q <= 0;      
        end else if (!set_b) begin
            q <= 1;      
        end else begin
            q <= d;      
        end
    end
endmodule


