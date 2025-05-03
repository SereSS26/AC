module pktmux (
    input [63:0] pkt,   
    input [63:0] msg_len,    
    input pad_pkt,           
    input zero_pkt,          
    input mgln_pkt,          
    output reg [63:0] pkt_out      
);

    always @(*) begin
      if (pad_pkt) begin
          pkt_out = 64'h8000000000000000; 
      end else if (zero_pkt) begin
          pkt_out = 64'h0000000000000000; 
      end else if (mgln_pkt) begin
          pkt_out = msg_len; 
      end else begin
          pkt_out = pkt; 
      end
    end

endmodule

module pktmux_tb;

    reg [63:0] pkt;       
    reg [63:0] msg_len;   
    reg pad_pkt;          
    reg zero_pkt;         
    reg mgln_pkt;         
    wire [63:0] pkt_out;  

    pktmux uut (
        .pkt(pkt),
        .msg_len(msg_len),
        .pad_pkt(pad_pkt),
        .zero_pkt(zero_pkt),
        .mgln_pkt(mgln_pkt),
        .pkt_out(pkt_out)
    );

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
        urand64(msg_len);
    end
    
    initial begin
        pad_pkt=0;
        #100 pad_pkt=1;
        #100 pad_pkt=0;
        #300 pad_pkt=1;
        #100 pad_pkt=0;
        #300 pad_pkt=1;
        #100 pad_pkt=0;
    end
    
    initial begin
        zero_pkt=0;
        #200 zero_pkt=1;
        #100 zero_pkt=0;
        #300 zero_pkt=1;
        #100 zero_pkt=0;
        #300 zero_pkt=1;
        #100 zero_pkt=0;
    end
    
    initial begin
        mgln_pkt=0;
        #300 mgln_pkt=1;
        #100 mgln_pkt=0;
        #300 mgln_pkt=1;
        #100 mgln_pkt=0;
        #300 mgln_pkt=1;
        #100 mgln_pkt=0;
    end
    
    initial begin
        $monitor("Timp=%0t | pkt=%h | msg_len=%h | pad_pkt=%b | zero_pkt=%b | mgln_pkt=%b | pkt_out=%h",
                  $time, pkt, msg_len, pad_pkt, zero_pkt, mgln_pkt, pkt_out);
    end

endmodule

