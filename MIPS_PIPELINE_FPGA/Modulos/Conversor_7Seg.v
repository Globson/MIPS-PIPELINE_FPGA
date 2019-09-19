module Conversor_7Seg_Melhorado (entrada,display0,display1,display2,display3,display4,display5,display6,display7);
  input [31:0]entrada;
  output [6:0] display0,display1,display2,display3,display4,display5,display6,display7;

  wire [31:0] Aux0 = entrada %10;
  wire [31:0] Aux1 = (entrada %100 - Aux0)/10;
  wire [31:0] Aux2 = (entrada %1000 -Aux1*10 - Aux0)/100;
  wire [31:0] Aux3 = (entrada %10000 -Aux2*100 -Aux1*10 - Aux0)/1000;
  wire [31:0] Aux4 = (entrada %100000 -Aux3*1000 -Aux2*100 -Aux1*10 - Aux0)/10000;
  wire [31:0] Aux5 = (entrada %1000000 -Aux4*10000 -Aux3*1000 -Aux2*100 -Aux1*10 - Aux0)/100000;
  wire [31:0] Aux6 = (entrada %10000000 -Aux5*100000 -Aux4*10000 -Aux3*1000 -Aux2*100 -Aux1*10 - Aux0)/1000000;
  wire [31:0] Aux7 = (entrada %100000000 -Aux6*1000000 -Aux5*100000 -Aux4*10000 -Aux3*1000 -Aux2*100 -Aux1*10 - Aux0)/10000000;

  assign display0 = (Aux0 == 32'd0) ? 7'b1000000:
               (Aux0 == 32'd1) ? 7'b1111001:
               (Aux0 == 32'd2) ? 7'b0100100:
               (Aux0 == 32'd3) ? 7'b0110000:
               (Aux0 == 32'd4) ? 7'b0011001:
               (Aux0 == 32'd5) ? 7'b0010010:
               (Aux0 == 32'd6) ? 7'b0000010:
               (Aux0 == 32'd7) ? 7'b1111000:
               (Aux0 == 32'd8) ? 7'b0000000:
               (Aux0 == 32'd9) ? 7'b0010000: 7'b1111111;

  assign display1 = (Aux1 == 32'd0) ? 7'b1000000:
               (Aux1 == 32'd1) ? 7'b1111001:
               (Aux1 == 32'd2) ? 7'b0100100:
               (Aux1 == 32'd3) ? 7'b0110000:
               (Aux1 == 32'd4) ? 7'b0011001:
               (Aux1 == 32'd5) ? 7'b0010010:
               (Aux1 == 32'd6) ? 7'b0000010:
               (Aux1 == 32'd7) ? 7'b1111000:
               (Aux1 == 32'd8) ? 7'b0000000:
               (Aux1 == 32'd9) ? 7'b0010000: 7'b1111111;

  assign display2 = (Aux2 == 32'd0) ? 7'b1000000:
                (Aux2 == 32'd1) ? 7'b1111001:
                (Aux2 == 32'd2) ? 7'b0100100:
                (Aux2 == 32'd3) ? 7'b0110000:
                (Aux2 == 32'd4) ? 7'b0011001:
                (Aux2 == 32'd5) ? 7'b0010010:
                (Aux2 == 32'd6) ? 7'b0000010:
                (Aux2 == 32'd7) ? 7'b1111000:
                (Aux2 == 32'd8) ? 7'b0000000:
                (Aux2 == 32'd9) ? 7'b0010000: 7'b1111111;

   assign display3 = (Aux3 == 32'd0) ? 7'b1000000:
                (Aux3 == 32'd1) ? 7'b1111001:
                (Aux3 == 32'd2) ? 7'b0100100:
                (Aux3 == 32'd3) ? 7'b0110000:
                (Aux3 == 32'd4) ? 7'b0011001:
                (Aux3 == 32'd5) ? 7'b0010010:
                (Aux3 == 32'd6) ? 7'b0000010:
                (Aux3 == 32'd7) ? 7'b1111000:
                (Aux3 == 32'd8) ? 7'b0000000:
                (Aux3 == 32'd9) ? 7'b0010000: 7'b1111111;

    assign display4 = (Aux4 == 32'd0) ? 7'b1000000:
                 (Aux4 == 32'd1) ? 7'b1111001:
                 (Aux4 == 32'd2) ? 7'b0100100:
                 (Aux4 == 32'd3) ? 7'b0110000:
                 (Aux4 == 32'd4) ? 7'b0011001:
                 (Aux4 == 32'd5) ? 7'b0010010:
                 (Aux4 == 32'd6) ? 7'b0000010:
                 (Aux4 == 32'd7) ? 7'b1111000:
                 (Aux4 == 32'd8) ? 7'b0000000:
                 (Aux4 == 32'd9) ? 7'b0010000: 7'b1111111;

    assign display5 = (Aux5 == 32'd0) ? 7'b1000000:
                 (Aux5 == 32'd1) ? 7'b1111001:
                 (Aux5 == 32'd2) ? 7'b0100100:
                 (Aux5 == 32'd3) ? 7'b0110000:
                 (Aux5 == 32'd4) ? 7'b0011001:
                 (Aux5 == 32'd5) ? 7'b0010010:
                 (Aux5 == 32'd6) ? 7'b0000010:
                 (Aux5 == 32'd7) ? 7'b1111000:
                 (Aux5 == 32'd8) ? 7'b0000000:
                 (Aux5 == 32'd9) ? 7'b0010000: 7'b1111111;

    assign display6 = (Aux6 == 32'd0) ? 7'b1000000:
                (Aux6 == 32'd1) ? 7'b1111001:
                (Aux6 == 32'd2) ? 7'b0100100:
                (Aux6 == 32'd3) ? 7'b0110000:
                (Aux6 == 32'd4) ? 7'b0011001:
                (Aux6 == 32'd5) ? 7'b0010010:
                (Aux6 == 32'd6) ? 7'b0000010:
                (Aux6 == 32'd7) ? 7'b1111000:
                (Aux6 == 32'd8) ? 7'b0000000:
                (Aux6 == 32'd9) ? 7'b0010000: 7'b1111111;

    assign display7 = (Aux7 == 32'd0) ? 7'b1000000:
                (Aux7 == 32'd1) ? 7'b1111001:
                (Aux7 == 32'd2) ? 7'b0100100:
                (Aux7 == 32'd3) ? 7'b0110000:
                (Aux7 == 32'd4) ? 7'b0011001:
                (Aux7 == 32'd5) ? 7'b0010010:
                (Aux7 == 32'd6) ? 7'b0000010:
                (Aux7 == 32'd7) ? 7'b1111000:
                (Aux7 == 32'd8) ? 7'b0000000:
                (Aux7 == 32'd9) ? 7'b0010000: 7'b1111111;





endmodule //Conversor_7Seg_Melhorado
