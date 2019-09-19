module Controller (clk,Opcode,Controller_Write,RegDst,Branch,MemRead,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite);
  input [5:0] Opcode;
  input clk,Controller_Write;
  output reg RegDst,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite;
  output reg [1:0] ALUOp;
  output reg [1:0] Branch;
  always @ ( negedge clk or Opcode ) begin
      if(Controller_Write == 1 ) begin //Bolha Stall
        RegDst <= 1'b0;
        ALUSrc <= 1'b0;
        RegWrite <= 1'b0;
        MemtoReg <= 1'b0;
        MemRead <= 1'b0;
        ALUOp <= 2'b00;
        MemWrite <= 1'b0;
        Branch <= 2'b0;
      end
      else begin
        case(Opcode)
          0:begin //ADD, SUB, AND, OR, SLT, NOR, XOR
            RegDst = 1;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUOp = 2;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 1;
            end
          4:begin //BEQ
            RegDst = 1'bx;
            Branch = 2'b11;
            MemRead = 0;
            MemtoReg = 1'bx;
            ALUOp = 1;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;
            end
          5:begin //BNE
            RegDst = 1'bx;
            Branch = 2'b01;
            MemRead = 0;
            MemtoReg = 1'bx;
            ALUOp = 1;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;
            end
         35:begin //LW
            RegDst = 0;
            Branch = 0;
            MemRead = 1;
            MemtoReg = 1;
            ALUOp = 0;
            MemWrite = 0;
            ALUSrc = 1;
            RegWrite = 1;
            end
         43:begin //SW
            RegDst = 1'bx;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 1'bx;
            ALUOp = 0;
            MemWrite = 1;
            ALUSrc = 1;
            RegWrite = 0;
            end
      endcase
    end
  end
endmodule //Controller
