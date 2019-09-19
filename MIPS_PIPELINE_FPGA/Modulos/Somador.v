module Somador (a,b,saida);
  input [31:0]a;
  input [31:0]b;
  output [31:0]saida;
  assign saida = a + b;
endmodule //Somador
