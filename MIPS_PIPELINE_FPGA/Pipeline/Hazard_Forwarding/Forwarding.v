module Forwarding(MEM_WriteRegister_In,reset,WB_WriteRegister_In,MEM_RegWrite_In, WB_RegWrite_In, clk,EX_Instruction_In,ForwardA_Out, ForwardB_Out);
    input reset,MEM_RegWrite_In, WB_RegWrite_In,clk;
    input[4:0]MEM_WriteRegister_In;
    input[4:0]WB_WriteRegister_In;
    input[31:0]EX_Instruction_In;
    output reg[1:0]ForwardA_Out;
    output reg[1:0]ForwardB_Out;

	always @(posedge clk or reset)begin
    if(reset)begin
      ForwardA_Out = 0;
      ForwardB_Out = 0;
    end
	  else begin
			if (MEM_RegWrite_In  && (MEM_WriteRegister_In != 0) && (MEM_WriteRegister_In == EX_Instruction_In[25:21]))begin
				ForwardA_Out = 2'b11;
      end
			else if (!(MEM_RegWrite_In && (MEM_WriteRegister_In != 0) && (MEM_WriteRegister_In != EX_Instruction_In[25:21])) && WB_RegWrite_In && (WB_WriteRegister_In == EX_Instruction_In[25:21]) && (WB_WriteRegister_In != 0)) begin
				ForwardA_Out = 2'b10;
      end
			else begin
				ForwardA_Out = 2'b00;
      end
      if (MEM_RegWrite_In && (MEM_WriteRegister_In != 0) && (MEM_WriteRegister_In == EX_Instruction_In[20:16]))begin
        ForwardB_Out = 2'b11;
      end
      else if (!(MEM_RegWrite_In && (MEM_WriteRegister_In != 0) && (MEM_WriteRegister_In != EX_Instruction_In[20:16])) && WB_RegWrite_In && (WB_WriteRegister_In == EX_Instruction_In[20:16]) && (WB_WriteRegister_In != 0)) begin
        ForwardB_Out = 2'b10;
      end
      else begin
        ForwardB_Out = 2'b00;
      end
	  end
  end
  /*
  initial begin
      $monitor("\n %b\n %b \n %b",EX_Instruction_In[20:16],MEM_WriteRegister_In,EX_Instruction_In);
  end//*/
endmodule // Forwardig
