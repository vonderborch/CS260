# test data
.data
	cstr: .asciiz "eve"

.text
.globl palMAIN, isPalindrome
# a test main
palMAIN:
	la $a0, cstr
	jal isPalindrome

	li $v0, 10
	syscall

# main function to call for this task
isPalindrome:
	# save the return address to the stack after opening space for it
	addi $sp,$sp,-4
	sw $ra,0($sp)
	add $a1, $a0, $zero #setting $a1 to the first character in passed string
	jal STRLEN # get the length of the inputted string
	
	addi $t3, $v0, -1 # subtract 1 from the length of the inputted string (to account for 0 being register "base" not 1)
	
	add $t0, $a1, $zero # set $t0 to the first character in the inputted string
	add $t1, $a1, $t3 # set $t1 to the last character in the inputted string
	
	addi $t4, $zero, 1 #set isPalindrome "boolean" to true (1 = true, 0 = false)
	
palLOOP:
	bge $t0, $t1, palEXIT # if the $t0 and $t1 point to the same character location (or $t0 is 
				# pointing to a higher one than $t1), we have a palindrome!

	# point $t2 and $t3 to the next characters for their respective parts of the string
	lb $t2($t0)
	lb $t3($t1)
	
	# if the characters being looked at do not match, this is no palindrome
	bne $t2, $t3, palBAD
	
	# increment character iterators
	addi $t0, $t0, 1
	addi $t1, $t1, -1
	
	# repeat loop
	j palLOOP
	
palBAD:
	# set isPalindrome "boolean" to false
	add $t4, $zero, $zero

palEXIT:
	add $v0, $zero, $t4 # set the return variable to the isPalindrome "boolean"
	lw $ra,0($sp) # load the return address...
	addi $sp,$sp,4 # ... and then remove the stack space
	jr $ra # and jump back to the function that called isPalindrome!