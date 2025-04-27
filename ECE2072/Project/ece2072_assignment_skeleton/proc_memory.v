module proc_memory(clk, rst, enable, din, PC, mux_out, R0, R1, R2, R3, R4, R5, R6, R7, tick_out, display);
    input clk;
    input rst;
	 input enable;
	 input [8:0] din;
    output [15:0] PC;
    output wire [15:0] mux_out;

    
    output wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7;
    output [3:0] tick_out;
    output wire [15:0] display;

    wire [15:0] alu_out, ir_out, sign_ext_din, G;
    wire [15:0] A;
    reg [2:0] alu_op;
    wire [3:0] tick_counter;
    reg enableG, enable_reg_A;
    reg [7:0] enable_reg;
    reg [3:0] sel;
    wire [2:0] op_code, r_x, r_y;
    wire enable_tick;
    reg enable_ir;
    reg enable_display;
	 // New stuff
    reg [15:0] next_PC;
    reg enable_PC;

    assign enable_tick = enable;
    assign tick_out = tick_counter;

    sign_extend extend(.in(din[8:0]), .ext(sign_ext_din));
	 wire [15:0] extended_imm;
	 assign extended_imm = sign_ext_din;

    assign op_code = ir_out[8:6];
    assign r_x = ir_out[5:3];
    assign r_y = ir_out[2:0];


    // PC register
    register_n #(.N(16)) reg_PC (.r_in(next_PC), .enable(enable_PC), .clk(clk), .Q(PC), .rst(rst));
	 
	 // Rest of regs
    register_n #(.N(16)) reg_R0 (.r_in(mux_out), .enable(enable_reg[0]), .clk(clk), .Q(R0), .rst(rst));

    register_n #(.N(16)) reg_R1 (.r_in(mux_out), .enable(enable_reg[1]), .clk(clk), .Q(R1), .rst(rst));

    register_n #(.N(16)) reg_R2 (.r_in(mux_out), .enable(enable_reg[2]), .clk(clk), .Q(R2), .rst(rst));

    register_n #(.N(16)) reg_R3 (.r_in(mux_out), .enable(enable_reg[3]), .clk(clk), .Q(R3), .rst(rst));

    register_n #(.N(16)) reg_R4 (.r_in(mux_out), .enable(enable_reg[4]), .clk(clk), .Q(R4), .rst(rst));

    register_n #(.N(16)) reg_R5 (.r_in(mux_out), .enable(enable_reg[5]), .clk(clk), .Q(R5), .rst(rst));

    register_n #(.N(16)) reg_R6 (.r_in(mux_out), .enable(enable_reg[6]), .clk(clk), .Q(R6), .rst(rst));

    register_n #(.N(16)) reg_R7 (.r_in(mux_out), .enable(enable_reg[7]), .clk(clk), .Q(R7), .rst(rst));
	 
	 
	 register_n #(.N(16)) reg_G (.r_in(alu_out), .enable(enableG), .clk(clk), .Q(G), .rst(rst));
	 
	 register_n #(.N(16)) reg_A (.r_in(mux_out), .enable(enable_reg_A), .clk(clk), .Q(A), .rst(rst));
	 
	 register_n #(.N(9)) reg_IR (.r_in(din), .enable(enable_ir), .clk(clk), .Q(ir_out), .rst(rst));
	 // Hex display Reg
    register_n #(.N(16)) reg_H (.r_in(mux_out), .enable(enable_display), .clk(clk), .Q(display), .rst(rst));

    multiplexer mux (.SignExtDin(sign_ext_din), .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6), .R7(R7), .G(G), .sel(sel), .Bus(mux_out));

    ALU alu (.input_a(A), .input_b(mux_out), .alu_op(alu_op), .result(alu_out));

    tick_FSM counter (.clk(clk), .rst(rst), .tick(tick_counter));
	 
	 always @(posedge clk or posedge rst) begin
        if (rst) begin
			  next_PC <= 16'b0;
			  enable_PC <= 1'b1;
			  // Reset other control signals if necessary
			  enable_reg <= 8'b00000000;
			  enable_reg_A <= 1'b0;
			  enableG <= 1'b0;
			  //sel <= 4'b0000;
			  alu_op <= 3'b000;
			  enable_ir <= 1'b0;
			  enable_display <= 1'b0;
        
		  end else if (enable) begin
            enable_reg <= 8'b00000000;
            enable_reg_A <= 1'b0;
            enableG <= 1'b0;
            //sel <= 4'b0000;
            alu_op <= 3'b000;
            enable_ir <= 1'b0;
            enable_display <= 1'b0;
            enable_PC <= 1'b0;

            case (tick_counter)
                4'b0001: begin
                    enable_ir <= 1'b1;
                end
					 
                4'b0010: begin
                    case (op_code)
                        3'b000: begin // disp
                            sel <= {1'b0, r_x};
                            enable_display <= 1'b1;
                        end
								3'b001, 3'b010, 3'b011, 3'b100, 3'b101: begin // add, addi, sub, mult, ssi
                            sel <= {1'b0, r_x};
                            enable_reg_A <= 1'b1;
                        end
                        3'b111: begin // movi
                            sel <= 4'b1001;
                            enable_reg[r_x] <= 1'b1;
                        end
                        3'b110: begin // bez
                            sel <= {1'b0, r_x};
                            enable_reg_A <= 1'b1;
                        end
                        default: begin /* nothing */ end 
                    endcase
                end
					 
                4'b0100: begin
                    case (op_code)
                        3'b001: begin // add
                            sel <= {1'b0, r_y};
                            alu_op <= 3'b001;
                            enableG <= 1'b1;
                        end
                        3'b010: begin // addi
                            sel <= 4'b1001;
                            alu_op <= 3'b001;
                            enableG <= 1'b1;
                        end
                        3'b011: begin // sub
                            sel <= {1'b0, r_y};
                            alu_op <= 3'b010;
                            enableG <= 1'b1;
                        end
                        3'b100: begin // mult
                            sel <= {1'b0, r_y};
                            alu_op <= 3'b000;
                            enableG <= 1'b1;
                        end
                        3'b101: begin // ssi
                            sel <= 4'b1001;
                            alu_op <= 3'b011;
                            enableG <= 1'b1;
                        end
								// Everything the same but this bit for the branching
                        // Branch if Equal to Zero (bez) handling
								3'b110: begin 
									 if (A == 16'b0) begin
										  // If the value in register A is zero, perform the branch
										  next_PC <= PC + extended_imm;
									 end else begin
										  // If the value in register A is not zero, move to the next 	
										  next_PC <= PC + 16'd2;
									 end
									 enable_PC <= 1'b1; // Enable writing to the PC register
								end
                        default: begin /* nothing */ end
                    endcase 
                end
					 
                4'b1000: begin
                    case (op_code)
                        3'b001, 3'b010, 3'b011, 3'b100, 3'b101: begin // add, addi, sub, mult, ssi
                            sel <= 4'b1000;
                            enable_reg[r_x] <= 1'b1;
                        end
                        default: begin /* nothing */ end
                    endcase
                    
                    // For non-branch 	s
							if (op_code != 3'b110) begin // Check if it's not a bez 	
								 next_PC <= PC + 16'd2; // Move to the next 	 (2 words per)
								 enable_PC <= 1'b1; // Enable writing to the PC register
							end
                end
                default: begin /* nothing */ end
            endcase
				
				end else begin
				  // When not enabled, maintain current state
				  enable_PC <= 1'b0;
				  enable_ir <= 1'b0;
				  enable_display <= 1'b0;
			 end
        end
 
endmodule