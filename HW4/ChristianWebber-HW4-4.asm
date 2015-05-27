.text
.globl MAIN
MAIN:
	jal testPal
	
	li $v0, 10
	syscall
