.text 
.globl MAIN
MAIN:
	#set n-1
	li $a0, 4
	#set i
	li $a1, 1
	# clear v1
	li $v1, 0
	#call SUM
	jal SUM
	#exit program
	li $v0, 10
	syscall

SUM:
	#setup return stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	#multiply a1 by a1
	mul $t0, $a1, $a1
	#add result to $v1
	add $v1, $v1, $t0
	#add 1 to i
	addi $a1, $a1, 1
	#if i != n, new sum, else return 
	bne $a1, $a0, SUM
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra