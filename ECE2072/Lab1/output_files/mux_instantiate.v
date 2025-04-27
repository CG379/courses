module mux_instantiate(SW, LEDR);

	// Define the inputs and outputs to our module
	input [3:0]SW;
	output [0:0]LEDR; 

	// Create an instance of mux_2_to_1_v module
	mux_2_to_1_v mux_instance(.A(SW[2]), .B(SW[1]),.S(SW[0]),.X(LEDR[0]));

endmodule

// ChatGPT used to depug and format