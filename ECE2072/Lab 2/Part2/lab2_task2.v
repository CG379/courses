module lab2_task2 (SW, HEX0, HEX1, LEDR);
    // add I/O here
    input [7:0] SW;
    output [6:0] HEX0;
    output [6:0] HEX1;
	 output [0:0] LEDR;
    // Add modules here
	 wire [3:0] s;
    wire cout;
	 
	 // Ripple-carry adder, assume Cin = 0
	 ripple_carry_adder adder(.a(SW[3:0]), .b(SW[7:4]), .cin(1'b0), .sum(s), .cout(cout));
	 
	 // Cout to LED
	 assign LEDR[0] = cout;
	 
	 // 7-seg out
    two_digit_bcd decoder(.in(s), .hex0(HEX0), .hex1(HEX1));

endmodule


module two_digit_bcd (in, hex0, hex1);
	input [3:0] in;
   output [6:0] hex0;
   output [6:0] hex1;

	 
   wire [3:0] q;
   wire [3:0] rem;
	 
   // Divide by 10 to out tens and ones,
   bcd_divide divider(.denom(4'd10), .numer(in), .quotient(q), .remain(rem));
	
	// remainder = HEX0
	bcd(.in(rem), .Hex(hex0));
	// quotient = HEX1
	bcd(.in(q),.Hex(hex1));
endmodule


module full_adder (a, b, cin, sum, cout);
	input a, b, cin;
	output sum, cout;
	
	assign sum = a ^ b ^ cin;
	assign cout = (a & b) | (cin & (a ^ b));
endmodule

module ripple_carry_adder (a, b, cin, sum, cout); 
   input [3:0] a;
   input [3:0] b;
   output [3:0] sum;
   input cin;
   output cout;

   // Insert your code here
	
	// Carry between adders
	wire c1, c2, c3;
	// Each column has an adder. c1,c2,c3 carry between columns 
   full_adder fa0(.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(c1));
   full_adder fa1(.a(a[1]), .b(b[1]), .cin(c1), .sum(sum[1]), .cout(c2));
   full_adder fa2(.a(a[2]), .b(b[2]), .cin(c2), .sum(sum[2]), .cout(c3));
   full_adder fa3(.a(a[3]), .b(b[3]), .cin(c3), .sum(sum[3]), .cout(cout));

endmodule