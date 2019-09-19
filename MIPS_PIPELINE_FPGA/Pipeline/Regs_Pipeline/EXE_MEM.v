module EXE_MEM(clk,reset,EX_MemWrite_In,EX_MemRead_In,EX_MemtoReg_In,EX_RegWrite_In,zero,EX_Branch_In,ALUresult_In,EX_ReadData2_In,WriteRegister_In,MEM_MemWrite_Out,MEM_MemRead_Out,MEM_MemtoReg_Out,MEM_RegWrite_Out,MEM_Zero_Out,MEM_Branch_Out,MEM_ALUresult_Out,MEM_ReadData2_Out,MEM_WriteRegister_Out);
  input clk,reset;
  input EX_MemWrite_In, EX_MemRead_In, EX_MemtoReg_In, EX_RegWrite_In, zero;
  input [1:0]EX_Branch_In;
  input[31:0] ALUresult_In;
  input[31:0] EX_ReadData2_In;
  input[4:0] WriteRegister_In;
  output reg MEM_MemWrite_Out, MEM_MemRead_Out, MEM_MemtoReg_Out, MEM_RegWrite_Out, MEM_Zero_Out;
  output reg[1:0] MEM_Branch_Out;
  output reg[31:0] MEM_ALUresult_Out;
  output reg[31:0] MEM_ReadData2_Out;
  output reg[4:0] MEM_WriteRegister_Out;


  always @(posedge clk or reset) begin
    if(reset)begin
      MEM_Branch_Out <= 0;
      MEM_ALUresult_Out <= 0;
      MEM_ReadData2_Out <= 0;
      MEM_WriteRegister_Out <= 0;
      MEM_MemWrite_Out <= 0;
      MEM_MemRead_Out <= 0;
      MEM_MemtoReg_Out <= 0;
      MEM_RegWrite_Out <= 0;
      MEM_Zero_Out <= 0;
    end
    else begin
      MEM_Branch_Out <= EX_Branch_In;
      MEM_WriteRegister_Out <= WriteRegister_In;
      MEM_RegWrite_Out <= EX_RegWrite_In;
      MEM_Zero_Out <= zero;
      MEM_ALUresult_Out <= ALUresult_In;
      MEM_MemtoReg_Out <= EX_MemtoReg_In;
      MEM_MemRead_Out <= EX_MemRead_In;
      MEM_MemWrite_Out <= EX_MemWrite_In;
      MEM_ReadData2_Out <= EX_ReadData2_In;
    end
  end

endmodule //EXE_MEM
