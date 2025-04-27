module sequence_detector_part_3 (SW, KEY, LEDR);
	input [1:0] SW;
   input [0:0] KEY;
   output [9:0] LEDR;

   wire Clock, Resetn, w;
   wire [3:0] shift_reg0, shift_reg1;
   wire out;

   assign Clock = ~KEY[0];
   assign Resetn = ~SW[0];
   assign w = SW[1];

    // detecting 0000
   lpm_shiftreg_0 shift_reg_zero (.clock(Clock), .shiftin(~w), .sclr(Resetn), .q(shift_reg0));

    // detecting 1111
    lpm_shiftreg_0 shift_reg_one (.clock(Clock), .shiftin(w), .sclr(Resetn), .q(shift_reg1));

    // Output logic
    assign out = (shift_reg0 == 4'b1111) | (shift_reg1 == 4'b1111);

    // Assign outputs to LEDs
    assign LEDR[3:0] = shift_reg0;
    assign LEDR[7:4] = shift_reg1;
    assign LEDR[9] = out;
    assign LEDR[8] = 1'b0; // Unused LED

endmodule