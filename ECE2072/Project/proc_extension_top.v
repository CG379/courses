module proc_extension_top(
    input [9:0] SW,
    input [1:0] KEY,
    output [9:0] LEDR,
    output [6:0] HEX0,
    output [6:0] HEX1,
    output [6:0] HEX2,
    output [6:0] HEX3,
    output [6:0] HEX4,
    output [6:0] HEX5
);

    wire clk, rst;
    wire [15:0] bus;
    wire [15:0] display;
    wire [3:0] tick_out;
	 wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7;

    
    // Clock and reset connections
    assign clk = ~KEY[1];
    assign rst = ~KEY[0];

    // Instantiate the processor
    simple_proc_ext procesor(
        .clk(clk),
        .rst(rst),
        .din(SW[8:0]),
        .mux_out(bus),
        .R0(r0), .R1(r1), .R2(r2), .R3(r3), .R4(r4), .R5(r5), .R6(r6), .R7(r7), // We don't need to connect these
        .tick_out(tick_out),
        .display(display)
    );

    // Connect LEDR to the bottom 10 bits of the bus
    assign LEDR = bus[9:0];
    
    // extract each digit
    wire [3:0] ten_thousands, thousands, hundreds, tens, ones;
    binary_to_bcd b2b_display(
        .binary(display),
        .ten_thousands(ten_thousands),
        .thousands(thousands),
        .hundreds(hundreds),
        .tens(tens),
        .ones(ones)
    );

	 // digits -> displays
    BCD hex0(.in(ones), .HEX(HEX0));
    BCD hex1(.in(tens), .HEX(HEX1));
    BCD hex2(.in(hundreds), .HEX(HEX2));
    BCD hex3(.in(thousands), .HEX(HEX3));
    BCD hex4(.in(ten_thousands), .HEX(HEX4));
	 
    // Decode tick_FSM 
    BCD hex5(.in(tick_out), .HEX(HEX5));

endmodule


// Binary to BCD converter
module binary_to_bcd(
    input [15:0] binary,
    output [3:0] ten_thousands,
    output [3:0] thousands,
    output [3:0] hundreds,
    output [3:0] tens,
    output [3:0] ones
);
    reg [15:0] temp;
	 //reg [15:0] digit_holder;
    reg [3:0] digits [4:0];
    integer i;
    
    always @(binary) begin
        temp = binary;
        
        // Extract digits
        for (i = 0; i < 5; i = i + 1) begin
		  
				//digit_holder = temp % 10'd10;
				//digits[i] = digit_holder[i];
            digits[i] = temp % 10'd10;
            temp = temp / 10'd10;
        end
    end
    
    // Assign outputs
    assign ones = digits[0];
    assign tens = digits[1];
    assign hundreds = digits[2];
    assign thousands = digits[3];
    assign ten_thousands = digits[4];

endmodule

