module BCD_instantiate(SW, HEX0);
	input [3:0]SW;
	output [6:0]HEX0;
	
	BCD(.in(SW[3:0]), .HEX(HEX0[6:0]));
	
endmodule 