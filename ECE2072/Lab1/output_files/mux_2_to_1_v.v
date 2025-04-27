module mux_2_to_1_v(A, B, S, X);
    // Declare inputs
	input A;
	input B;
	input S;

    // Declare output
	output X;
    
    // Implement the logic using assign statements
	assign X = (A & ~S) | (B & S);
endmodule