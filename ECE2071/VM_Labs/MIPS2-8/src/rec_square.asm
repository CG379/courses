# Written for ECE2071 S1 2023
# Copyright Monash University 2023
# Lab 8 Part 4 - Recursive Square Program

.text                       # Start generating instructions 
.globl square               # This label should be globally known

start:
    li  $a0, 0x0003         # load argument register $a0 with number to be squared					
    jal square              # call the recursive function to calculate the square
		
infinite:
    b infinite              # wait here when the calculation has finished 
                            # $v0 contains the result

#---------------------------------------------------------------
# square - input parameter $a0 contains number to be squared
#         result returned in register $v0
#---------------------------------------------------------------		
square:
    subi $sp, $sp, 8        # decrement the stack pointer $sp
    sw  $ra, 4($sp)         # push the return address register $ra
    sw  $a0, 0($sp)         # push argument register $a0
    li  $t0, 0x0001         # load $t0 with 1 as part of test for base case
    bne $a0, $t0, notbase   # branch if not the base case
    li $v0, 0x0001          # return base result in $v0
    addi $sp, $sp 8         # recover stack space (Note: did not corrupt registers)
    jr $ra                  # jump to return address in $ra


notbase: 	
    #*****************************************
    # your code for the non-base case goes here 
    #*****************************************
    subi $sp, $sp, 8        # push to stack 
    sw  $ra, 4($sp)         # push return address 
    
    subi $a0, $a0, 1        # get n-1
    jal square 		    # get (n-1)^2
    
    lw $a0, 0($sp)          # restore argument reg
    lw $ra, 4($sp)          # reset return address
    addi $sp, $sp, 8        # pop stack
    #addi $a0, $a0, -1
    # v0 has (n-1)^2 and a0 has n-1?
    add $v0, $v0, $a0       # (n-1)^2 + n-1
    add $v0, $v0, $a0       # 2(n-1) + (n-1)^2
    addi $v0, $v0, 1        # (n-1)^2 + 2(n-1) + 1
    
    jr $ra                  # return to $ra

