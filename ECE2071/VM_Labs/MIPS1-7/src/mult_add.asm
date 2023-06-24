# Written for ECE2071 S1 2023
# Copyright Monash University 2023
# Lab 7 Part 2 - Multiplication via successive addition


.text                   # Start generating instructions
.globl main             # Makes the label main globally known


.text                   # Instructions in the program:
start:
# setting $t0 = 2 and $t1 = 3:
	addi    $t0, $0, 2
	addi    $t1, $0, 3

	add	$s0, $0, $0 # s0 = 0, counter = 0
# main program:
main:
	
# WRITE YOUR CODE HERE
	ble $t1 $0 end		# if less than 0, go to the end
	add $s0 $t0 $0		# add to the counter s0
	subi $t0 $t0 1		# subtract 1 from t0
	j main

end:
	j end