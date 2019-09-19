module Pipeline_PC (entrada,saida,clk,reset,PC_Freeze);
  input[31:0]entrada;
  input clk,reset,PC_Freeze;
  output reg[31:0] saida;

  always @ (posedge clk) begin //or reset
    if(reset)begin
      saida <= 32'b0;
    end
    else begin
      saida = (PC_Freeze == 0) ? entrada : saida;
    end
  end

endmodule //Pipeline_PC
