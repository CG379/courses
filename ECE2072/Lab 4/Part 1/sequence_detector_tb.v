`timescale 1ns / 1ps
module sequence_detector_tb;

   // Inputs
   reg [1:0] SW;
   reg [0:0] KEY;

   // Outputs
   wire [9:0] LEDR;

   // Instantiate the Unit Under Test (UUT)
   // Uncomment the module you want to test
   sequence_detector_part_1 uut (.SW(SW), .KEY(KEY), .LEDR(LEDR));
   // sequence_detector_part_2 uut (.SW(SW), .KEY(KEY), .LEDR(LEDR));
   // sequence_detector_part_3 uut (.SW(SW), .KEY(KEY), .LEDR(LEDR));

   // Clock generation
   initial KEY[0] = 1;
   always #5 KEY[0] = ~KEY[0];

   // Test sequence
   initial begin
      // Initialize Inputs
      SW = 2'b00; // Reset active
      #20; // Wait for a few clock cycles

      // Release reset
      SW[0] = 1'b1;
      #10;
      $display("After reset: SW=%b KEY=%b LEDR=%b, Expected=0", SW, KEY, LEDR[9]);

      // Test sequence: 00001111010101010
      SW[1] = 1'b0; #10; // 0
      SW[1] = 1'b0; #10; // 0
      SW[1] = 1'b0; #10; // 0
      SW[1] = 1'b0; #10; // 0 (should detect 0000)
      $display("After 0000: SW=%b KEY=%b LEDR=%b, Expected=1", SW, KEY, LEDR[9]);

      SW[1] = 1'b1; #10; // 1
      SW[1] = 1'b1; #10; // 1
      SW[1] = 1'b1; #10; // 1
      SW[1] = 1'b1; #10; // 1 (should detect 1111)
      $display("After 1111: SW=%b KEY=%b LEDR=%b, Expected=1", SW, KEY, LEDR[9]);

      SW[1] = 1'b0; #10; // 0
      SW[1] = 1'b1; #10; // 1
      SW[1] = 1'b0; #10; // 0
      SW[1] = 1'b1; #10; // 1
      SW[1] = 1'b0; #10; // 0
      SW[1] = 1'b1; #10; // 1
      SW[1] = 1'b0; #10; // 0
      $display("After 0101010: SW=%b KEY=%b LEDR=%b, Expected=0", SW, KEY, LEDR[9]);

      // Reset
      SW[0] = 1'b0;
      #20;
      SW[0] = 1'b1;
      #10;
      $display("After reset: SW=%b KEY=%b LEDR=%b, Expected=0", SW, KEY, LEDR[9]);

      // Test invalid sequence: 1100
      SW[1] = 1'b1; #10; // 1
      SW[1] = 1'b1; #10; // 1
      SW[1] = 1'b0; #10; // 0
      SW[1] = 1'b0; #10; // 0
      $display("After 1100: SW=%b KEY=%b LEDR=%b, Expected=0", SW, KEY, LEDR[9]);

      #100 
      $stop;
   end

endmodule