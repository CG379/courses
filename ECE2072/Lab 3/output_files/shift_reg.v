module shift_reg (clk, D, Q);
	input clk;
	input D;
	output reg [4:0]Q;
	
	// Each tick combines the last 3 + D bit
	always @(posedge clk) begin
		Q <= {Q[3:0], D};
	end

endmodule