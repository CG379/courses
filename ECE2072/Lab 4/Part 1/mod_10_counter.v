module mod_10_counter(SW, KEY, HEX0);
    input [2:0] SW;
    input [0:0] KEY;
    output [6:0] HEX0;


    wire Clock, Resetn;
    wire [1:0] w;
    reg [3:0] count;

    assign Clock = ~KEY[0];
    assign Resetn = SW[0];
    assign w = SW[2:1];

    // Counter logic
    always @(posedge Clock) begin
        if (Resetn)
            count <= 4'd0;
        else begin
            case (w)
                2'b00: count <= count;
					 // Wrap around case and + 1
                2'b01: count <= (count == 4'd9) ? 4'd0 : count + 4'd1;
					 // Wrap around case + add 2
                2'b10: count <= (count >= 4'd8) ? count - 4'd8 : count + 4'd2;
					 // Wrap around case and - 1
                2'b11: count <= (count == 4'd0) ? 4'd9 : count - 4'd1;
            endcase
        end
    end

    // 7-segment display decoder
    bcd bcd_decoder(.in(count),.Hex(HEX0));

endmodule