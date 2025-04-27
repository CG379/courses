module wallace_test(SW, LEDR);
   input [7:0] SW;
   output [7:0] LEDR;
	
	wallace_tree test(.A(SW[3:0]), .B(SW[7:4]), .output_products(LEDR[7:0]));
endmodule 