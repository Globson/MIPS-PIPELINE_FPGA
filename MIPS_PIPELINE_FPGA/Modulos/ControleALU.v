`define ALU_ADD 4'b0000
`define ALU_SUB 4'b0010
`define ALU_AND 4'b0100
`define ALU_OR  4'b0101
`define ALU_NOR 4'b0110
`define ALU_XOR 4'b0111
`define ALU_SLT 4'b1000

module ControleALU (OpCode_ALU,Func_Code,Controle_ALU);
  input [1:0] OpCode_ALU;
  input [5:0]Func_Code;
  output reg [3:0]Controle_ALU;

  always @ ( OpCode_ALU or Func_Code ) begin
    case(OpCode_ALU)
       0: begin //LW ou SW
          Controle_ALU = `ALU_ADD;
          end
       1: begin //BEQ
         Controle_ALU = `ALU_SUB;
          end
       2: begin
            case (Func_Code)
            32:begin //ADD
                 Controle_ALU = `ALU_ADD;
               end
            34:begin //SUB
                 Controle_ALU = `ALU_SUB;
               end
            36:begin //AND
                 Controle_ALU = `ALU_AND;
               end
            38:begin //XOR
                 Controle_ALU = `ALU_XOR;
              end
            37:begin //OR
                 Controle_ALU = `ALU_OR;
               end
            39:begin //NOR
                Controle_ALU = `ALU_NOR;
               end
            42:begin //SLT
                 Controle_ALU = `ALU_SLT;
               end
          endcase
          end
  endcase
  end
endmodule //ControleALU
