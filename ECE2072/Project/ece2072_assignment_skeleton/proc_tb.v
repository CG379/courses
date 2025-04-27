`timescale 1ns/1ns
/*
Monash University ECE2072: Assignment 
This file contains a Verilog test bench to test the correctness of the processor.

Please enter your student ID:

*/
module proc_tb();
    // TODO: Implement the logic of your testbench here
	 
	 // Inputs
    reg clk;
    reg rst;
    reg [8:0] din;
	 
	 // Outputs
    wire [15:0] bus;
    wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7;
    wire [3:0] tick_out;
	 
	 
	simple_proc utt(.clk(clk), .rst(rst), .din(din), .mux_out(bus), .R0(R0), .R1(R1), .R2(R2), 
	.R3(R3), .R4(R4), .R5(R5), .R6(R6), .R7(R7), .tick_out(tick_out));
	
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

        // Test case 1: MOVI instructions
        test_case = 1;
        $display("\nTest Case %0d: MOVI Instructions", test_case);
        execute_movi(3'b000, 16'd42);  // MOVI R0, 42
        execute_movi(3'b001, 16'd24);  // MOVI R1, 24
        wait (tick_out == 4'b1000);
		  check_register(3'b000, 16'd42);
        check_register(3'b001, 16'd24);

        // Test case 2: ADD instruction
        test_case = 2;
        $display("\nTest Case %0d: ADD Instruction", test_case);
        execute_add(3'b000, 3'b001);  // ADD R1 to R0
        wait (tick_out == 4'b1000);
		  #2
		  check_register(3'b000, 16'd66);  // 42 + 24 = 66

        // Test case 3: SUB instruction
        test_case = 3; 
        $display("\nTest Case %0d: SUB Instruction", test_case);
        execute_sub(3'b000, 3'b001);  // SUB R1 from R0
        wait (tick_out == 4'b1000);
		  #2
		  check_register(3'b000, 16'd42);  // 66 - 24 = 42

        // Test case 4: ADDI instruction
        test_case = 4;
        $display("\nTest Case %0d: ADDI Instruction", test_case);
        execute_addi(3'b001, 16'd27);  // ADDI 10 to R1
        wait (tick_out == 4'b1000);
		  #2
		  check_register(3'b001, 16'd51);  // 24 + 27 = 51

        // Test case 5: Edge cases
        test_case = 5;
        $display("\nTest Case %0d: Edge Cases", test_case);
        execute_movi(3'b101, 16'hFFFF);  // MOVI R5, 65535 (max 16-bit value)
        wait (tick_out == 4'b1000);
		  check_register(3'b101, 16'hFFFF);
        execute_addi(3'b101, 16'd1);  // ADDI R6, R5, 1 (overflow)
		  wait (tick_out == 4'b1000);
        check_register(3'b110, 16'd0);  // Should wrap around to 0

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

    // Monitor tick counter
    always @(tick_out) begin
        $display("Time=%0t, Tick=%b", $time, tick_out);
    end

endmodule