module lab4_task2(CLOCK_50, KEY, LEDR);
	input CLOCK_50;
	input [1:0] KEY;
	output [9:0] LEDR;
	
	// A test Default state, you can find more in the lab doc
	wire [63:0] default_state;
	assign default_state = 64'd147499484866150400;
	
	// TODO: Make a counter so that the game runs at the specified speed
	// 50M/x = 2.89: x = 16778500
	// 50M/x = 2.89*8: x = 2097320
	reg [24:0] counter1;
	reg [24:0] counter2;
   reg game_clk = 0;
   reg write_clk = 0;
	
	// Generate 2.89Hz clock and 2.89*8Hz clock
	
	always @(posedge CLOCK_50) begin
		if (counter1 == 25'd16778500) begin
			counter1 <= 0;
			game_clk <= ~game_clk;
			// Stay synchronised as reccomened by GPT
			counter2 <= 0;
			if (counter2 >= 25'd2097320) begin
				write_clk <= ~write_clk;
			end
		end 
		else if (counter2 == 25'd2097320) begin
			counter2 <= 0;
			write_clk <= ~write_clk;
			// Keep incrementing counter1
			counter1 <= counter1 + 1;
		end
		else begin
         counter1 <= counter1 + 1;
			counter2 <= counter2 + 1;
      end
	end
	
	wire [63:0] game_output;
   reg [7:0] current_row;
   reg [2:0] row_counter;
	
	// JTAG MODULE
	JTAG_UART_MODULE jtag(
		.clk(CLOCK_50),
		.write(write_clk),
		.writedata(current_row),
		// Active low
		.reset(~KEY[0]),
		.readdata(),
	);
	
	// GAME OF LIFE
	game_of_life game(
		.clk(game_clk),
		// Active low
		.load(~KEY[1]), 
		.data(default_state),
		.q(game_output)
		);
	// Seperate the game of life output into rows. The rows should update 8x faster than the game does
	always @(posedge write_clk ) begin
		/* sequentially update the output to the jtag*/
		// Get current row from output
		// (8*row_counter + 7) : (8*row_counter) does not work need to use below??
		// credit GPT
		current_row <= game_output[8*row_counter +: 8];
		// Update row tracker
		// Assume it wraps to 0 when overflows
		row_counter <= row_counter + 1;
	end
endmodule

module game_of_life(clk, load, data, q);
    input load;
    input clk;
    input [63:0] data;
    output reg [63:0] q; 

    reg [63:0] q_next;
    reg [3:0] counter;

	initial begin
		q_next = 0;
		counter = 0;
	end
	
	// TODO: Initiliaze Loop integers
	integer i, j;
	reg [3:0] neighbors;
    
    always @(*) begin 
       // Game of life code
		 q_next = q;
	    // Two main for-loops to handle the analysis of each cell
	    for (i = 1; i < 8; i = i + 1) begin
            for (j = 1; j < 8; j = j + 1) begin
               // Check for edge conditions
               // Count the neighbours
					// Each cell has 8 neighbours
					neighbors = 0;
					// How tf do you wrap around?
					// credit: https://stackoverflow.com/questions/47458895/more-elegant-way-of-finding-neighbors-in-1d-array-grid-with-wrap-around
					// (i-1+8)%8 adding 8 for divide by 0 case + 8 % 8 gives 0 allowsing for wrap around  
					// Top-left
					neighbors = neighbors + q[8*((i-1+8)%8) + ((j-1+8)%8)];
					// Top
					neighbors = neighbors + q[8*((i-1+8)%8) + j]; 
					// Top-right
					neighbors = neighbors + q[8*((i-1+8)%8) + ((j+1)%8)];
					// Left
					neighbors = neighbors + q[8*i + ((j-1+8)%8)];
					// Right
					neighbors = neighbors + q[8*i + ((j+1)%8)];
					// Bottom-left					
					neighbors = neighbors + q[8*((i+1)%8) + ((j-1+8)%8)];
					// Bottom
					neighbors = neighbors + q[8*((i+1)%8) + j];
					// Bottom-right
					neighbors = neighbors + q[8*((i+1)%8) + ((j+1)%8)];
					
					// Choose next state
					case (neighbors)
						// Stay the same
						2: q_next[8*i + j] = q[8*i + j];
						// Born or stay alive
						3: q_next[8*i + j] = 1;
						// Die or stay dead
						default: q_next[8*i + j] = 0;
					endcase
            end
	    end
    end        
    
    
    always @(posedge clk) begin
        if (load) q <= data;
        else q <= q_next;
    end
endmodule

