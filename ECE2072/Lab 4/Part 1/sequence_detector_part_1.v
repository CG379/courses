module sequence_detector_part_1 (SW, KEY, LEDR);
	input [1:0] SW;
   input [0:0] KEY;
   output [9:0] LEDR;
    
   wire Clock, Resetn, w;
   assign Clock = ~KEY[0];
   assign Resetn = ~SW[0];
   assign w = SW[1];
   // y = current state, d = next state?
   wire [8:0] y, d;
   wire z;
    
   // Instantiate flip flops for each state:
   flipflop A(.D(d[0]), .Clock(Clock), .Resetn(Resetn), .Setn(1'b1), .Q(y[0]));
   flipflop B(.D(d[1]), .Clock(Clock), .Resetn(Resetn), .Setn(1'b1), .Q(y[1]));
   flipflop C(.D(d[2]), .Clock(Clock), .Resetn(Resetn), .Setn(1'b1), .Q(y[2]));
   flipflop D(.D(d[3]), .Clock(Clock), .Resetn(Resetn), .Setn(1'b1), .Q(y[3]));
   flipflop E(.D(d[4]), .Clock(Clock), .Resetn(Resetn), .Setn(1'b1), .Q(y[4]));
   flipflop F(.D(d[5]), .Clock(Clock), .Resetn(Resetn), .Setn(1'b1), .Q(y[5]));
   flipflop G(.D(d[6]), .Clock(Clock), .Resetn(Resetn), .Setn(1'b1), .Q(y[6]));
   flipflop H(.D(d[7]), .Clock(Clock), .Resetn(Resetn), .Setn(1'b1), .Q(y[7]));
   flipflop I(.D(d[8]), .Clock(Clock), .Resetn(Resetn), .Setn(1'b1), .Q(y[8]));
    
   // Next state logic:
	// A
   assign d[0] = (Resetn);
   // B
	assign d[1] = (y[0] & ~w) | (y[5] & ~w) | (y[6] & ~w) | (y[7] & ~w) | (y[8] & ~w);
	//C
   assign d[2] = y[1] & ~w;
	// D
   assign d[3] = y[2] & ~w;
	//E
   assign d[4] = y[3] & ~w;
	//F
   assign d[5] = (y[0] & w) | (y[1] & w) | (y[2] & w) | (y[3] & w) | (y[4] & w);
	// G
   assign d[6] = y[5] & w;
	//H
   assign d[7] = y[6] & w;
	//I
   assign d[8] = y[7] & w;
    
   // Output logic:
   assign z = y[4] | y[8];
    
   // Assign outputs to LEDs:
   assign LEDR[8:0] = y;
   assign LEDR[9] = z;

endmodule


module flipflop (D, Clock, Resetn, Setn, Q);
	input D, Clock, Resetn, Setn;
	output reg Q;
	always @(posedge Clock) begin
		if (!Resetn) // synchronous clear
			Q <= 1'b0;
		else if (!Setn) // synchronous set
			Q <= 1'b1;
		else
			Q <= D;
	end
endmodule