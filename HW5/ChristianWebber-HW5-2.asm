.text
.globl partition
# Setup the left address, right address, and pivot stuff
partition:
	addi $sp, $sp, -12
	sw $a0, 0($sp) #left
	sw $a1, 4($sp) #right
	sw $ra, 8($sp) #return
	
	addi $a1, $a1, -1
	addi $t0, $a0, -1 #left address
	addi $t1, $a1, 1 #right address
	addi $t2, $a1, -1 #pivot address
	lw $t2, 0($t2)
	jal partmain
	
	lw $a0, 0($ra)
	lw $a1, 4($ra)
	
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra

# while (left < right) repeat partition cycle
partmain:
	addi $sp, $sp, -4
	sw $ra, 8($sp)
		
	j whileg
	j whilel
	j ifl
	
	blt $t0, $t1, partmain
	
	lw $ra, 8($sp)
	addi $sp, $sp, 4
	jr $ra

# while (array[right] > pivot) repeat whileg
whileg:
	addi $t1, $t1, -1
	lw $t4, 0($t1)
	
	bgt $t4, $t3, whileg
	
	jr $ra

# while (left < right and array[left] <= pivot) repeat whilel
whilel:
	addi $t0, $t0, 1
	lw $t4, 0($t0)
	
	slt $t5, $t0, $t1 #(left < right), 0 = false
	sgt $t6, $t3, $t4 #(array[left] <= pivot), 1 = false
	
	bne $t5, $t6, whilel
	
	jr $ra

# if (left < right) then swap left and right addresses
ifl:
	add $a0, $zero, $t0
	add $a1, $zero, $t1
	j swap
	jr $ra