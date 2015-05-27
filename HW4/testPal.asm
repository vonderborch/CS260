.data
	T:
		.word 1 # is a pal
		.asciiz "eve"
		.space 8
		
		.word 0 # is not a pal
		.asciiz "abbe"
		.space 7
		
		.word 0 # is not a pal
		.asciiz ""
		.space 11
		
		.word 1 # is a pal
		.asciiz "a"
		.space 10
		
		.word 1 # is a pal
		.asciiz "heyeh"
		.space 6
		
		.word 1 #is a pal
		.asciiz "awabbawa"
		.space 4
		
		.word 0 # is not a pal
		.asciiz "hello"
		.space 6
		
		.word 0 # is not a pal
		.asciiz "war"
		.space 8
		
		.word 0 #is not a pal
		.asciiz "good"
		.space 7
		
		.word 0 # is not a pal
		.asciiz "almostomla"
		.space 1
	U:

.text
.globl testPal
testPal:
	la $a0, T
	la $a1, U
	
	jal testPal_TU
	
	add $a0, $v0, $zero
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall

testPal_TU:
	# save the return address to the stack after opening space for it
	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	add $t0, $zero, $zero # set fail counter to 0
	add $t1, $a0, $zero # set $t1 to T(0)
	add $t2, $a1, $zero # set $t2 to U

testLOOP:
	lb $t3($t1) # actual pointer
	lb $t4($t1) # temp pointer
	
	bge $t3, $t4, testEXIT
	
	lw $t5,0($t4) # set $t5 to the valid palindrome answer
	addi $t4, $t4, 4 #set $t4 to the actual word
	add $a0, $t4, $zero # set argument to the word
	jal isPalindrome
	
	and $t5,$t5,$v0
	add $t0,$t0,$t5
	
	addi $t1, $t1, 16
	
	j testLOOP

testEXIT:
	add $v0, $zero, $t0 # set the return variable to the fail counter
	lw $ra,0($sp) # load the return address...
	addi $sp,$sp,4 # ... and then remove the stack space
	jr $ra