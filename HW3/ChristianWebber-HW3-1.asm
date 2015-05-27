.text 
.globl MAIN
MAIN:
	#set n
	li $a0, 3
	# clear v1
	li $v1, 0
	#call fib
	jal FIB
	#exit program
	li $v0, 10
	syscall

FIB:
	#if n!=0 then goto FIBMAIN end
	bne $a0, $zero, FIBMAIN
	#else add 1 to v1 and return
	addi $v1, $zero, 1
	jr $ra
	
FIBMAIN:
	#setup stack
	addi $sp, $sp, -12
	sw $ra, 0 ($sp)
	sw $a0, 4 ($sp)
	
	#calculate n-1
	addi $a0, $a0, -1
	jal FIB
	
	#multiply n by 2 and add 1
	mul $v1, $v1, 2
	addi $v1, $v1, 1
	
	#load return address and pop stack
	lw $ra, 0 ($sp)
	addi $sp, $sp, 12
	
	#return
	jr $ra