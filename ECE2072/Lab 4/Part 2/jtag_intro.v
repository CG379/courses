module jtag_intro (
   input CLOCK_50,
   input [7:0] SW,
   input [3:0] KEY,
   output [7:0] LEDR
);
	
   wire reset = 1'b0; 
   wire write;
   wire [7:0] readdata;
   wire [7:0] writedata;

   JTAG_UART_MODULE jtag_uart (.clk(CLOCK_50), .reset(reset), 
	.write(write), .readdata(readdata), .writedata(writedata));

   // send button
   reg key0_prev;
   always @(posedge CLOCK_50) begin
       key0_prev <= KEY[0];
   end
   assign write = key0_prev & ~KEY[0];

   // Connect leds
   assign writedata = SW[7:0];

   // Display data
   assign LEDR = writedata;

endmodule