module Memoria_instrucoes (endereco,instrucao,reset);
  input [31:0]endereco;
  input reset;
  output reg [31:0] instrucao;
  reg [31:0]I_Mem[0:31];

always @ ( * ) begin
  if (reset) begin
        I_Mem[0] <= 32'b00000001000010010101000000100000;  //add $t2,$t0,$t1
        I_Mem[1] <= 32'b00000010000100011001000000100000;  //add $s2,$s0,$s1
        I_Mem[2] <= 32'b00000010100100111010100000100010;  //sub $s5,$s4,$s3
        I_Mem[3] <= 32'b00000001100010110110100000100010;  //sub $t5,$t4,$t3
        I_Mem[4] <= 32'b00000010010011011011000000100101;  //or $s6,$s2,$t5
        I_Mem[5] <= 32'b00000001010101010111000000100101;  //or $t6,$t2,$s5     //ultima instrução desvia de volta para esta//
        I_Mem[6] <= 32'b00000010010011011011100000100100;  //and $s7,$s2,$t5
        I_Mem[7] <= 32'b00000001010101010111100000100100;  //and $t7,$t2,$s5
        I_Mem[8] <= 32'b00000001110011010100100000101010; //slt $t1,$s6,$s5
        I_Mem[9] <= 32'b00000001101011101000100000101010; //slt $s1,$s5,$s6
        I_Mem[10] <= 32'b10001110010010100000000000000100; //lw $t2,4($s0)
        I_Mem[11] <= 32'b10001110001010110000000000001000; //lw $t3,8($s1)
        I_Mem[12] <= 32'b10101110010011000000000000000100; //sw $t4,4($s0)
        I_Mem[13] <= 32'b10101110001011010000000000001000; //sw $t5,8($s1)
        I_Mem[14] <= 32'b00000010010011010100000000100110; //xor $t0,$s2,$t5
        I_Mem[15] <= 32'b00000001010101011000000000100110; //xor $s0,$t2,$s5      //Deixei apenas instruções de 0 ate 15 para evitar loops de BNE.
        /*I_Mem[16] <= 32'b00000010010011010100000000100101;  //nor $t0,$s2,$t5
        I_Mem[17] <= 32'b00000001010101011000000000100101;  //nor $s0,$t2,$s5
        I_Mem[18] <= 32'b00010110100101010000000000000001; //bne bne $s4,$s5,1 //esse desvio muda pc para 80.
        I_Mem[19] <= 32'b00010110100101010000000000000001; //bne   ///essa instrução é pulada devido ao desvio acima.
        I_Mem[20] <= 32'b00010010001101011111111111110000; //beq $s1,$s5,-16 //esse desvio muda pc para 20.
        */
    end
  end
  always @ (endereco) begin
    instrucao <= I_Mem[endereco/4];
  end
endmodule //Memoria_instrucoes
