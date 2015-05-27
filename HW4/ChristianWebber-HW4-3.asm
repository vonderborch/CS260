# test data
.data
	cstrA: .asciiz "eve"
	cstrB: .asciiz "hello"

.text
.globl threeMAIN
# a main for task 3
threeMAIN:
	# check the length of the inputted c strings
	la $a0, cstrA
	jal STRLEN
	la $a0, cstrB
	jal STRLEN
	
	# check if the inputted c strings are palindromes
	la $a0, cstrA
	jal isPalindrome
	la $a0, cstrB
	jal isPalindrome

	li $v0, 10
	syscall
