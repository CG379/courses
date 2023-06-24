# Written for ECE2071 S1 2023
# Copyright Monash University 2023
# Lab 8 Part 1 - Rotating Seven Segment Display

.text					# Start generating instructions 
.globl start			# This label should be globally known

	
start:
	li $t0, 0xFFFF0010	# Load memory address of seven segment display
	li $t1, 0x1			# Initialise value to write to display
		
repeat:
	sb $t1, 0($t0)		# Write the value 0x1 to seven segment display
	sll $t1, $t1, 0x1
	beq $t1, 0x40, exit	# 0x40 is the bit at the top left position, everything after that should not be shown
	b repeat			# Branch to repeat label
	
exit:
	j exit
