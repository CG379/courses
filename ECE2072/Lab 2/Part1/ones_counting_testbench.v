// set the time scale
`timescale 1ns/1ps
module ones_counting_testbench;
	// Add your code here to create I/O variables
	reg [3:0] in;
   wire [3:0] count;
	
	// Instantiate the module that your are testing
	ones_counter test1 (.in(in), .count(count));
	
	
   integer errors;
   integer test_case;
    
	
	initial begin
		// Add your code here
		in = 4'b0000; // 4'd0 is equivalent?
      errors = 0;
      test_case = 0;
		
	end

	always begin
		#10
		// increment your input variables
		in = in + 1;
	end

	// create and initialize your testbench statistics
	
	always begin
		#9
		if (test_case == 16) begin
			#10 $display("Finished. Errors: %d", errors);
			// Stop the test bench
			$stop;
		end

		if (count != (in[0] + in[1] + in[2] + in[3])) begin
			// Service the error
			$display("Error: Input = %b, Expected Out = %d, Actual Out = %d",in, in[0] + in[1] + in[2] + in[3], count);
            errors = errors + 1;
		end
		#1
		// increment the test case count
		test_case = test_case + 1;
	end
endmodule
