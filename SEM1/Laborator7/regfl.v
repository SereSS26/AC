module dec #(parameter w=3)(
    input [w-1:0] s,    
    input e,            
    output reg [2**w-1:0] o 
);
    always @(*) begin
        o = 0;
        if (e) o[s] = 1;
    end
endmodule

module regfl (
    input wire clk, 
    input wire rst_b,           
    input wire we,              
    input wire [63:0] d,        
    input wire [2:0] s,         
    output wire [511:0] q       
);

    reg [63:0] registers[7:0];  

    wire [7:0] we_decoded; 
    
    dec #(3) address_decoder (
        .s(s), 
        .e(we), 
        .o(we_decoded)
    );

    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            registers[0] <= 64'h0000000000000000;
            registers[1] <= 64'h0000000000000000;
            registers[2] <= 64'h0000000000000000;
            registers[3] <= 64'h0000000000000000;
            registers[4] <= 64'h0000000000000000;
            registers[5] <= 64'h0000000000000000;
            registers[6] <= 64'h0000000000000000;
            registers[7] <= 64'h0000000000000000;
        end else begin
            if (we_decoded[0]) 
              registers[0] <= d;
            if (we_decoded[1]) 
              registers[1] <= d;
            if (we_decoded[2]) 
              registers[2] <= d;
            if (we_decoded[3]) 
              registers[3] <= d;
            if (we_decoded[4]) 
              registers[4] <= d;
            if (we_decoded[5]) 
              registers[5] <= d;
            if (we_decoded[6]) 
              registers[6] <= d;
            if (we_decoded[7]) 
              registers[7] <= d;
        end
    end

    assign q = {registers[0], registers[1], registers[2], registers[3], 
                registers[4], registers[5], registers[6], registers[7]};

endmodule


module regfl_tb;

    reg clk;                          
    reg rst_b;                        
    reg we;                           
    reg [63:0] d;                    
    reg [2:0] s;                     
    wire [511:0] q;                  

    regfl uut (
        .clk(clk),
        .rst_b(rst_b),
        .we(we),
        .d(d),
        .s(s),
        .q(q)
    );

    localparam CLK_PERIOD = 100;
    localparam RUNNING_CYCLES = 13;
    initial begin
        clk = 1'd0;
        repeat (2*RUNNING_CYCLES) #(CLK_PERIOD/2) clk = ~clk;
    end
    
    localparam RST_DURATION = 25;
    initial begin
      rst_b = 1'd0;
      #RST_DURATION rst_b = 1'd1;
    end
    
    task urand64(output reg [63:0] r);
        begin
            r[63:32] = $urandom;  
            r[31:0] = $urandom;   
        end
    endtask
    
    task urand4(output reg [3:0] r1);
        begin
            r1[3:2] = $urandom;  
            r1[1:0] = $urandom;   
        end
    endtask
    
    initial begin
        urand4(s);
    end
    
    initial begin
        urand64(d);
    end
    
    initial begin
        we=1;
        #600 we=0;
        #100 we=1;
    end
    
    initial begin
        $monitor("Timp=%0t | we=%d | s=%d | d=%h | q=%h",
                  $time, we, s, d, q);
    end
    
endmodule