module reg_q (
    input wire clk,             
    input wire rst_b,            
    input wire clr_lsb,         
    input wire ld_ibus,         
    input wire ld_obus,         
    input wire sh_r,             
    input wire sh_i,             
    input wire [7:0] ibus,      
    output reg [7:0] obus,      
    output reg [7:0] q          
);
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            q <= 8'b0;          
            obus <= 8'b0;      
        end else if (clr_lsb) begin
            q[0] <= 1'b0;       
        end else if (ld_ibus) begin
            q <= ibus;          
        end else if (sh_r) begin
            q <= {1'b0, q[7:1]}; // Shift la dreapta
        end else if (sh_i) begin
            q <= {q[6:0], 1'b0}; // Shift la stânga
        end
    end

    always @(*) begin
        obus = (ld_obus) ? q : 8'bz;  // Iesirea Q se scrie în obus
    end
endmodule
