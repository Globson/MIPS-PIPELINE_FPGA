module LeftShift2 (entrada,saida);
  input [31:0]entrada;
  output reg [31:0]saida;
  always @ ( entrada ) begin
    saida = (entrada << 2);
  end
endmodule //LeftShift2
