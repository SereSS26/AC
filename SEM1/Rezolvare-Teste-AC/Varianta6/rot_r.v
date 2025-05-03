module rot_r (
    input [5:0] a,      
    output [5:0] b      
);
    assign b = {a[1:0], a[5:2]}; 
endmodule

module rot_r_tb;
    reg [5:0] a;        
    wire [5:0] b;       

    rot_r uut (
        .a(a),
        .b(b)
    );

    integer i;          

    initial begin
        $monitor("%0t\t%b\t%b", $time, a, b); 

        for (i = 0; i < 64; i = i + 1) begin
            a = i[5:0]; 
            #10;         
        end
    end
endmodule
