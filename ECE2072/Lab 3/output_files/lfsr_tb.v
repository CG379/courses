`timescale 1ns / 1ps
module lfsr_tb;

	reg clk;
   reg reset;
   wire [4:0] Q;
   integer i;
   reg [4:0] expected_sequence [0:31];
   integer errors;
	
	lfsr clock (.clk(clk), .reset(reset),.Q(Q));
	
	
	// chatGPT said this is how you do the clock?
	
   always #5 clk = ~clk;

    // Test sequence
    initial begin
        
        clk = 0;
        reset = 1;
        errors = 0;

        // Expected sequence
			expected_sequence[0]  = 0;
			expected_sequence[1]  = 1;
			expected_sequence[2]  = 3;
			expected_sequence[3]  = 7;
			expected_sequence[4]  = 14;
			expected_sequence[5]  = 28;
			expected_sequence[6]  = 25;
			expected_sequence[7]  = 18;
			expected_sequence[8]  = 4;
			expected_sequence[9]  = 8;
			expected_sequence[10] = 17;
			expected_sequence[11] = 2;
			expected_sequence[12] = 5;
			expected_sequence[13] = 10;
			expected_sequence[14] = 21;
			expected_sequence[15] = 11;
			expected_sequence[16] = 23;
			expected_sequence[17] = 15;
			expected_sequence[18] = 30;
			expected_sequence[19] = 29;
			expected_sequence[20] = 27;
			expected_sequence[21] = 22;
			expected_sequence[22] = 13;
			expected_sequence[23] = 26;
			expected_sequence[24] = 20;
			expected_sequence[25] = 9;
			expected_sequence[26] = 19;
			expected_sequence[27] = 6;
			expected_sequence[28] = 12;
			expected_sequence[29] = 24;
			expected_sequence[30] = 16;
			expected_sequence[31] = 0;
			
			#10 
			reset = 0;
			
			$display("Starting LFSR Test...");

			// Apply clock cycles and check the output
			for (i = 0; i < 32; i = i + 1) begin
				// GPT says this is how you wait for the clock
				// Works with negedge better???
				@(negedge clk);
				// add a small delay to wait for things to catch up
				#1
            if (Q !== expected_sequence[i]) begin
                $display("Error at cycle %2d: Expected %2d, Got %2d", i, expected_sequence[i], Q);
                errors = errors + 1;
            end else begin
                $display("Cycle %2d: Q = %2d (Correct)", i, Q);
            end
        end

        if (errors == 0) begin
            $display("Test Passed: All outputs are correct.");
        end else begin
            $display("Test Failed. Errors: %d", errors);
        end

        $stop;
    end

endmodule