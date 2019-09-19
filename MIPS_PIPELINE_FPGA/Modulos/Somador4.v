module Somador4 (a,saida);
  input [31:0]a;
  output [31:0]saida;
  assign saida = a+4'b0100; //Proximo valor de PC
endmodule //Somador4
