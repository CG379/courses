module BCD_instantiate(KEY, HEX0);
    input [0:0] KEY;
    output [6:0] HEX0;

    reg [3:0] counter;

   BCD bcd(.in(counter), .HEX(HEX0));

    always @(posedge KEY) begin
        if (counter < 9) begin
            counter = counter + 1;
        end
        else counter = 0;
    end
endmodule