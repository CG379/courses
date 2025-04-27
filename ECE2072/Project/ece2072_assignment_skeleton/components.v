/*
Monash University ECE2072: Assignment 
This file contains Verilog code to implement individual components to be used in 
    the CPU.

Please enter your name and student ID: 33110018, 

*/

// Author: Campbell
module sign_extend(in, ext);
	/* 
	 * This module sign extends the 9-bit Din to a 16-bit output.
	 */
	// TODO: Declare inputs and outputs
	 input [8:0] in;
    output [15:0] ext;

    // Sign extend by replicating the most significant bit (MSB) of the input
	 // Assume most significant bit depicts sign
	 // pad with sign
    assign ext = {{7{in[8]}}, in};
	
	// TODO: implement logic
endmodule


// Author: Campbell
module tick_FSM(rst, clk, tick);
	/* 
	 * This module implements a tick FSM that will be used to
	 * control the actions of the control unit
	 */

	// TODO: Declare inputs and outputs
   input rst;	
	input clk;
   //input enable;
   output reg [3:0] tick;
	
	// state registers one hot
   reg [3:0] current_state, next_state;
	
	wire [3:0] IDLE, TICK1, TICK2, TICK3;
	assign IDLE  = 4'b0001;
   assign TICK1 = 4'b0010;
   assign TICK2 = 4'b0100;
   assign TICK3 = 4'b1000;
	
	
	
    // TODO: implement FSM
	 
	 // state transition
	always @(posedge clk or posedge rst) begin
		if (rst)
			current_state <= IDLE;
      else
         current_state <= next_state;
   end
	 
	// next state 
   always @(*) begin
	// cycle through ticks sequentially after enable
		case (current_state)
			IDLE:  next_state = TICK1;
         TICK1: next_state = TICK2;
         TICK2: next_state = TICK3;
         TICK3: next_state = IDLE;
         default: next_state = IDLE;
      endcase
   end
	 
	 
	// Output logic
   always @(*) begin
		tick = current_state;
   end
endmodule


// Author: Will
module multiplexer(SignExtDin, R0, R1, R2, R3, R4, R5, R6, R7, G, sel, Bus);
	/* 
	 * This module takes 10 inputs and places the correct input onto the bus.
	 */
	// TODO: Declare inputs and outputs
	input wire [15:0] SignExtDin;
	input wire [15:0] R0;
	input wire [15:0] R1;
	input wire [15:0] R2;
	input wire [15:0] R3;
	input wire [15:0] R4;
	input wire [15:0] R5;
	input wire [15:0] R6;
	input wire [15:0] R7;
	input wire [15:0] G;
	input wire [3:0] sel;
	
	output reg [15:0] Bus;
	
	
	always @(*) begin
		case (sel)
			4'b0000: Bus = R0;
			4'b0001: Bus = R1;
			4'b0010: Bus = R2;
			4'b0011: Bus = R3;
			4'b0100: Bus = R4;
			4'b0101: Bus = R5;
			4'b0110: Bus = R6;
			4'b0111: Bus = R7;
			4'b1000: Bus = G;
			4'b1001: Bus = SignExtDin;
			default: Bus = 16'd0;
		endcase
	end
	
	// TODO: implement logic
	/*
	assign Bus = (sel == 4'b0000) ? R0 : 
						(sel == 4'b0001) ? R1 :
						(sel == 4'b0010) ? R2 :
						(sel == 4'b0011) ? R3 :
						(sel == 4'b0100) ? R4 :
						(sel == 4'b0101) ? R5 :
						(sel == 4'b0110) ? R6 :	
						(sel == 4'b0111) ? R7 :
						(sel == 4'b1000) ? G :
						(sel == 4'b1001) ? SignExtDin :
						16'd0;
*/
endmodule


// Author: Will
module ALU (input_a, input_b, alu_op, result);
	/* 
	 * This module implements the arithmetic logic unit of the processor.
	 */
	// TODO: declare inputs and outputs
	
	input wire [15:0] input_a;
	input wire [15:0] input_b;
	input wire [2:0] alu_op;
	output reg [15:0] result;
	reg [31:0] full_product;


	// TODO: Implement ALU Logic:
	always @(*) begin 
        case (alu_op)
            3'b000: result = input_a * input_b;  // Multiplication
            3'b001: result = input_a + input_b;  // Addition
            3'b010: result = input_a - input_b;  // Subtraction
            3'b011: result = $signed(input_b) <<< input_a[3:0];  // Signed shift
            default: result = 16'bx;  // Don't care operations
        endcase
    end
endmodule


// Author: Will
module register_n(r_in, enable, clk, Q, rst);


	// To set parameter N during instantiation, you can use:
	// register_n #(.N(num_bits)) reg_IR(.....), 
	// where num_bits is how many bits you want to set N to
	// and "..." is your usual input/output signals

	parameter N = 16;

	/* 
	 * This module implements registers that will be used in the processor.
	 */
	// TODO: Declare inputs, outputs, and parameter:
	
	input wire clk;
	input wire rst;
	input wire enable;
	input wire [N-1:0]r_in;
	output reg [N-1:0]Q;
	
	// TODO: Implement register logic:
	
	always @ (posedge clk) begin
		if (rst) begin
				Q <= 0;
		end else if (enable) begin
				Q <= r_in;
			
		end
	end
	
endmodule









