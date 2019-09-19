module Ext_Sinal (entrada,saida);
  input [15:0]entrada;
  output [31:0]saida;
  assign saida = (entrada[15] == 0) ? {16'b0000000000000000, entrada} : {16'b1111111111111111, entrada};
endmodule //Ext_Sinal
