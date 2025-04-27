/*
Monash University ECE2072: Assignment 
This file contains Verilog code to implement individual the CPU.

Please enter your student ID:

*/
module simple_proc(clk, rst, din, mux_out, R0, R1, R2, R3, R4, R5, R6, R7, tick_out);
    // TODO: Declare inputs and outputs:
	 
	 input clk;
	 input rst;
	 input [8:0] din;
	 
	 output wire [15:0] mux_out;
	 output wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7;
	 output [3:0] tick_out;
	 reg [3:0] sel;
    // TODO: declare wires:
	 
	 wire [15:0] alu_out, G;
	 wire [15:0] sign_ext_din;
	 wire [15:0] ir_out;
	 
    wire [15:0] A;
    reg [2:0] alu_op;
    wire [3:0] tick_counter;
    reg enableG, enable_reg_A;
    reg [7:0] enable_reg; // Register enable signals for R0-R7
	 
	 
    
	 // Change to wire if moved outside always
    wire [2:0] op_code;
	 wire [2:0] r_x, r_y;
	 wire enable_tick;
	 reg enable_ir;

	 

	 // set to 1 for task 2
	 assign enable_tick = 1'b1;
	 assign tick_out = tick_counter;
	 // Extends din
    sign_extend extend(.in(din), .ext(sign_ext_din));
	 
	 // Decode instructions outside always removes errors
	 /*
	 assign op_code = ir_out[8:6];
	 assign r_x = ir_out[5:3];
	 assign r_y = ir_out[2:0];
	 */ 
    assign op_code = ir_out[8:6];
    assign r_x = ir_out[5:3];
    assign r_y = ir_out[2:0];
	 
	 // Bus assignment
    //assign bus = mux_out;

    // TODO: instantiate registers:
	 
	 register_n #(.N(16)) reg_R0 (.r_in(mux_out),.enable(enable_reg[0]), .clk(clk), .Q(R0), .rst(rst));

    register_n #(.N(16)) reg_R1 (.r_in(mux_out), .enable(enable_reg[1]), .clk(clk), .Q(R1), .rst(rst));

    register_n #(.N(16)) reg_R2 (.r_in(mux_out), .enable(enable_reg[2]), .clk(clk), .Q(R2), .rst(rst));
	 
    register_n #(.N(16)) reg_R3 (.r_in(mux_out), .enable(enable_reg[3]), .clk(clk), .Q(R3), .rst(rst));

    register_n #(.N(16)) reg_R4 (.r_in(mux_out), .enable(enable_reg[4]), .clk(clk), .Q(R4), .rst(rst));

    register_n #(.N(16)) reg_R5 (.r_in(mux_out), .enable(enable_reg[5]), .clk(clk), .Q(R5), .rst(rst));

    register_n #(.N(16)) reg_R6 (.r_in(mux_out), .enable(enable_reg[6]), .clk(clk), .Q(R6), .rst(rst));

    register_n #(.N(16)) reg_R7 (.r_in(mux_out), .enable(enable_reg[7]), .clk(clk), .Q(R7), .rst(rst));
	 
	 
	 register_n #(.N(16)) reg_G (.r_in(alu_out), .enable(enableG), .clk(clk), .Q(G), .rst(rst));
	 
	 register_n #(.N(16)) reg_A (.r_in(mux_out),.enable(enable_reg_A), .clk(clk), .Q(A), .rst(rst));
	 
	 // Should this do something???
	 register_n #(.N(9)) reg_IR (.r_in(din), .enable(enable_ir), .clk(clk), .Q(ir_out), .rst(rst));
    
    
    // TODO: instantiate Multiplexer:
	 multiplexer mux (.SignExtDin(sign_ext_din), .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6), .R7(R7), .G(G), .sel(sel), .Bus(mux_out));
    
    
    // TODO: instantiate ALU:
	 ALU alu (.input_a(A), .input_b(mux_out), .alu_op(alu_op), .result(alu_out));
    
    
	 // TODO: instantiate tick counter:
    
	 tick_FSM counter (.clk(clk), .rst(rst), .enable(enable_tick), .tick(tick_counter));
	 
	 
	 
	 
    
    // TODO: define control unit:
	 // Use wild card for now, could use the tick counter or the op_code
    always @(*) begin
		  
		  // TODO: Turn off all control signals:
			enable_reg <= 8'b00000000;
			enable_reg_A = 1'b0;
			enableG = 1'b0;
			//Default vals
			//sel = 4'b0000;
         alu_op = 3'b000;
			enable_ir = 1'b0; 
			
			


        // TODO: Turn on specific control signals based on current tick:
        case (tick_counter)
            /* Tick 1: decode instuction*/
                4'b0001: begin
					 
							enable_ir <= 1'b1;
							//op_code = ir_out[8:6];
							//r_x = ir_out[5:3];
							//r_y = ir_out[2:0];
							 
							
                    // TODO Input Din into the instruction register so that it can decipher it.
						  
						  // We could also decode outside the always so it happens on auto
						  // idk if there will be unforseen consequences for this but might reduce warnings
						 
						// I am pretty sure we dont need this case code here
						// it is here to keep track of what has been done. 
						// Only the following are incomplete
						
						// tick one just decodes instructions right??? shouldn't need cases yet 
						/*
						 case (opcode)
						  
								3'b000: //to display register content on hex
								
								
								
								3'b101: // shifts r_x by the immidiate value
								3'b110: // 
								
                
							default: //do nothing
							endcase
						  */
                end
            
            /* Tick 2 */
                4'b0010: begin
					 
                    // TODO
						  case (op_code)
								// add, sub, mult can go together
								// Don't need mult for task 2, keep for task 3
								3'b001, 3'b011 /*, 3'b100*/: begin 
									sel <= {1'b0, r_x}; // value from rx placed onto bus
									enable_reg_A <= 1'b1; // value is stored on register A
								end
								
								// addi 
								3'b010: begin // to add a register and the next Din value
									sel <= 4'b1001; // add the next value of Din to the bus
									enable_reg_A <= 1'b1; // value is stored on register A
									
								end

								// movi
								3'b111: begin // moves immidiate value into register
									sel <= 4'b1001; // add the next value of Din to the bus
									enable_reg[r_x] <= 1'b1; // immidiate value overwrites rx
								end
								
								// Keep for task 3 
								/*
								3'b000: //to display register content on hex
								3'b101: // shifts r_x by the immidiate value
								3'b110: // if statement for task 4
								*/
							// should we just assume opcodes will be standard form??
							// So we can ignore default/edgecases??/
							//default: //??
							endcase

						  
                end
            
            /* Tick 3 */
                4'b0100: begin
                    // TODO
						  case (op_code)
								// add
								3'b001: begin  // to add the two registers values
									sel <= {1'b0, r_y}; // value ry placed on bus
									alu_op <= 3'b001; // select addition operation on alu
									enableG <= 1'b1; // write to reg G
								end 
								// addi
								3'b010: begin // to add a register and the next Din value
									sel <= {1'b0, r_x}; // value from rx placed onto bus
									alu_op <= 3'b001; // select addition operation on alu
									enableG <= 1'b1; // write to reg G
								end
								// sub
								3'b011: begin // to subtract the two register values
									sel <= {1'b0, r_y}; // value ry placed on bus
									alu_op <= 3'b010; // select subtraction operation on alu
									enableG <= 1'b1; // write to reg G
								end
								
								
								// Keep for task 3
								/*
								3'b100: begin // to multiply the two register values
									sel = {1'b0, r_y}; // value ry placed on bus
									alu_op = 3'b000; // select multiplication operation on alu
									enableG = 1'b1; // write to reg G
								end
								
								3'b101: // shifts r_x by the immidiate value
								3'b110: // ?
								*/
								
							default: begin end
							endcase

						  
						  
                end
           
            /* Tick 4 */
                4'b1000: begin
                 // Tick 4
                case (op_code)
                    3'b001, 3'b010, 3'b011: begin // add, addi, sub
                        sel <= 4'b1000; // Select reg G
                        enable_reg[r_x] <= 1'b1;
                    end
						  default: begin end
                endcase
            end
            
            default: begin
                // Do nothing
            end
        endcase
    end
 
endmodule