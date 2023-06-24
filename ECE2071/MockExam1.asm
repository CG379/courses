
.text                   # Start generating instructions
.globl start            # This label should be globally known


# This gets reverses the bits stored in $a0 and stores them in reverse order in $a1
start:

    li $a0 0x00001011

    li $a1 0x00000000

    li $t0 32 # counter for loop

loop:

    beq $t0 $0 exit

    sll $a1 $a1 1

    andi $t1 $a0 1

    or $a1 $a1 $t1

    srl $a0 $a0 1

    addi $t0 $t0 -1

exit:
    j exit