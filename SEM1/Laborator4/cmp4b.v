module cmp4b (
    input [3:0] x,     
    input [3:0] y,     
    output eq,         
    output lt,         
    output gt          
);
    wire eq1, lt1, gt1; 
    wire eq2, lt2, gt2;  

    cmp2b cmp2b_0 (
        .x(x[1:0]),   
        .y(y[1:0]),   
        .eq(eq1),     
        .lt(lt1),     
        .gt(gt1)      
    );

    cmp2b cmp2b_1 (
        .x(x[3:2]),   
        .y(y[3:2]),   
        .eq(eq2),     
        .lt(lt2),     
        .gt(gt2)       
    );

    assign eq = eq1 && eq2;  
    assign lt = lt1 || (eq1 && lt2);   
    assign gt = gt1 || (eq1 && gt2);  
    
endmodule

module cmp4b_tb;
    reg [3:0] x, y;  
    wire eq, lt, gt; 

    cmp4b cmp4b_i (
        .x(x),
        .y(y),
        .eq(eq),
        .lt(lt),
        .gt(gt)
    );

    integer k; 

    initial begin
        $display("Time\tx\ty\teq\tlt\tgt"); 
        $monitor("%0t\t%b\t%b\t%b\t%b\t%b", $time, x, y, eq, lt, gt); 

        for (k = 0; k < 256; k = k + 1) begin
            {x, y} = k; 
            #10; 
        end
    end
endmodule


