# Written for ECE2071 S1 2023
# Copyright Monash University 2023
# Lab 8 Part 3 - Prime Number detector

.text                       # Start generating instructions 
.globl is_prime             # This label should be globally known

start:
    li  $a0, 0x0003         # load argument register $a0 with number to be test
    jal is_prime            # call the recursive function to test if prime
		
infinite:
    b infinite              # wait here when the calculation has finished 
                            # $v0 contains the result

#---------------------------------------------------------------
# is_prime - input parameter $a0 contains number to test
#   result returned in register $v0 (1 if prime, 0 if not prime)
#---------------------------------------------------------------		
is_prime:	
    #*****************************************
    # your code goes here 
    #*****************************************
    # words length = 4
    addi $t0, $zero, 2      # initialize $t0 to 2
    addi $sp, $sp, -4       # Get temop var from stack
    sw   $zero, 0($sp)      # set var to 0
divide:
    beq $t0, $a0, true      # if we get to $a0, and nothing has returned yet, it is prime	
    div $a0, $t0	        # divide
    # hi is the remainer, lo is the result
    mfhi $t1		        # get remainder	
    beq  $t1, $zero, false  # remainder if prime, 0 rem means prime
    addi $t1, $t0, 1	    # incriment counter
    j divide		        # loop

false:
    sw   $t1, 0($sp)        # not prime
    j return

true:
    li $v0, 1               # number is prime
    j return

return:  
    lw   $v0, 0($sp)        # load result to $v0
    addi $sp, $sp, 4        # pop stack
    jr   $ra                # return
