module MAC(SW, KEY, LEDR);
   input [7:0] SW;
   input [0:0] KEY;
   output [7:0] LEDR;
	
	altmult1 mac_instance(.clock0(~KEY[0]), .dataa(SW[3:0]), .datab(SW[7:4]), .result(LEDR[7:0]));

endmodule 