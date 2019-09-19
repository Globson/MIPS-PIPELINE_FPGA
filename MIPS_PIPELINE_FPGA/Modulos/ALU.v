`define ALU_ADD 4'b0000
`define ALU_SUB 4'b0010
`define ALU_AND 4'b0100
`define ALU_OR  4'b0101
`define ALU_NOR 4'b0110
`define ALU_XOR 4'b0111
`define ALU_SLT 4'b1000

module ALU (controle,ALUIN_A,ALUIN_B,zero,saida);
  input wire [3:0]controle;
  input wire [31:0]ALUIN_A;
  input wire [31:0]ALUIN_B;
  output reg [31:0]saida;
  output zero;
  
  always @ (*) begin
    case (controle)
      `ALU_ADD: saida <= ALUIN_A + ALUIN_B;
      `ALU_SUB: saida <= ALUIN_A - ALUIN_B;
      `ALU_AND: saida <= ALUIN_A & ALUIN_B;
      `ALU_OR:  saida <= ALUIN_A | ALUIN_B;
      `ALU_NOR: saida <= ~(ALUIN_A | ALUIN_B);
      `ALU_XOR: saida <= ALUIN_A ^ ALUIN_B;
      `ALU_SLT: saida <= ALUIN_A < ALUIN_B ? 1 : 0; // seta 1 caso ALUIN_A < ALUIN_B, caso contrario 0.//
      default: saida <= 0;
    endcase
  end
  assign zero = (saida == 0);
endmodule //ALU
