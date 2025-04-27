module lfsr(clk, reset, Q);
    input clk;
    input reset;
    output reg [4:0] Q;
    
	 wire feedback;
    
    // feedback bit
    assign feedback = ~(Q[4] ^ Q[2]);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
				// 0 doesn't work
            Q <= 5'b00000;
        end else begin
            Q <= {Q[3:0], feedback};
        end
    end
endmodule