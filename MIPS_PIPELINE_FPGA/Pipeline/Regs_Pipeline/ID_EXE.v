module ID_EXE(clk,reset,ALUSrc_In,EX_ReadData1_Out,EX_ReadData2_Out,EX_Saida_Ext_Sinal_Out,EX_Instruction_Out,EX_PC_Out,RegDst_In,MemWrite_In,MemRead_In,MemtoReg_In,RegWrite_In,Branch_In,ALUOp_In,ReadData1_In,EX_ALUOp_Out,ReadData2_In,Saida_Ext_Sinal_In,ID_Instruction_In,ID_PC_In,EX_ALUSrc_Out, EX_RegDst_Out, EX_MemWrite_Out, EX_MemRead_Out, EX_MemtoReg_Out, EX_RegWrite_Out, EX_Branch_Out);
  input clk,reset;
  input ALUSrc_In, MemWrite_In, RegDst_In, MemRead_In, MemtoReg_In, RegWrite_In;
  input [1:0]ALUOp_In;
  input [1:0]Branch_In;
  input[31:0] ReadData1_In;
  input[31:0] ReadData2_In;
  input[31:0] Saida_Ext_Sinal_In;
  input[31:0] ID_Instruction_In;
  input[31:0] ID_PC_In;
  output reg EX_ALUSrc_Out, EX_RegDst_Out, EX_MemWrite_Out, EX_MemRead_Out, EX_MemtoReg_Out, EX_RegWrite_Out;
  output reg [1:0]EX_ALUOp_Out;
  output reg [1:0]EX_Branch_Out;
  output reg[31:0] EX_ReadData1_Out;
  output reg[31:0] EX_ReadData2_Out;
  output reg[31:0] EX_Saida_Ext_Sinal_Out;
  output reg[31:0] EX_Instruction_Out;
  output reg[31:0] EX_PC_Out;






always @(posedge clk or reset) begin
  if(reset)begin
    EX_PC_Out <= 0;
    EX_ReadData1_Out <= 0;
    EX_ReadData2_Out <= 0;
    EX_Saida_Ext_Sinal_Out <= 0;
    EX_Instruction_Out <= 0;
    EX_ALUSrc_Out <= 0;
    EX_ALUOp_Out <= 0;
    EX_RegDst_Out <= 0;
    EX_MemWrite_Out <= 0;
    EX_MemRead_Out <= 0;
    EX_MemtoReg_Out <= 0;
    EX_RegWrite_Out <= 0;
    EX_Branch_Out <= 0;
  end
  else begin
    EX_PC_Out <= ID_PC_In;
    EX_ReadData1_Out <= ReadData1_In;
    EX_ReadData2_Out <= ReadData2_In;
    EX_Saida_Ext_Sinal_Out <= Saida_Ext_Sinal_In;
    EX_Instruction_Out <= ID_Instruction_In;
    EX_MemtoReg_Out <= MemtoReg_In;
    EX_RegWrite_Out <= RegWrite_In;
    EX_Branch_Out <= Branch_In;
    EX_ALUSrc_Out <= ALUSrc_In;
    EX_ALUOp_Out <= ALUOp_In;
    EX_RegDst_Out <= RegDst_In;
    EX_MemWrite_Out <= MemWrite_In;
    EX_MemRead_Out <= MemRead_In;
  end
end

endmodule //IDE_EXE
