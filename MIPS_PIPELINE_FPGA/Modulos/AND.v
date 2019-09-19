module Door_BNE_BEQ (branch,flag,out); //substituto para porte AND na implementacao de bne e beq.
  input [1:0] branch; //00 para desativado, 11 para beq, 01 para bne;
  input flag;
  output reg out;
  always @ ( * ) begin
  case (branch)
    2'b00: out = 0;
    2'b11: out = (flag == 1) ? 1 : 0; //BEQ
    2'b01: out = (flag != 1) ? 1 : 0; //BNE
    default: out = 0;
  endcase
  end
endmodule //Door_BNE_BEQ
