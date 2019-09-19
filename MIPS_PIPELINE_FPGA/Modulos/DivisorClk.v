module DivisorClk(clk,clk_out);
input clk;
output reg clk_out = 0;
reg [31:0] aux_clk = 0;

always @ ( posedge clk ) begin
  aux_clk <= aux_clk + 1;
  if(aux_clk == 1500000)begin
    aux_clk <= 0;
    clk_out <= ~(clk_out);
  end
end

endmodule // DivisorClk
