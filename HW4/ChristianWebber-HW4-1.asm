# test data
.data
	cstr: .asciiz "Howaz"

.text
.globl strMAIN, STRLEN
# a test main
strMAIN:
	la $a0, cstr
	jal STRLEN

	li $v0, 10
	syscall


# main function to call for STRLEN.
# ------------------------
# sets $t1 to the first passed character
# then sets the counter ($t0) to 0
STRLEN:
	add $t1, $a0, $zero
	li $t0, 0

# The String Iterator
# -------------------------
# sets $t2 to the current character being looked at
# then checks if we've reached the end of the string (and if we have, exits)
# if we haven't, it repeats the loop after adding 1 to the counter and pointing $t1 to the next character.
strLOOP:
	lb $t2($t1)
	beqz $t2, strEXIT
	addi $t1, $t1, 1
	addi $t0, $t0, 1
	j strLOOP

# sets the return value ($v0) to the counter value ($t0) and then returns to the "sender"
strEXIT:
	add $v0, $zero, $t0
	jr $ra
