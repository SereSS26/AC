module mux_2s #(
  parameter w = 4
)(
  input [w-1:0] d0, d1, d2, d3,
  input [1:0] s,
  output reg [w-1:0] o
);

assign o = (s == 2'b00) ? d0 : {w{1'bz}};
assign o = (s == 2'b01) ? d1 : {w{1'bz}};
assign o = (s == 2'b10) ? d2 : {w{1'bz}};
assign o = (s == 2'b11) ? d3 : {w{1'bz}};
  
endmodule // mux_2s

module mux_2s_16b #(
  parameter WIDTH = 16  // Lățimea datelor, implicit 16 biți
)(
  input [WIDTH-1:0] D0,  // Intrare 0
  input [WIDTH-1:0] D1,  // Intrare 1
  input [WIDTH-1:0] D2,  // Intrare 2
  input [WIDTH-1:0] D3,  // Intrare 3
  input [1:0] C,         // Linii de selecție (C1, C0)
  output reg [WIDTH-1:0] Z  // Ieșire
);

always @(*) begin
  case (C)
    2'b00: Z = D0;  // Selectăm D0
    2'b01: Z = D1;  // Selectăm D1
    2'b10: Z = D2;  // Selectăm D2
    2'b11: Z = D3;  // Selectăm D3
    default: Z = {WIDTH{1'b0}}; // Valoare implicită (toți biții 0)
  endcase
end

endmodule

module mux_2s_16b_tb;

parameter WIDTH = 16;

// Declarații pentru intrări și ieșiri
reg [WIDTH-1:0] D0, D1, D2, D3;
reg [1:0] C;
wire [WIDTH-1:0] Z;

// Instanțierea modulului de testat
mux_2s_16b #(WIDTH) uut (
  .D0(D0),
  .D1(D1),
  .D2(D2),
  .D3(D3),
  .C(C),
  .Z(Z)
);

initial begin
  // Afișare rezultate
  $monitor("Timp: %0t | C: %b | D0: %h | D1: %h | D2: %h | D3: %h | Z: %h",
           $time, C, D0, D1, D2, D3, Z);

  // Setăm valori de test
  D0 = 16'hAAAA;  // Exemplu: 1010101010101010
  D1 = 16'hBBBB;  // Exemplu: 1011101110111011
  D2 = 16'hCCCC;  // Exemplu: 1100110011001100
  D3 = 16'hDDDD;  // Exemplu: 1101110111011101

  // Testăm toate combinațiile liniilor de selecție
  C = 2'b00; #10;  // Așteptăm 10 unități de timp
  C = 2'b01; #10;
  C = 2'b10; #10;
  C = 2'b11; #10;

  // Oprire simulare
  $stop;
end

endmodule
