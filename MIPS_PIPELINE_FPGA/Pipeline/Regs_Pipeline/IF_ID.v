module IF_ID (clk,reset,IF_IDWrite_In,Instruction_In,SaidaSOMA4_In,ID_Instruction_Out,ID_PC_Out);
  input clk,IF_IDWrite_In,reset;
  input[31:0]Instruction_In;
  input[31:0]SaidaSOMA4_In;
  output reg[31:0] ID_Instruction_Out;
  output reg[31:0] ID_PC_Out;


always @(posedge clk or reset) begin
  if(reset)begin
    ID_PC_Out <= 0;
    ID_Instruction_Out <= 0;
  end
  else begin
    ID_PC_Out <= (IF_IDWrite_In == 0) ? SaidaSOMA4_In : ID_PC_Out;
    ID_Instruction_Out <= (IF_IDWrite_In == 0) ? Instruction_In : 0;   //Bolhas Stall
  end
end




endmodule //IF_ID
