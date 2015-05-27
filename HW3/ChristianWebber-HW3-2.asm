.text 
.globl MAIN
MAIN:
	#set n
	li $a0, 3
	# clear v1
	li $v1, 0
	#call fib
	jal GIB
	#exit program
	li $v0, 10
	syscall

GIB:
	#if i < 2, special rules
	slti $t0, $a0, 2
	#if n>=2 then goto GIBMAIN end
	beq $t0, $zero, GIBMAIN
	#setup temp stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	#else if 0 return 0, if 1 return 0
	addi $v1, $zero, 1
	beq $a0, $zero, GIBRETURN
	#load return pointer and pop stack
	lw $ra, 0($sp)
	addi $sp, $sp, 16
	#return
	jr $ra

GIBRETURN:
	#return zero
	add $v1, $zero, $zero
	jr $ra

GIBMAIN:
	#setup stack
	addi $sp, $sp, -16
	sw $ra, 0 ($sp)
	sw $a0, 4 ($sp)
	
	#calculate n-1
	addi $a0, $a0, -1
	jal GIB
	
	#multiply n-1 by 3 and store result
	mul $v1, $v1, 3
	sw $v1, 8($sp)
	
	#load n
	lw $a0, 4($sp)
	
	#calculate n-2
	addi $a0, $a0, -2
	jal GIB
	
	#multiply n-2 by 2 and store result
	mul $v1, $v1, 2
	sw $v1, 12($sp)
	
	#load return address and n-1, n-2 and pop stack
	lw $ra, 0 ($sp)
	lw $t0, 8($sp)
	lw $t1, 12($sp)
	addi $sp, $sp, 12
	
	#calculate 3(n-1) + 2(n-2) + 1
	add $t0, $t0, $t1
	addi $v1, $t0, 1
	
	#return
	jr $ra
	
	
	