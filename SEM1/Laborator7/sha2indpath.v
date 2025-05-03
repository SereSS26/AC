module sha2indpath (
    input clk,               
    input rst_b,             
    input [63:0] pkt,        
    input [63:0] msg_len,    
    input st_pkt,            
    input clr,               
    input pad_pkt,           
    input zero_pkt,          
    input mgln_pkt,          
    output [2:0] idx,        
    output [511:0] blk      
);

    wire [63:0] pktmux_out;       // Iesirea din pktmux
    wire [63:0] rgst_q;           // Iesirea din rgst
    wire [511:0] regfl_q;         // Iesirea din regfl
    wire [2:0] cntr_q;            // Iesirea din cntr
    wire n_or;
    wire aux;
    assign n_or=~(pad_pkt|zero_pkt|mgln_pkt);
    assign aux=n_or & st_pkt; 
    
    pktmux pkt_mux (
        .pkt(pkt), 
        .msg_len(rgst_q), 
        .pad_pkt(pad_pkt), 
        .zero_pkt(zero_pkt), 
        .mgln_pkt(mgln_pkt), 
        .pkt_out(pktmux_out)
    );

    rgst #(64) rgst_64 (
        .clk(clk), 
        .rst_b(rst_b), 
        .ld(aux),            
        .clr(clr),              
        .d(rgst_q+64),        
        .q(rgst_q)
    );

    cntr #(3) cntr_idx (
        .clk(clk), 
        .rst_b(rst_b), 
        .c_up(st_pkt),          
        .clr(clr),              
        .q(cntr_q)
    );

    regfl regfl_blk (
        .clk(clk), 
        .rst_b(rst_b), 
        .we(st_pkt),            
        .d(pktmux_out),             
        .s(cntr_q),             
        .q(regfl_q)
    );

    assign idx = cntr_q;         
    assign blk = regfl_q;        

endmodule

module sha2indpath_tb;

    reg clk; 
    reg rst_b; 
    reg [63:0] pkt; 
    reg [63:0] msg_len;
    reg st_pkt;
    reg clr;
    reg pad_pkt;
    reg zero_pkt;
    reg mgln_pkt;
    wire [2:0] idx;
    wire [511:0] blk;

    sha2indpath uut (
        .clk(clk),
        .rst_b(rst_b),
        .pkt(pkt),
        .msg_len(msg_len),
        .st_pkt(st_pkt),
        .clr(clr),
        .pad_pkt(pad_pkt),
        .zero_pkt(zero_pkt),
        .mgln_pkt(mgln_pkt),
        .idx(idx),
        .blk(blk)
    );

    localparam CLK_PERIOD = 100;
    localparam RUNNING_CYCLES = 14;
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

    initial begin
        urand64(pkt);
    end
    
    initial begin
        msg_len=0;
    end

    initial begin
        clr=0;
        #200 clr=1;
        #100 clr=0;
    end
    
    initial begin
        st_pkt=1;
        #800 st_pkt=0;
        #100 st_pkt=1;
    end
    
    initial begin
        pad_pkt=0;
        #900 pad_pkt=1;
        #100 pad_pkt=0;
    end
    
    initial begin
        zero_pkt=0;
        #1000 zero_pkt=1;
        #100 zero_pkt=0;
    end
    
    initial begin
        mgln_pkt=0;
        #1100 mgln_pkt=1;
        #100 mgln_pkt=0;
    end
    
    initial begin
        $monitor("Time: %0t | pkt = %h | st_pkt = %b | clr = %b | pad_pkt = %b | zero_pkt = %b | mgln_pkt = %b | idx = %d | blk = %h",
                 $time, pkt, st_pkt, clr, pad_pkt, zero_pkt, mgln_pkt, idx, blk);
    end

endmodule

