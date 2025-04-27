`timescale 1ns/1ns
/*
Monash University ECE2072: Assignment 
This file contains a Verilog test bench to test the correctness of the individual 
    components used in the processor.

Please enter your student ID: 33110018

*/

// Author: Campbell
// Stucture: Make each tb a module + have an overall module to call all tbs


module sign_extender_tb;
	reg [8:0] in_9bit = 9'b0;
	wire [15:0] out_16bit;

	// Instantiate the sign extender
	sign_extend sign_extend_test (.in(in_9bit), .ext(out_16bit));
	integer i;
	// reg [element length] list [list length]
	reg [8:0] test_cases [0:5];
	
	// Initail values
	initial begin
		// Edge cases, 0 max (255) min (-256)
		test_cases[0] = 9'b000000000;
		test_cases[1] = 9'b011111111;
		test_cases[2] = 9'b100000000;
		// test compliments (-255) and pos random num (85) and neg random num (-86)
		test_cases[3] = 9'b100000001;
		test_cases[4] = 9'b001010101;
		test_cases[5] = 9'b110101010;
		// Wait for values
		#10
		for (i = 0; i < 6; i = i + 1) begin
			in_9bit = test_cases[i];
         #10;
         $display("Test Case %0d:", i);
         $display("Input:  %b (%0d)", in_9bit, $signed(in_9bit));
         $display("Output: %b (%0d)", out_16bit, $signed(out_16bit));
         // Pad check + 			 Value check
         if (((in_9bit[8] == 1'b0 && out_16bit[15:9] == 7'b0000000) || 
                 (in_9bit[8] == 1'b1 && out_16bit[15:9] == 7'b1111111)) && 
                ($signed(in_9bit) == $signed(out_16bit))) begin 		
				$display("Test %d: Pass", i);
         end else begin
            $display("Test %d: Fail", i);
         end
			$display("");
      end
	end
	// no need to stop, taken care of in main function 
endmodule

// sign bit check condition (in[8] == 1'b0 && out[15:9] == 7'b0000000) || (in[8] == 1'b1 && out[15:9] == 7'b1111111)


module tick_FSM_tb;

   // Inputs
	reg rst;
   reg clk;
   reg enable;
	integer errors;

   // Outputs
   wire [3:0] tick;

   // Instantiate the Unit Under Test (UUT)
   tick_FSM uut (.rst(rst), .clk(clk), .enable(enable), .tick(tick));
	
	// Clock generation
	initial begin
		clk = 0;
	end

	always #5 clk <= ~clk;  // 10ns period
	// Test procedure
   initial begin
      // Initialize inputs
      rst = 1;
      enable = 0;

      // Wait for global reset
      #100;
      rst = 0;
      #10; // Wait for a clock cycle after reset

      // Test case 1: No enable
      $display("Test case 1: No enable");
      if (tick !== 4'b0001) $display("Error: Unexpected tick value in idle state");
      #20;
		// Things don't work unless i check everything on the clock edge
      // Test case 2: Enable and observe ticks
      $display("Test case 2: Enable and observe ticks");
      @(posedge clk) enable = 1;
      @(posedge clk) enable = 0;
      @(posedge clk) if (tick !== 4'b0010) $display("Error: Unexpected tick value after first clock cycle");
      @(posedge clk) if (tick !== 4'b0100) $display("Error: Unexpected tick value after second clock cycle");
      @(posedge clk) if (tick !== 4'b1000) $display("Error: Unexpected tick value after third clock cycle");
      @(posedge clk) if (tick !== 4'b0001) $display("Error: FSM did not return to idle state");

      // Test case 3: Reset during operation
      $display("Test case 3: Reset during operation");
      @(posedge clk) enable = 1;
      @(posedge clk) enable = 0;
      #15 rst = 1;
      #10 if (tick !== 4'b0001) $display("Error: Reset did not return FSM to idle state");
      @(posedge clk) rst = 0;
      #20;

      // Test case 4: Continuous enable
      $display("Test case 4: Continuous enable");
      @(posedge clk) enable = 1;
      repeat(10) @(posedge clk);
      if (tick === 4'b0001) $display("Error: FSM returned to idle state while enable is high");

      // End simulation
      $display("Simulation complete");
      //$stop;
   end

   // Monitor changes
   always @(tick) begin
      $display("Time=%0t: tick=%b", $time, tick);
   end

endmodule

module alu_tb;
    reg [15:0] input_a, input_b;
    reg [2:0] alu_op;
    wire [15:0] out;
    integer i, errors, total_tests;
    reg [15:0] lfsr;

    ALU uut (.input_a(input_a), .input_b(input_b), .alu_op(alu_op), .result(out));

    // LSFR bc I am too lazy to import another file
    function [15:0] lfsr_next;
        input [15:0] current;
        begin
            lfsr_next = {current[14:0], current[15] ^ current[14] ^ current[12] ^ current[3]};
        end
    endfunction

    // Error when used as function, task 
	 // https://stackoverflow.com/questions/46814175/how-are-functions-used-in-verilog
	 // https://stackoverflow.com/questions/32658912/correct-way-of-using-tasks-in-verilog
    task check_result;
        input [15:0] expected;
        begin
            if (out !== expected) begin
                $display("Error: input_a=%d, input_b=%d, alu_op=%b, out=%d, expected=%d", 
                         input_a, input_b, alu_op, out, expected);
                errors = errors + 1;
            end
            total_tests = total_tests + 1;
        end
    endtask

    initial begin
        errors = 0;
        total_tests = 0;
        lfsr = 16'hACE1; // Seed value

        // Test each operation multiple times with different inputs
        for (i = 0; i < 20; i = i + 1) begin
            // Generate pseudo-random inputs
            input_a = lfsr;
            lfsr = lfsr_next(lfsr);
            input_b = lfsr;
            lfsr = lfsr_next(lfsr);

            // Test multiplication
            alu_op = 3'b000;
            #10 
				check_result(input_a * input_b);

            // Test addition
            alu_op = 3'b001;
            #10 
				check_result(input_a + input_b);

            // Test subtraction
            alu_op = 3'b010;
            #10 
				check_result(input_a - input_b);

            // Test signed shift
            alu_op = 3'b011;
            #10 
				check_result($signed(input_b) <<< input_a[3:0]);
        end

        // Test edge cases
        // Multiplication overflow: 32767 * 32767 = 1,073,676,289 (0x3FFF0001)
        // should truncated to 16 bits, giving 0x0001
        input_a = 16'h7FFF;
        input_b = 16'h7FFF;
        alu_op = 3'b000;
        #10 
		  check_result(16'h0001);

        // addition overflow: 32767 + 1 = 32768 (0x8000)
        // largest positive number to smallest negative number
        input_a = 16'h7FFF;
        input_b = 16'h0001;
        alu_op = 3'b001;
        #10 
		  check_result(16'h8000);

        // subtraction underflow: -32768 - 1 = 32767
        //  smallest negative number to largest positive number
        input_a = 16'h8000;
        input_b = 16'h0001;
        alu_op = 3'b010;
        #10 
		  check_result(16'h7FFF);

        // shift by 0: should not change input
        input_a = 16'h0000;
        input_b = 16'hFFFF;
        alu_op = 3'b011;
        #10 
		  check_result(16'hFFFF);

        // shift by 15: either all 0s or all 1s depending on sign bit
        input_a = 16'h000F;
        input_b = 16'hFFFF;
        alu_op = 3'b011;
        #10 
		  check_result(16'h8000);

        // Test don't care operations
        // 'x' don't care output
        // 100, 101, 110, 111
        alu_op = 3'b100;
        #10 if (out !== 16'bx) begin
            $display("Error: Don't care operation should output x");
            errors = errors + 1;
        end
        total_tests = total_tests + 1;

        alu_op = 3'b101;
        #10 if (out !== 16'bx) begin
            $display("Error: Don't care operation should output x");
            errors = errors + 1;
        end
        total_tests = total_tests + 1;

        alu_op = 3'b110;
        #10 if (out !== 16'bx) begin
            $display("Error: Don't care operation should output x");
            errors = errors + 1;
        end
        total_tests = total_tests + 1;

        alu_op = 3'b111;
        #10 if (out !== 16'bx) begin
            $display("Error: Don't care operation should output x");
            errors = errors + 1;
        end
        total_tests = total_tests + 1;

        // Report results
        $display("Tests completed. %d out of %d tests passed for ALU.", total_tests - errors, total_tests);
        if (errors == 0)
            $display("All tests passed successfully!");
        else
            $display("Some tests failed. Please review the errors above.");

        $stop;
    end
endmodule




// Author Will
module multiplexer_tb;
	reg [15:0] SignExtDin_tb;
	reg [15:0] R0_tb, R1_tb, R2_tb, R3_tb, R4_tb, R5_tb, R6_tb, R7_tb, G_tb;
	reg [3:0] sel_tb;
	integer errors;
  
	wire [15:0] Bus_tb;

	// instantiate multiplexer module
	multiplexer uut (.SignExtDin(SignExtDin_tb), .R0(R0_tb), .R1(R1_tb), .R2(R2_tb), .R3(R3_tb), .R4(R4_tb), .R5(R5_tb), .R6(R6_tb), .R7(R7_tb), .G(G_tb), .sel(sel_tb), .Bus(Bus_tb));


	initial begin
	// set initial values
		errors = 0;
		R0_tb = 16'd1;
		R1_tb = 16'd2;
		R2_tb = 16'd3;
		R3_tb = 16'd4;
		R4_tb = 16'd5;
		R5_tb = 16'd6;
		R6_tb = 16'd7;
		R7_tb = 16'd8;
		G_tb = 16'd9;
		SignExtDin_tb = 16'd10;
    
		// test R0
		sel_tb = 4'b0000;
		#10;
		if (Bus_tb !== R0_tb) begin
			$display("Sel: %b, Bus: %h (Expected: %h)", sel_tb, Bus_tb, R0_tb);
			errors = errors + 1;
		end
    
		// test R1
		sel_tb = 4'b0001;
		#10;
		if (Bus_tb !== R1_tb) begin
			$display("Sel: %b, Bus: %h (Expected: %h)", sel_tb, Bus_tb, R1_tb);
         errors = errors + 1;
		end

    
		// Test R2
		sel_tb = 4'b0010;
		#10;
		if (Bus_tb !== R2_tb) begin
			$display("Sel: %b, Bus: %h (Expected: %h)", sel_tb, Bus_tb, R2_tb);
         errors = errors + 1;
		end

    
		// Test R3
		sel_tb = 4'b0011;
		#10;
		if (Bus_tb !== R3_tb) begin
			$display("Sel: %b, Bus: %h (Expected: %h)", sel_tb, Bus_tb, R3_tb);
         errors = errors + 1;
		end
    
		// Test R4
		sel_tb = 4'b0100;
		#10;
		if (Bus_tb !== R4_tb) begin
			$display("Sel: %b, Bus: %h (Expected: %h)", sel_tb, Bus_tb, R4_tb);
         errors = errors + 1;
		end
    
		// Test R5
		sel_tb = 4'b0101;
		#10;
		if (Bus_tb !== R5_tb) begin
			$display("Sel: %b, Bus: %h (Expected: %h)", sel_tb, Bus_tb, R5_tb);
         errors = errors + 1;
		end
    
		// Test R6
		sel_tb = 4'b0110;
		#10;
		if (Bus_tb !== R6_tb) begin
			$display("Sel: %b, Bus: %h (Expected: %h)", sel_tb, Bus_tb, R6_tb);
         errors = errors + 1;
		end
    
		// Test R7
		sel_tb = 4'b0111;
		#10;
		if (Bus_tb !== R7_tb) begin
			$display("Sel: %b, Bus: %h (Expected: %h)", sel_tb, Bus_tb, R7_tb);
         errors = errors + 1;
		end
    
		// Test G
		sel_tb = 4'b1000;
		#10;
		if (Bus_tb !== G_tb) begin
			$display("Sel: %b, Bus: %h (Expected: %h)", sel_tb, Bus_tb, G_tb);
         errors = errors + 1;
		end
    
		// Test SignExtDin
		sel_tb = 4'b1001;
		#10;
		if (Bus_tb !== SignExtDin_tb) begin
			$display("Sel: %b, Bus: %h (Expected: %h)", sel_tb, Bus_tb, SignExtDin_tb);
         errors = errors + 1;
		end

		// Test for default case for unused sel values
		sel_tb = 4'b1010;
		#10;
		if (Bus_tb !== 16'd0) begin
			$display("Sel: %b, Bus: %h (Expected: 16'd0)", sel_tb, Bus_tb);
         errors = errors + 1;
		end
		$display("Tests completed. %d erros found.", errors);
      if (errors == 0)
			$display("All tests passed successfully!");
      else
			$display("Some tests failed. Please review the errors above.");
		

		$stop; 
	end

endmodule




module register_n_tb;
	// set N for register
	parameter N = 16;

	reg clk_tb;
	reg rst_tb;
	reg enable_tb;
	reg [N-1:0] r_in_tb;
	integer errors;

	wire [N-1:0] Q_tb;

	// Instantiate register_n module
	register_n #(.N(N)) uut (.clk(clk_tb), .rst(rst_tb), .enable(enable_tb), .r_in(r_in_tb), .Q(Q_tb));

	// Clock toggles every 5
	initial begin
	errors = 0;
		clk_tb = 0;
		repeat (500) begin
			#5 clk_tb = ~clk_tb;
		end
	end

	// Test procedure
	initial begin
		// Set initial values
		rst_tb = 1;
		enable_tb = 0;
		r_in_tb = 16'd0;

		// Reset
		#10;
		rst_tb = 0;


		// Test enable high
		enable_tb = 1;
		r_in_tb = 16'd111;
		#10;
		if (Q_tb !== 16'd111) begin
			$display("Error at enable high: Q = %h (Expected: 111)", Q_tb);
         errors = errors + 1;
		end
		
		

		// Test enable low
		enable_tb = 0;
		r_in_tb = 16'd222;
		#10;
		if (Q_tb !== 16'd111) begin
			$display("Error at enable low: Q = %h (Expected: 111)", Q_tb);
         errors = errors + 1;
			
		end

		// Test reset when enable is high
		enable_tb = 1;
		r_in_tb = 16'd15;
		rst_tb = 1;
		#10;
		rst_tb = 0;
		if (Q_tb !== 16'd0) begin
			$display("Error reset when enable high: Q = %h (Expected: 0)", Q_tb);
         errors = errors + 1;
		end

		// Test ranodom value after reset
		enable_tb = 1;
		r_in_tb = 16'd1000;
		#10;
		if (Q_tb !== 16'd1000) begin
			$display("Error after reset: Q = %h (Expected: 1000)", Q_tb);
         errors = errors + 1;
		end
		$display("Tests completed. %d errors found.", errors);
      if (errors == 0)
			$display("All tests passed successfully!");
      else
			$display("Some tests failed. Please review the errors above.");
		
		
		$stop;
	end

endmodule


module components_tb;
   // TODO: Implement the logic of your testbench here
	// all testbench functions go here
	sign_extender_tb sign_extender_test();
	tick_FSM_tb tick_FSM_tb();
	alu_tb alu_test();
	multiplexer_tb multiplexer_test();
	register_n_tb register_n_test();
	
	initial begin
        $display("Starting all tests");
		  // Change number to wait for all tests depends on length
        #700;
        $display("All tests completed");
        $stop;
    end
endmodule