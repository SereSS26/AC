module sm_unit (
    input wire clk,           // Semnal de ceas
    input wire rst_b,        // Semnal de reset asincron
    input wire bgn,          // Semnal de început
    input wire [7:0] ibus,   // Intrarea num?r
    output reg fin,          // Semnal de finalizare
    output reg [7:0] obus    // Ie?irea rezultat
);
    // Variabile interne
    reg [7:0] A, Q;          // Registrul A ?i Q
    reg [3:0] cnt;           // Contor pentru num?rul de itera?ii
    reg [7:0] product;       // Variabil? pentru produs

    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            A <= 8'b0;           // Reset registrul A
            Q <= 8'b0;           // Reset registrul Q
            product <= 8'b0;     // Reset produs
            fin <= 0;            // Reset semnal finalizare
            cnt <= 4'b0;         // Reset contor
        end else if (bgn) begin
            // Începem procesul de multiplicare
            A <= ibus;            // Înc?rc?m A cu valoarea de intrare
            Q <= ibus;            // Înc?rc?m Q cu valoarea de intrare
            product <= 8'b0;      // Reset?m produsul
            cnt <= 4'b0;          // Reset?m contorul
            fin <= 0;             // Reset semnal finalizare
        end else begin
            // Procesul de multiplicare
            if (cnt < 4'd8) begin
                // Logica de multiplicare secven?ial?
                if (Q[0] == 1) begin
                    product <= product + A; // Adun?m A la produs
                end
                // Shift la dreapta Q
                Q <= {product[0], Q[7:1]};
                product <= {1'b0, product[7:1]}; // Shift la dreapta produs
                cnt <= cnt + 1;  // Increment?m contorul
            end else begin
                obus <= product;  // Scriem produsul în ie?ire
                fin <= 1;         // Semnaliz?m finalizarea
            end
        end
    end
endmodule

module sm_unit_tb;
    reg clk;               // Semnal de ceas
    reg rst_b;            // Semnal de reset
    reg bgn;              // Semnal de început
    reg [7:0] ibus;       // Intrarea num?r
    wire fin;            // Semnal de finalizare
    wire [7:0] obus;     // Ie?irea rezultat

    // Instan?ierea modulului sm_unit
    sm_unit test (
        .clk(clk),
        .rst_b(rst_b),
        .bgn(bgn),
        .ibus(ibus),
        .fin(fin),
        .obus(obus)
    );

    localparam CLK_PERIOD = 100;         // Perioada ceasului
    localparam CLK_CYCLES = 17;          // Num?rul de cicluri de ceas
    localparam RST_PULSE = 25;           // Puls de reset
    localparam X = 8'b10010111;          // -23 * 2^(-7)
    localparam Y = 8'b10000011;          // -3 * 2^(-7)

    initial begin
        clk = 1'b0;
        repeat (CLK_CYCLES * 2) #(CLK_PERIOD / 2) clk = ~clk; // Generare semnal ceas
    end

    initial begin
        rst_b = 1'b0; 
        #(RST_PULSE);
        rst_b = 1'b1; // Activ?m resetul
    end

    initial begin
        bgn = 1'b1; 
        #200; 
        bgn = 1'b0; // Activ?m semnalul de început
    end

    initial begin
        ibus = 8'b0; 
        #100; 
        ibus = X;  // Introducem primul num?r
        #100; 
        ibus = Y;  // Introducem al doilea num?r
    end

    initial begin
        $monitor("Time: %0t | obus = %b | fin = %b", $time, obus, fin);
    end
endmodule
