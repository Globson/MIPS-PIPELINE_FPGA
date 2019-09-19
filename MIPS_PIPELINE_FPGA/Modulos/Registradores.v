module Registradores (clk,RegWrite,ReadReg1,ReadReg2,WriteReg,WriteData,ReadData1,ReadData2,reset);
  input RegWrite;
  input wire clk,reset;
  input [ 4:0]ReadReg1;
  input [ 4:0]ReadReg2;
  input [ 4:0] WriteReg;
  input [31:0] WriteData;
  output reg [31:0]ReadData1;
  output reg [31:0]ReadData2;
  reg [31:0]Regs[0:31];

always @ ( posedge clk ) begin// posedge clock antes
  if(reset == 1) begin
      Regs[0] <= 0;   //$zero
      Regs[1] <= 0;   //at
      Regs[2] <= 0;   //v1
      Regs[3] <= 0;   //v2
      Regs[4] <= 0;   //a0
      Regs[5] <= 0;   //a1
      Regs[6] <= 0;   //a2
      Regs[7] <= 0;   //a3
      Regs[8] <= 10;  //t0     //Registradores usados em testes : Reg[8] $t0 ate Reg[23] $s7
      Regs[9] <= 20;  //t1
      Regs[10] <= 22; //t2
      Regs[11] <= 40; //t3
      Regs[12] <= 50; //t4
      Regs[13] <= 60; //t5
      Regs[14] <= 70; //t6
      Regs[15] <= 80; //t7
      Regs[16] <= 1;  //s0
      Regs[17] <= 2;  //s1
      Regs[18] <= 0;  //s2
      Regs[19] <= 4;  //s3
      Regs[20] <= 5;  //s4
      Regs[21] <= 6;  //s5
      Regs[22] <= 7;  //s6
      Regs[23] <= 8;  //s7
      Regs[24] <= 0;  //t8
      Regs[25] <= 0;  //t9
      Regs[26] <= 0;  //k0
      Regs[27] <= 0;  //k1
      Regs[28] <= 0;  //gp
      Regs[29] <= 0;  //sp
      Regs[30] <= 0;  //s8
      Regs[31] <= 0;  //ra
  end

  else if(RegWrite) begin
    Regs[WriteReg] <= WriteData;
  end

end

  always @ (ReadReg1 or ReadReg2) begin
    ReadData1 <= Regs[ReadReg1];
    ReadData2 <= Regs[ReadReg2];
  end

endmodule //Registradores
