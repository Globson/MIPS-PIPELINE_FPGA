module Harzard (ID_Instruction_In,reset,EX_Instruction_In,EX_MemRead_In,PC_Freeze_Out, Controller_Write_Out, IF_ID_Stall_Write_Out);
  input [31:0]ID_Instruction_In;
  input [31:0]EX_Instruction_In;
  input EX_MemRead_In,reset;
  output reg PC_Freeze_Out, Controller_Write_Out, IF_ID_Stall_Write_Out;


always @(ID_Instruction_In or reset) begin
    if(reset)begin
      Controller_Write_Out = 0;
      IF_ID_Stall_Write_Out = 0;
      PC_Freeze_Out = 0;
    end
    else begin
        if(EX_MemRead_In && ((EX_Instruction_In[20:16] == ID_Instruction_In[20:16]) || (EX_Instruction_In[20:16] == ID_Instruction_In[25:21]))) begin
          Controller_Write_Out = 1;
          IF_ID_Stall_Write_Out = 1;
          PC_Freeze_Out = 1;
        end
        else begin
          Controller_Write_Out = 0;
          IF_ID_Stall_Write_Out = 0;
          PC_Freeze_Out = 0;
        end
    end
end
endmodule //Harzard
