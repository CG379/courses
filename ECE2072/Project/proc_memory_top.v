module proc_memory_top(
    input CLOCK_50,
    input [9:0] SW,
    input [3:0] KEY,
    output [9:0] LEDR,
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

    // Internal signals
    wire [15:0] PC;
    wire [15:0] instruction;
    wire [15:0] bus;        // Add this for LEDR connection
    wire [15:0] display;
    wire [3:0] tick_out;
    wire clk_10Hz;

    // Generate 10 Hz clock
    clock_divider clk_div(
        .clk_in(CLOCK_50),
        .clk_out(clk_10Hz)
    );

    // Instantiate the ROM IP block
    rom_ip instruction_memory (
        .address(PC[15:1]),  // word address
        .clock(CLOCK_50),    // Use 50 MHz clock for ROM
        .q(instruction)
    );

    // Instantiate the processor
    proc_memory processor(
        .clk(clk_10Hz),
        .rst(~KEY[0]),
        .enable(SW[9]),     // Add enable input
        .PC(PC),
        .din(instruction),
        .mux_out(bus),          // Add bus output
        .R0(), .R1(), .R2(), .R3(), .R4(), .R5(), .R6(), .R7(), // don't need to connect these
        .tick_out(tick_out),
        .display(display)
    );

    // Connect LEDR to the bottom 10 bits of the bus
    assign LEDR = bus[9:0];

    // BCD decoder for display output
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

// Clock divider module
module clock_divider (
    input clk_in,
    output reg clk_out
);
    reg [31:0] counter = 32'd0;
    
    always @(posedge clk_in) begin
        counter <= counter + 32'd1;
        if (counter >= (23'd5_000_000/2-1)) begin
            counter <= 32'd0;
            clk_out <= ~clk_out;
        end
    end
endmodule

// For testing purposes
module clock_divider_slow (
    input clk_in,
    output reg clk_out
);
    reg [31:0] counter = 32'd0;
    
    always @(posedge clk_in) begin
        counter <= counter + 32'd1;
        if (counter >= (30'd5_000_0000/2-1)) begin
            counter <= 32'd0;
            clk_out <= ~clk_out;
        end
    end
endmodule

