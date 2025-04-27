`timescale 1ns / 1ps
module clock_10_tb;
	reg CLOCK_50;
   // Outputs
   wire [9:0] LEDR;
   wire [2:2] out;

	clock_10 clock (.CLOCK_50(CLOCK_50), .LEDR(LEDR), .GPIO(out));

    // Clock gen
    always #10 CLOCK_50 = ~CLOCK_50; 
	 
    integer errors;

    initial begin
        // Initialize signals
        CLOCK_50 = 0;
        errors = 0;

        $display("Starting clock_10 test...");
		  // wait to start
		 #100
		// Check initial state
       if (out[2] !== 1'b0) begin
           $display("Error: Initial state of clock is not 0");
           errors = errors + 1;
       end

       // Wait for half cycle of 10Hz clock (should be 50ms = 50,000,000 ns)
       #100000000;

       // Check if out[2] has changed to 1
       if (out[2] !== 1'b1) begin
           $display("Error: Clock did not change to 1 after 100ms");
           errors = errors + 1;
       end

       // Wait for another half cycle of 10Hz clock (50ms = 50,000,000 ns)
       #100000000;

       // Check if out[2] has changed back to 0
       if (out[2] !== 1'b0) begin
           $display("Error: Clock did not change back to 0 after 200ms");
           errors = errors + 1;
       end

       // Wait for another full cycle (100ms = 100,000,000 ns)
       #100000000;

       // Check if out[2] has completed another full cycle
       if (out[2] !== 1'b0) begin
           $display("Error: Clock is not 0 after 300ms (two full cycles)");
           errors = errors + 1;
       end

       $display("Test completed. Total errors: %d", errors);
       $stop;
    end
endmodule