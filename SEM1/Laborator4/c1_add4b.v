module c1_add4b (
    input wire [3:0] x,
    input wire [3:0] y,
    input wire ci,
    output [3:0] z
);
    wire [4:0] sum; 
    
    assign sum = x + y + ci;
    assign z = sum[3:0] + sum[4];
 
endmodule

module c1_add4b_tb;
    reg [3:0] x;
    reg [3:0] y;
    reg ci;
    wire [3:0] z;

    c1_add4b uut (
        .x(x),
        .y(y),
        .ci(ci),
        .z(z)
    );
    
    integer i;
    initial begin
        $display("x\t y\t ci\t | z"); 
        
        for(i = 0; i < 512; i = i + 1) begin
            {x, y, ci} = i;    
            #10;               
            $display("%b\t %b\t %b\t | %b", x, y, ci, z); 
        end
    end
    
endmodule

