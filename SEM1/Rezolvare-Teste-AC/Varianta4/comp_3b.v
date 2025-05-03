module rel (
    input   x,     
    input   y,     
    output eq,         
    output lt,         
    output gt          
);
    assign eq = (x == y);   
    assign lt = (x < y);    
    assign gt = (x > y);    
endmodule
module comp_3b (
    input [2:0] x,     
    input [2:0] y,     
    output eq,         
    output lt,         
    output gt          
);
    wire eq0, lt0, gt0;
    wire eq1, lt1, gt1; 
    wire eq2, lt2, gt2;  

    rel rel_0 (
        .x(x[0]),   
        .y(y[0]),   
        .eq(eq0),     
        .lt(lt0),     
        .gt(gt0)      
    );

    rel rel_1 (
        .x(x[1]),   
        .y(y[1]),   
        .eq(eq1),     
        .lt(lt1),     
        .gt(gt1)       
    );
    
    rel rel_2 (
        .x(x[2]),   
        .y(y[2]),   
        .eq(eq2),     
        .lt(lt2),     
        .gt(gt2)       
    );

    assign eq = eq0 && eq1 && eq2;            
    assign gt = gt2 || (eq2 && gt1) || (eq2 && eq1 && gt0); 
    assign lt = lt2 || (eq2 && lt1) || (eq2 && eq1 && lt0);  
    
endmodule

module comp_3b_tb;
    reg [2:0] x, y;  
    wire eq, lt, gt; 

    comp_3b uut (
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

        for (k = 0; k < 64; k = k + 1) begin
            {x, y} = k; 
            #10; 
        end
    end
endmodule



  
  