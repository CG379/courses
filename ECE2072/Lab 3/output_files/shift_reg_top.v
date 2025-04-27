module shift_reg_top (KEY, SW, LEDR);
	input [1:0]KEY;
	input [0:0]SW;
	output [4:0]LEDR;
	
	wire clk;
   wire D;
   wire [4:0] Q;
    
   assign clk = ~KEY[0];
   assign D = ~KEY[1];
	
	
	//shift_reg SR0 (.clk(clk), .D(D), .Q(Q));
	lfsr lfsr_inst (.clk(clk), .reset(D), .Q(Q));
	
	assign LEDR = Q;


endmodule