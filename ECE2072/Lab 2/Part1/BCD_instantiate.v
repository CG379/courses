module BCD_instantiate(SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input [3:0]SW;
	// Hex outs 0 to 5
	output [6:0]HEX0;
	output [6:0]HEX1;
	output [6:0]HEX2;
	output [6:0]HEX3;
	output [6:0]HEX4;
	output [6:0]HEX5;
	
	// To get out
	wire [3:0] ones;
	
	ones_counter(.in(SW[3:0]), .count(ones));
	
	// Feed each one the number
	bcd(.in(ones), .Hex(HEX0));
	bcd(.in(ones), .Hex(HEX1));
	bcd(.in(ones), .Hex(HEX2));
	bcd(.in(ones), .Hex(HEX3));
	bcd(.in(ones), .Hex(HEX4));
	bcd(.in(ones), .Hex(HEX5));
	
	
endmodule 