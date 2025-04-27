module proc_top(
    input [8:0] SW,
    input [1:0] KEY,
    output [9:0] LEDR,
    output [6:0] HEX5
);
    wire [15:0] bus;
    wire [3:0] FSM_tick;
    wire clk, rst;
    //wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7;

    // Clock and reset 
    assign clk = ~KEY[1];
    assign rst = ~KEY[0];
         
    simple_proc processor(
        .clk(clk),
        .rst(rst),
        .din(SW[8:0]),
        .bus(bus),
        .R0(), .R1(), .R2(), .R3(),
        .R4(), .R5(), .R6(), .R7(),
        .tick_out(FSM_tick)
    );

    // Connect LEDR to the bottom 10 bits of the bus
    assign LEDR = bus[9:0];
         
    // show tick 
    BCD tick_display(
        .in(FSM_tick),
        .HEX(HEX5)
    );
endmodule