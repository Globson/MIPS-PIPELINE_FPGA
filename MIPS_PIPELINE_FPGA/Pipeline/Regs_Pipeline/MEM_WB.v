module MEM_WB(clk,reset,MEM_RegWrite_In, MEM_MemtoReg_In,ReadData_In, MEM_ALUresult_In, MEM_Index_WriteReg_In,WB_RegWrite_Out, WB_MemtoReg_Out,WB_readData_Out, WB_ALUresult_Out,WB_Index_WriteReg_Out);
  input clk,reset,MEM_RegWrite_In,MEM_MemtoReg_In;
  input[31:0] ReadData_In;
  input[31:0] MEM_ALUresult_In;
  input[4:0] MEM_Index_WriteReg_In;
  output reg WB_RegWrite_Out,WB_MemtoReg_Out;
  output reg[31:0] WB_readData_Out;
  output reg[31:0] WB_ALUresult_Out;
  output reg[4:0] WB_Index_WriteReg_Out;


always @(posedge clk or reset) begin
    if(reset)begin
      WB_readData_Out <= 0;
      WB_ALUresult_Out <= 0;
      WB_Index_WriteReg_Out <=0;
      WB_RegWrite_Out <= 0;
      WB_MemtoReg_Out <= 0;
    end
    else begin
      WB_readData_Out <= ReadData_In;
      WB_ALUresult_Out <= MEM_ALUresult_In;
      WB_Index_WriteReg_Out <= MEM_Index_WriteReg_In;
      WB_RegWrite_Out <= MEM_RegWrite_In;
      WB_MemtoReg_Out <= MEM_MemtoReg_In;
    end
end

endmodule //MEM_WB
