.text
.globl quicksort

# setup left, right, and the pivot stuff and call qsort
quicksort:
	add $a1, $a1, $a0
	add $t8, $zero, $a0
	add $t9, $zero, $a1
	blt $a0, $a1, qsort
	j partition
	jr $ra

# first do a partition on the passed array
# then call quicksort on smaller versions of the array
qsort:
	addi $sp, $sp, -8
	sw $ra, 4($ra)
	j partition
	sw $v0, 0($sp)
	add $a0, $zero $t8
	addi $a1, $v1, -1
	j qsort
	lw $v0, 0($sp)
	addi $a0, $v0, 1
	add $a1, $zero, $t9
	j qsort
	lw $ra, 4($ra)
	jr $ra