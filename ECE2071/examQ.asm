

start:
# string to analyse
li $a0, $a0, 0x10010000
# string length string = 10
addi $a1, $a1, 10
# value for letter D
add $a2, $a2, 0x44

# result
addi $t0, $0, 0 

addi $sp, $sp, -16
# store function arguments on the stack:
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $t0, 12($sp)
jal search_string
# pop function arguments from the stack:
addi $sp, $sp, 8

# restore important registers from the stack:
lw $a0, 0($sp)
lw $a1, 4($sp)
lw $a2, 8($sp)
addi $sp, $sp, 12

j end
	
	
search_string:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	# get the function arguments from the stack:
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	
	# Result
	add $v0, $0, $0
	lw $ra, 0($sp)
	
	# use and so there is only one letter 
	# divide letter by D
	# if no remainder, it contains D
	# else continue till end of word
	# if no D return 0 
	# https://stackoverflow.com/questions/14497885/finding-a-character-of-a-string-in-mips
loop: beq $a2, $0, false
	

	
	beq $a2, $a0, found
	j loop

False:
	addi $v0, $0, 0
	jr $ra
True:
	addi $v0, $0, 1
	jr $ra


end:
	j end