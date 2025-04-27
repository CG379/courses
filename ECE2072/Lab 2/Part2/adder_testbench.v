// Need a separate file to work?
`timescale 1ns / 1ps
module adder_testbench;
	reg [3:0] in1, in2;
   reg cin;
   wire [3:0] sum;
   wire cout;
	
	ripple_carry_adder dut(.a(in1), .b(in2), .cin(cin), .sum(sum), .cout(cout));

	integer errors, count;
	integer i, j, k;
	
 	initial begin
      in1 = 4'b0000;
		in2 = 4'b0000;
      cin = 1'b0;
 		errors = 0;
		count = 0;
		
	// Test all possible combinations
		for (i = 0; i < 16; i = i + 1) begin
			for (j = 0; j < 16; j = j + 1) begin
				for (k = 0; k < 2; k = k + 1) begin
					in1 = i;
               in2 = j;
               cin = k;
					#9
					// Converts the 4 bit and 1 bit to 5 bit
					if ({cout, sum} != (in1 + in2 + cin)) begin
							// Couldn't get it working using $time
							$display("Error for input (%b, %b, %b).", in1, in2, cin); // $time);
							// GPT said this correctly adds them? 
							//$display("Expected: %b, Got: %b%b", in1 + in2 + cin, cout, sum);
							errors = errors + 1;
					end
					#1
					count = count + 1;
				end
			end
		end

		$display("Done with tests.");
		$display("There were %d errors out of %d tests.", errors, count);
		$stop;
 	end
endmodule
