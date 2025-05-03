module ctrl_u (
    input wire clk,            // Semnal de ceas
    input wire rst_b,         // Semnal de reset asincron
    input wire bgn,           // Semnal de început
    input wire q0,            // Bitul cel mai pu?in semnificativ din Q
    input wire [2:0] cnt_i,   // Contor intern
    output reg c0,            // Semnal de control 0
    output reg c1,            // Semnal de control 1
    output reg c2,            // Semnal de control 2
    output reg c3,            // Semnal de control 3
    output reg c4,            // Semnal de control 4
    output reg c5,            // Semnal de control 5
    output reg c6,            // Semnal de control 6
    output reg fin            // Semnal de finalizare
);
    
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            // Resetare semnale de control
            c0 <= 0;
            c1 <= 0;
            c2 <= 0;
            c3 <= 0;
            c4 <= 0;
            c5 <= 0;
            c6 <= 0;
            fin <= 0;
        end else begin
            // Logica de control
            case (cnt_i)
                3'b000: begin // Starea 0
                    c0 <= 1;  // Activ?m opera?ia de înc?rcare
                    c1 <= 0;
                    c2 <= 0;
                    c3 <= 0;
                    c4 <= 0;
                    c5 <= 0;
                    c6 <= 0;
                    fin <= 0;
                end
                3'b001: begin // Starea 1
                    c0 <= 0;
                    c1 <= 1;  // Activ?m shift-ul la dreapta
                    c2 <= 0;
                    c3 <= 0;
                    c4 <= 0;
                    c5 <= 0;
                    c6 <= 0;
                    fin <= 0;
                end
                3'b010: begin // Starea 2
                    c0 <= 0;
                    c1 <= 0;
                    c2 <= 1;  // Activ?m adunarea
                    c3 <= 0;
                    c4 <= 0;
                    c5 <= 0;
                    c6 <= 0;
                    fin <= 0;
                end
                // Continu?m cu alte st?ri pentru cnt_i...
                3'b111: begin // Starea final?
                    c0 <= 0;
                    c1 <= 0;
                    c2 <= 0;
                    c3 <= 0;
                    c4 <= 0;
                    c5 <= 0;
                    c6 <= 0;
                    fin <= 1;  // Procesul s-a finalizat
                end
                default: begin
                    c0 <= 0;
                    c1 <= 0;
                    c2 <= 0;
                    c3 <= 0;
                    c4 <= 0;
                    c5 <= 0;
                    c6 <= 0;
                    fin <= 0;
                end
            endcase
        end
    end
endmodule
