module Mem_Exibi(resultadoALU,Clk,proximo,saida,reset);
  input [31:0] resultadoALU;
  input Clk,proximo,reset;
  output reg [31:0]saida;
  reg [31:0]Mem[0:25];  //Setar quantidade de instruçoes
  integer i = 26;
  integer j = 0;

  always @ ( negedge Clk ) begin
    if(i<16) begin   //Setar quantidade de instruções
      Mem[i] <= resultadoALU;
      i <= i + 1;
    end
    else if(reset) begin
      i<=0;
      Mem[0] <= resultadoALU;
    end
  end

  always @ (posedge proximo) begin
    if(j<16) begin  //Setar quantidade de instruções.//
      saida <= Mem[j];
      j <= j + 1;
    end

    else begin
      saida <= 32'b00000101111101011110000011111111; //Simbolo 99999999 indicando fim de leitura.
      j<=0;
    end
  end


endmodule //Mem_Exibi
