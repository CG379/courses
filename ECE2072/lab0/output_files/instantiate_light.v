module instantiate_light(SW, LEDR); 

	// Define the inputs and outputs to our module
	input [3:0] SW;
	output [3:0] LEDR;

	// Define a wire to connect to the output of each circuit
	wire [1:0]light_output; 


	// Create an instance of the verilog light module
	light_verilog light1(.x1(SW[1]), .x2(SW[0]), .f(light_output[0]));

	// Create an instance of the vhdl light module - the language difference doesn't matter
	light_vhdl light2(.x2(SW[2]), .x1(SW[3]), .f(light_output[1]));

	// Connect the wires connected to the output of the circuits to some red LEDs
	assign LEDR[0] = light_output[0];
	assign LEDR[1] = light_output[0]; 
	assign LEDR[2] = light_output[1];
	assign LEDR[3] = light_output[1]; 

endmodule

