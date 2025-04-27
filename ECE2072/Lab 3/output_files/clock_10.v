module clock_10 (CLOCK_50, LEDR, GPIO);
	input CLOCK_50;
	output [9:0]LEDR;
	output [2:2]GPIO;
	
	reg clock_10 = 0; 
	// 0 to 4
	reg [23:0] counter_50 = 0;
	// Output for LEDs
	reg [9:0] counter_10 = 0;
	
	// FOr 10Hz clock
	always @(posedge CLOCK_50) begin
		// counter from 0 to 4,
		// when reaches 4 change state of 10Hz clock and set counter to 0
		if (counter_50 == 23'd5_000_000/2-1) begin
			counter_50 <= 0;
			clock_10 <= ~clock_10;
		end else begin
			counter_50 <= counter_50 + 1;
		end 
   end
	
	// Inriment counter on 10Mhz, needs posedge to sync with CLOCK_50
	always @(posedge clock_10) begin
			// <= assigns at the end of the step, prevents race conditions?
			counter_10 <= counter_10 + 1;
   end
	 
   assign LEDR = counter_10;
   assign GPIO[2] = clock_10;

endmodule
