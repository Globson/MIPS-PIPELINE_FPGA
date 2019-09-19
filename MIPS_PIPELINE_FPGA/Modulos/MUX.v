//Mux de 2 entradas de 32bits
module MUX_32b (controle,entrada1,entrada2,saida);  //memtoreg e branch
  input controle;
  input [31:0]entrada1;
  input [31:0]entrada2;
  output [31:0]saida;
  assign saida = (controle == 0) ? entrada1 : entrada2;
endmodule //MUX_32b

//Mux de 2 entradas de 5bits
module MUX_5b (controle,entrada1,entrada2,saida);  //MuxRegDst
  input controle;
  input [4:0]entrada1;
  input [4:0]entrada2;
  output [4:0]saida;
  assign saida = (controle == 0) ? entrada1 : entrada2;
endmodule //MUX_5b

module MUX_ALUSRC_FWDB (EX_ALUSrc_In,Saida_ForwardB_In,EX_ReadData2_In, EX_Saida_Ext_Sinal_In, WB_WriteData_In, MEM_ALUresult_In,Saida_Mux_FWRB_ALUSrc_Out,);
  input[31:0]EX_ReadData2_In;
  input[31:0]EX_Saida_Ext_Sinal_In;
  input EX_ALUSrc_In;
  input[31:0]WB_WriteData_In;
  input[31:0]MEM_ALUresult_In;
  input[1:0]Saida_ForwardB_In;
  output reg[31:0]Saida_Mux_FWRB_ALUSrc_Out;

  always@(*) begin
  case(Saida_ForwardB_In)
          2'b00:
              Saida_Mux_FWRB_ALUSrc_Out = (EX_ALUSrc_In == 0) ? EX_ReadData2_In : EX_Saida_Ext_Sinal_In;
          2'b10:
              Saida_Mux_FWRB_ALUSrc_Out = MEM_ALUresult_In;
          2'b11:
              Saida_Mux_FWRB_ALUSrc_Out = WB_WriteData_In;

  endcase
  end
endmodule //MUX_ALUSRC_FWDB

module MUX_FWDA (EX_ReadData1_In, WB_WriteData_In, MEM_ALUresult_In,Saida_ForwardA_In,Saida_Mux_FWRBA_Out);
  input[31:0]EX_ReadData1_In;
  input[31:0]WB_WriteData_In;
  input[31:0]MEM_ALUresult_In;
  input[1:0]Saida_ForwardA_In;
  output reg[31:0]Saida_Mux_FWRBA_Out;

always@(*)begin
    case(Saida_ForwardA_In)
        2'b00:
            Saida_Mux_FWRBA_Out = EX_ReadData1_In;
        2'b10:
            Saida_Mux_FWRBA_Out = MEM_ALUresult_In;
        2'b11:
            Saida_Mux_FWRBA_Out = WB_WriteData_In;
endcase
end
endmodule //MUX_FWDA
