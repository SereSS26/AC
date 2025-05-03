module check (
    input [4:0] i,   
    output o        
);

    assign o = (i % 4 == 1);

endmodule


