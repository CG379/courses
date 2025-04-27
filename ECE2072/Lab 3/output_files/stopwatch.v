module stopwatch (CLOCK_50, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, GPIO);
	input CLOCK_50;
   input [1:0] KEY;
   output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	output [2:2] GPIO;
	
	wire clock_100, test;
	clock_100 clk_gen (.CLOCK_50(CLOCK_50),.LEDR(test),.GPIO(GPIO[2]));
	assign clock_100 = GPIO[2];
	
	wire reset, pause;
   reg [7:0] hundredths;
   reg [5:0] seconds;
   reg [5:0] minutes;
	
	
	    // Handle reset and pause buttons (active low, so ~KEY)
    always @(posedge clock_100 or posedge reset) begin
        // Reset case
		  if (reset) begin
            hundredths <= 0;
            seconds <= 0;
            minutes <= 0;
			// Loop case
        end else if (!pause) begin
            //hundredths
            if (hundredths == 99) begin
                hundredths <= 0;
                
                //seconds
                if (seconds == 59) begin
                    seconds <= 0;
                    
                    //minutes
                    if (minutes == 59) begin
                        minutes <= 0;
							// Incirment mins
                    end else begin
                        minutes <= minutes + 1;
                    end
						  //Incriment secs
                end else begin
                    seconds <= seconds + 1;
                end
					//Incriment hendredths
            end else begin
                hundredths <= hundredths + 1;
            end
        end
    end

    
	// For min
	bcd bcd_minute_high (.in(minutes / 10), .Hex(HEX5));
	bcd bcd_minute_low (.in(minutes % 10), .Hex(HEX4));

	// For sec
	bcd bcd_second_high (.in(seconds / 10), .Hex(HEX3));
	bcd bcd_second_low (.in(seconds % 10), .Hex(HEX2));

	// For hund
	bcd bcd_hundredth_high (.in(hundredths / 10), .Hex(HEX1));
	bcd bcd_hundredth_low (.in(hundredths % 10), .Hex(HEX0));

    assign reset = ~KEY[0];
    assign pause = ~KEY[1];

endmodule