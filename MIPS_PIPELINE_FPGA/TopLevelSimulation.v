`include "Modulos/ALU.v"
`include "Modulos/AND.v"
`include "Modulos/ControleALU.v"
`include "Modulos/Controller.v"
`include "Modulos/Data_Memory.v"
`include "Modulos/Ext_Sinal.v"
`include "Modulos/LeftShift2.v"
`include "Modulos/Memoria_instrucoes.v"
`include "Modulos/MUX.v"
`include "Modulos/PC.v"
`include "Modulos/Registradores.v"
`include "Modulos/Somador.v"
`include "Modulos/Somador4.v"
`include "Pipeline/Hazard_Forwarding/Harzard.v"
`include "Pipeline/Hazard_Forwarding/Forwarding.v"
`include "Pipeline/Regs_Pipeline/EXE_MEM.v"
`include "Pipeline/Regs_Pipeline/ID_EXE.v"
`include "Pipeline/Regs_Pipeline/IF_ID.v"
`include "Pipeline/Regs_Pipeline/MEM_WB.v"
`include "Modulos/Clock.v"

module TopLevelSimulation();
  wire[31:0]PC_IN;
  wire[31:0]PC_Out;
  reg reset;
  wire Clock;
  wire Zero;
  wire [1:0]ForwardA, ForwardB;
  wire PC_Freeze, Controller_Write, IF_ID_Stall_Write;
  wire [3:0]Controle_ALU;
  wire [31:0]Saida_Mux_ForwardB;
  wire [31:0]Saida_Mux_ForwardA;
  wire [31:0]ALUresult;
  wire EX_ALUSrc, EX_RegDst, EX_MemWrite, EX_MemRead, EX_MemtoReg, EX_RegWrite;
  wire[1:0] EX_Branch;
  wire [1:0]ALUOp,Branch;
  wire [4:0]Index_WriteReg;
  wire [31:0]WB_WriteData,ReadData1,ReadData2;
  wire [31:0]Saida_Ext_Sinal,Saida_Shift_Left2;
  wire [31:0]MEM_ALUresult, MEM_readData2;
  wire[31:0] Instruction;
  wire [31:0]WB_readData, WB_ALUresult;
  wire WB_MemtoReg, WB_RegWrite_Enable;
  wire [4:0] WB_Index_WriteReg;
  wire [31:0]PC_Out_Mais_4,Saida_Somador;
  wire [31:0]Saida_Memory_ReadData;
  wire [31:0]ID_Instruction, ID_PC;
  wire RegDst,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Door_out;
  wire MEM_Zero, MEM_MemWrite, MEM_MemRead, MEM_MemtoReg, MEM_RegWrite;
  wire [4:0]MEM_Index_WriteReg;
  wire [1:0]MEM_Branch;
  wire [31:0]EX_ReadData1, EX_ReadData2, EX_Saida_Ext_Sinal, EX_Instruction, EX_PC;
  wire [1:0]EX_ALUOp;



  Pipeline_PC PC (
      .PC_Freeze(PC_Freeze),
      .reset(reset),
      .clk(Clock),
      .entrada(PC_IN),
      .saida(PC_Out)
);

  Memoria_instrucoes IMemory(.endereco(PC_Out),.instrucao(Instruction));

  Controller Control(
      .clk(Clock),
      .Opcode(ID_Instruction[31:26]),
      .Controller_Write(Controller_Write),
      .RegDst(RegDst),
      .Branch(Branch),
      .MemRead(MemRead),
      .MemtoReg(MemtoReg),
      .MemWrite(MemWrite),
      .ALUSrc(ALUSrc),
      .RegWrite(RegWrite),
      .ALUOp(ALUOp)
  );

  MUX_5b MuxRegDst(
    .entrada1(EX_Instruction[20:16]),
    .entrada2(EX_Instruction[15:11]),
    .saida(Index_WriteReg),
    .controle(EX_RegDst));

  Registradores Regs(
      .clk(Clock),
      .RegWrite(WB_RegWrite_Enable),
      .ReadReg1(ID_Instruction[25:21]),
      .ReadReg2(ID_Instruction[20:16]),
      .WriteReg(WB_Index_WriteReg),  //Index_WriteReg
      .WriteData(WB_WriteData),
      .ReadData1(ReadData1),
      .ReadData2(ReadData2)
  );

  Ext_Sinal SignExt(
      .entrada(ID_Instruction[15:0]),
      .saida(Saida_Ext_Sinal)
  );

  ControleALU ALUcontrol(
      .OpCode_ALU(EX_ALUOp),
      .Func_Code(EX_Instruction[5:0]),
      .Controle_ALU(Controle_ALU)
  );

  MUX_ALUSRC_FWDB MuxALUSrcFWDB(
      .EX_ALUSrc_In(EX_ALUSrc),
      .EX_Saida_Ext_Sinal_In(EX_Saida_Ext_Sinal),
      .EX_ReadData2_In(EX_ReadData2),
      .WB_WriteData_In(WB_WriteData),
      .MEM_ALUresult_In(MEM_ALUresult),
      .Saida_ForwardB_In(ForwardB),
      .Saida_Mux_FWRB_ALUSrc_Out(Saida_Mux_ForwardB)
  );

  MUX_FWDA MuxFwdA(
      .EX_ReadData1_In(EX_ReadData1),
      .WB_WriteData_In(WB_WriteData),
      .MEM_ALUresult_In(MEM_ALUresult),
      .Saida_ForwardA_In(ForwardA),
      .Saida_Mux_FWRBA_Out(Saida_Mux_ForwardA)
  );

  Somador4 ADD_PC(.a(PC_Out),.saida(PC_Out_Mais_4));

  Somador AddALU(
      .a(ID_PC),
      .b(Saida_Shift_Left2),
      .saida(Saida_Somador)
  );
  ALU ALU1(
      .controle(Controle_ALU),
      .ALUIN_A(Saida_Mux_ForwardA),
      .ALUIN_B(Saida_Mux_ForwardB),
      .zero(Zero),
      .saida(ALUresult)
  );

  LeftShift2 Shift2(
      .entrada(Saida_Ext_Sinal),
      .saida(Saida_Shift_Left2)
  );

  Door_BNE_BEQ DoorAND(
    .branch(MEM_Branch),
    .flag(MEM_Zero),
    .out(Door_out)
    );

  MUX_32b MuxBranch(
      .entrada1(PC_Out_Mais_4),
      .entrada2(Saida_Somador),
      .controle(Door_out),
      .saida(PC_IN)
  );

  Data_Memory DataMemory(
      .Clk(Clock),
      .Address(MEM_ALUresult),
      .MemRead(MEM_MemRead),
      .MemWrite(MEM_MemWrite),
      .WriteData(MEM_readData2),
      .ReadData(Saida_Memory_ReadData)
  );


  MUX_32b MUX_MemtoReg(
      .entrada2(WB_readData),
      .entrada1(WB_ALUresult),
      .controle(WB_MemtoReg),
      .saida(WB_WriteData)
  );

  IF_ID REG_IF_ID(
      .reset(reset),
      .SaidaSOMA4_In(PC_Out_Mais_4),
      .clk(Clock),
      .Instruction_In(Instruction),
      .IF_IDWrite_In(IF_ID_Stall_Write),
      .ID_PC_Out(ID_PC),
      .ID_Instruction_Out(ID_Instruction)
  );

  ID_EXE REG_ID_EXE(
      .reset(reset),
      .clk(Clock),
      .MemRead_In(MemRead),
      .MemWrite_In(MemWrite),
      .Branch_In(Branch),
      .RegDst_In(RegDst),
      .ALUOp_In(ALUOp),
      .MemtoReg_In(MemtoReg),
      .RegWrite_In(RegWrite),
      .ALUSrc_In(ALUSrc),
      .ReadData1_In(ReadData1),
      .Saida_Ext_Sinal_In(Saida_Ext_Sinal),
      .ID_Instruction_In(ID_Instruction),
      .ReadData2_In(ReadData2),
      .ID_PC_In(ID_PC),
      .EX_Branch_Out(EX_Branch),
      .EX_RegDst_Out(EX_RegDst),
      .EX_MemRead_Out(EX_MemRead),
      .EX_ALUSrc_Out(EX_ALUSrc),
      .EX_RegWrite_Out(EX_RegWrite),
      .EX_PC_Out(EX_PC),
      .EX_MemWrite_Out(EX_MemWrite),
      .EX_ReadData1_Out(EX_ReadData1),
      .EX_MemtoReg_Out(EX_MemtoReg),
      .EX_ALUOp_Out(EX_ALUOp),
      .EX_Instruction_Out(EX_Instruction),
      .EX_ReadData2_Out(EX_ReadData2),
      .EX_Saida_Ext_Sinal_Out(EX_Saida_Ext_Sinal)
  );

  EXE_MEM REG_EXE_MEM(
    .reset(reset),
      .clk(Clock),
      .zero(Zero),
      .EX_MemWrite_In(EX_MemWrite),
      .EX_MemRead_In(EX_MemRead),
      .EX_MemtoReg_In(EX_MemtoReg),
      .WriteRegister_In(Index_WriteReg),
      .EX_RegWrite_In(EX_RegWrite),
      .EX_Branch_In(EX_Branch),
      .ALUresult_In(ALUresult),
      .EX_ReadData2_In(EX_ReadData2),
      .MEM_ALUresult_Out(MEM_ALUresult),
      .MEM_MemWrite_Out(MEM_MemWrite),
      .MEM_RegWrite_Out(MEM_RegWrite),
      .MEM_ReadData2_Out(MEM_readData2),
      .MEM_MemRead_Out(MEM_MemRead),
      .MEM_Zero_Out(MEM_Zero),
      .MEM_MemtoReg_Out(MEM_MemtoReg),
      .MEM_Branch_Out(MEM_Branch),
      .MEM_WriteRegister_Out(MEM_Index_WriteReg)
  );

  MEM_WB REG_MEM_WB(
      .reset(reset),
      .clk(Clock),
      .MEM_RegWrite_In(MEM_RegWrite),
      .MEM_Index_WriteReg_In(MEM_Index_WriteReg),
      .ReadData_In(Saida_Memory_ReadData),
      .MEM_MemtoReg_In(MEM_MemtoReg),
      .MEM_ALUresult_In(MEM_ALUresult),
      .WB_ALUresult_Out(WB_ALUresult),
      .WB_MemtoReg_Out(WB_MemtoReg),
      .WB_RegWrite_Out(WB_RegWrite_Enable),
      .WB_readData_Out(WB_readData),
      .WB_Index_WriteReg_Out(WB_Index_WriteReg)
  );

  Harzard Hazard_Module(
    .reset(reset),
    .EX_MemRead_In(EX_MemRead),
    .EX_Instruction_In(EX_Instruction),
    .ID_Instruction_In(ID_Instruction),
    .Controller_Write_Out(Controller_Write),
    .IF_ID_Stall_Write_Out(IF_ID_Stall_Write),
    .PC_Freeze_Out(PC_Freeze)
    );

  Forwarding Forward_Module(
      .reset(reset),
      .MEM_RegWrite_In(MEM_RegWrite),
      .EX_Instruction_In(EX_Instruction),
      .MEM_WriteRegister_In(MEM_Index_WriteReg),
      .clk(Clock),
      .WB_WriteRegister_In(WB_Index_WriteReg),
      .WB_RegWrite_In(WB_RegWrite_Enable),
      .ForwardA_Out(ForwardA),
      .ForwardB_Out(ForwardB)
  );


  Clock CLK(
    .CLOCK(Clock)
    );

/*initial begin
  #1 reset = 1;
  #1 reset = 0;
  $dumpfile("MIPS.vcd");
  $dumpvars;
  #60 $finish;
end*/
initial begin
  $dumpfile("MIPS.vcd");
  $dumpvars;
  #60 $finish;
end
initial begin
  #1 reset = 1;
  #1 reset = 0;
end
endmodule //TopLevelSimulation
