module full_adder(SW, LEDR);

	input [2:0]SW;
   output [1:0]LEDR;
	 
	wire A;
	wire B;
	wire Cin;
	 
	 
	assign A = SW[0];
   assign B = SW[1];
   assign Cin = SW[2];
	 
	// S = 1 if only 1 of A,B,Cin are 1: XOR
	assign LEDR[0] = (A ^ B) ^ Cin;
	// Cout high if any 2 of A,B,Cin are 1 or all 3 are high
	// A And B for 2 case and 3 case, Cin And XOR for cases with Cin
   assign LEDR[1] = (A & B)|(Cin & (A ^ B));

endmodule
