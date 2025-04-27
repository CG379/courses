`timescale 1ns/1ns
/*
Monash University ECE2072: Assignment 
This file contains a Verilog test bench to test the correctness of the processor.

Please enter your student ID:

*/
module proc_extension_tb();
    // TODO: Implement the logic of your testbench here
	 
	 // Inputs
    reg clk;
    reg rst;
    reg [8:0] din;
	 
	 // Outputs
    wire [15:0] bus;
    wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7;
    wire [3:0] tick_out;
	 wire [15:0] display;
	 
	 
	 simple_proc_ext utt(.clk(clk), .rst(rst), .din(din), .mux_out(bus), .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6), .R7(R7), .tick_out(tick_out), .display(display));

	
	
	
	
	// Clock generation
    initial begin
        clk = 0;
    end
	 always #5 clk <= ~clk;
	 
	 // Test variables
    integer test_case = 0;
    integer errors = 0;

	 
	 // Test scenario
	initial begin
        $display("Starting processor testbench");
        
        // Initialize and reset
        rst = 1;
        din = 9'b0;
        #100;
        rst = 0;
        #20; 

		  
		  
		  
        // Test case 1: MOVI instructions, to move move values into registers for further testing
        test_case = 1;
        $display("\nTest Case %0d: MOVI Instructions", test_case);
        execute_movi(3'b000, 16'd42);  // MOVI R0, 42
        execute_movi(3'b001, 16'd24);  // MOVI R1, 24
		  execute_movi(3'b010, 16'd59);  // MOVI R2, 59
		  execute_movi(3'b011, 16'd5); // MOVI R3, 5
        wait (tick_out == 4'b1000);
		  check_register(3'b000, 16'd42);
        check_register(3'b001, 16'd24);
		  check_register(3'b010, 16'd59);
		  check_register(3'b011, 16'd5);
		  
		  
        // Test case 2: Multiply instructions
        test_case = 2;
        $display("\nTest Case %0d: MULT Instruction", test_case);
        execute_mult(3'b100, 3'b000);  // multiply R4 with R0
		  wait (tick_out == 4'b1000); // break up commands
		  execute_mult(3'b001, 3'b011);  // multiply R1 by R3
		  wait (tick_out == 4'b1000);
		  wait (tick_out == 4'b0001);
		  #2
		  check_register(3'b100, 16'd0);  // 0 x 42
        check_register(3'b001, 16'd120); // 24 * 5 = 120
		  

		  
        // Test case 3: DISPLAY instruction
        test_case = 3; 
        $display("\nTest Case %0d: DISPLAY Instruction", test_case);
		  execute_display(3'b000); // display R0
		  wait (tick_out == 4'b1000);
		  execute_addi(3'b111, 3'b101); // do a addition function to cycle through another set of instructions
		  // This ensures that the display remains constant until a new display instruction is given
		  wait (tick_out == 4'b1000);
		  #40 //ensure instruction has progressed
		  check_display(16'd42);
		  execute_display(3'b001); // display R1
		  wait (tick_out == 4'b1000);
		  #2 // ensure instruction has progressed
		  check_display(16'd120); // check display updates after new command
		  
		  
		  
		  

        // Test case 4: SSI instruction
        test_case = 4;
        $display("\nTest Case %0d: SSI Instruction", test_case);  
		  execute_ssi(3'b001, 16'd2);  
        wait (tick_out == 4'b1000);
		  execute_ssi(3'b011, 16'd15);  
        wait (tick_out == 4'b1000);
		  wait (tick_out == 4'b0001);
		  wait (tick_out == 4'b1000);
		  #2
		  check_register(3'b001, 16'd120); // This should not change register 1
		  check_register(3'b011, 16'd480);  
		  
		  
		  
		  
		  /* 
        // Test case 5: Edge cases
        test_case = 5;
        $display("\nTest Case %0d: Edge Cases", test_case);
        execute_movi(3'b101, 16'hFFFF);  // MOVI R5, 65535 (max 16-bit value)
        wait (tick_out == 4'b1000);
		  check_register(3'b101, 16'hFFFF); 
        execute_addi(3'b101, 16'd1);  // ADDI R6, R5, 1 (overflow)
		  wait (tick_out == 4'b1000);
        check_register(3'b110, 16'd0);  // Should wrap around to 0

		  
		  */
        // Report results
        $display("\nTest completed with %0d errors", errors);
        $stop;
    end
// Task to execute ADD instruction

	 task execute_movi;
		 input [2:0] rx;
		 input [15:0] imm; 
		 begin
			 wait (tick_out == 4'b0001);
			 din = {3'b111, rx, 3'b000};
			 wait (tick_out == 4'b0010);
			 din = imm[8:0];
			 wait (tick_out == 4'b1000);
		 end
	 endtask
	 
	 
	 
    task execute_add;
        input [2:0] rx, ry;
        begin
				wait (tick_out == 4'b0001);
            din = {3'b001, rx, ry};

        end
    endtask

    // Task to execute SUB instruction
    task execute_sub;
        input [2:0] rx, ry;
        begin
            wait (tick_out == 4'b0001);
				din = {3'b011, rx, ry};

        end
    endtask

    // Task to execute ADDI instruction
    task execute_addi;
        input [2:0] rx;
        input [15:0] imm;
        begin
            wait (tick_out == 4'b0001);
				din = {3'b010, rx, 3'b000};
            wait (tick_out == 4'b0010);
            din = imm[8:0];
        end
    endtask
	 
	 // Task to execute MULT instruction
	 task execute_mult;
		 input [2:0] rx, ry; 
		 begin
			 wait (tick_out == 4'b0001);
			 din = {3'b100, rx, ry};
		 end
	 endtask
	 
	 
	 // task to execute DISPLAY function
	 task execute_display;
		input [2:0] rx;
		begin 
			wait (tick_out == 4'b0001);
			din = {3'b000, rx, 3'b000};
		end
	endtask
	
	task execute_ssi;
		input[2:0] rx;
		input [15:0] imm;
		begin 
			wait (tick_out == 4'b0001);
			din = {3'b101, rx, 3'b000};
			wait (tick_out == 4'b0010);
         din = imm[8:0];
		end
	endtask 

	 

    // Function to check register
    task check_register;
        input [2:0] rx;
        input [15:0] expected;
        reg [15:0] actual;
        begin
            case(rx)
               3'b000: actual = R0;
					3'b001: actual = R1;
					3'b010: actual = R2;
					3'b011: actual = R3;
					3'b100: actual = R4;
					3'b101: actual = R5;
					3'b110: actual = R6;
					3'b111: actual = R7;
            endcase

            if (actual !== expected) begin
                $display("Error: R%0d = %0d, expected %0d", rx, actual, expected);
                errors = errors + 1;
            end else begin
                $display("Success: R%0d = %0d", rx, actual);
            end
        end
    endtask
	 
	 // function to check display
	 task check_display;
        input [15:0] expected;
        reg [15:0] actual_display;
        begin
				actual_display = display;
            

            if (actual_display !== expected) begin
                $display("Error: Display =  %0d, expected %0d", actual_display, expected);
                errors = errors + 1;
            end else begin
                $display("Success: Display = %0d", actual_display);
            end
        end
    endtask

    // Monitor tick counter
    always @(tick_out) begin
        $display("Time=%0t, Tick=%b", $time, tick_out);
    end

endmodule 