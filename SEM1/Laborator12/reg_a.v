module reg_a(
  input clk, rst_b, clr, sh_r, ld_sgn, ld_obus, ld_sum,
  input sh_i, sgn, [7:0] sum,
  output reg [7:0] obus, [7:0] q
);
   always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            q <= 8'b0;          
            obus <= 8'b0;       
        end else if (clr) begin
            q <= 8'b0;          
        end else if (ld_sgn) begin
            q[7] <= sgn;        
        end else if (ld_sum) begin
            q[6:0] <= sum;      
        end else if (sh_r) begin
            q <= {1'b0, q[7:1]}; // Shift la dreapta
        end else if (sh_i) begin
            q <= {q[6:0], 1'b0}; // Shift la stânga
        end
    end

    always @(*) begin
        obus = (ld_obus) ? q : 8'bz;  
    end
endmodule