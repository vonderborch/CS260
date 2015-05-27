.text
.globl fourmain

# call brutetest to test QuickSort implementation
fourmain:
	jal brutetest
	
	li $v0, 10
	syscall
