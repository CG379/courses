# Written for ECE2071 S1 2023
# Copyright Monash University 2023
# Lab 7 Part 3 - Bitwise operations

.text 					                # Start generating instructions 
.globl start 				            # This label should be globally known

# Instructions in the program:
.text
start:
	lw $t0, 0x10010000  # Load input byte from memory location 0x10010000
	# the first two bits (least significant) are set to 1, 
	andi $t0, $t0, 0b00000011
	# the next two bits are set to 0, 
	andi $t0, $t0, 0b11110011
	# and the most significant four bits are inverted.
	xori $t0, $t0, 0b11110000 
# Store the modified byte to memory location 0x10010005
    	sw $t0, 0x10010005
loop:
	j loop