module BCD(A, X);
    // declare inputs ...
	input [0:3]A;
    // declare outputs ...
	output [6:0]X;
    // implement your logic using assign statements ...
	
	// Each letter to a bit of the output
	wire a, b, c, d, e, f, g;
	assign X[0] = a;
	assign X[1] = b;
	assign X[2] = c;
	assign X[3] = d;
	assign X[4] = e;
	assign X[5] = f;
	assign X[6] = g;
	
	// reverses order if I don't do this
	wire b0, b1, b2, b3;
	assign b0 = A[3];
	assign b1 = A[2];
	assign b2 = A[1];
	assign b3 = A[0];
	
	
	// all odd nums and 4
	assign e = b0 | (b2 & ~b1);
	// Not 1 or 4
	assign a = (~b3 & ~b2 & ~b1 & b0) | (~b3 & b2 & ~b1 & ~b0);
	// not 5 or 6
   assign b = (~b3 & b2 & ~b1 & b0) | (~b3 & b2 & b1 & ~b0);
	// not 2 only
   assign c = ~b3 & ~b2 & b1 & ~b0;
	// not 1, 4 or 7
   assign d = (~b3 & ~b2 & ~b1 & b0) | (~b3 & b2 & ~b1 & ~b0) | (~b3 & b2 & b1 & b0);
	// not 1,2,3 or 7
   assign f = (~b3 & ~b2 & (b1 | b0)) | (~b3 & b2 & b1 & b0);
	// not 0, 1 or 7
   assign g = (~b3 & ~b2 & ~b1) | (~b3 & b2 & b1 & b0);
	
	// Active low, 0 = on
	
endmodule
