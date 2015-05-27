.data
World: .ascii "____f____"
XCoord: .byte 4
under: .ascii "_"
frog: .ascii "f"

.text
# Call main Frogger repeatedly until has to exit
main:
	lui $t0, 0xFFFF
	j frogger
	
	bne $v0, $zero, exit
	j main

#display a character on the screen
emitchar:
	lui $t0, 0xFFFF
	lw $t1, 8($t0)
	andi $t1, $t1, 0x0001
	beq $t1, $zero, emitchar
	sw $a0, 12($t0)
	li $v0, 11
	syscall
	jr $ra

#display a string
emitseq:
	beq $a0, $a1, seqexit
	addi $a0, $a0, 1
	j emitchar

#exit
seqexit:
	jr $ra

#display the "world" string
emitworld:
	addi $ra, $ra, -4($sp)
	sw $ra, 0($sp)
	jal emitseq
	
	lw $ra, 0($sp)
	addi $ra, $ra, 4($sp)
	jr $ra

#"move" the player's character
blit_frog:
	lw $t6, 0(XCoord)
	lw $t7, 0($a0)
	add $t7, $t6, $t7
	
	sw under, $t6(World)
	sw frog, $t7(World)
	
	jr $ra

#check if the frog is moved, etc.
update_frog:
	#is the key pressed q?
	addi $s0, $zero, 113
	beq $a0, $s0, exit
	
	#is the key pressed l?
	addi $s0, $zero, 108
	beq $a0, $s0, check_right
	
	#is the key pressed h?
	addi $s0, $zero, 104
	beq $a0, $s0, check_left
	
	add $v0, $zero, $zero
	
	j exit_frog

#move left?
check_left:
	beq $zero, XCoord, no_update
	add XCoord, XCoord, $a0
	j emitworld

#move right?
check_right:
	addi $t0, $zero, 9
	beq $t0, XCoord, no_update
	add XCoord, XCoord, $a0
	j emitworld
	
#update the world string
update_world:
	addi $a0, $a0, -1
	addi $a1, $a1, 0
	addi $v0, $v0, 0
	j emitworld
	j exit_frog

#no update needed
no_update:
	addi $v0, $zero, 119

#exit move update stuff
exit_frog:
	jr $ra

#check for frog movement
teechar:
	addi $sp, $sp, -4
	sw $ra, 0 ($sp)
	
	jal keyboard
	
	lw $ra, 0 ($sp)
	addi $sp, $sp, 4
	jr $ra

#frogger main class
frogger:
	addi $sp, $sp, -4
	sw $ra, 0 ($sp)
	
	jal teechar
	jal update_frog
	
	lw $ra, 0 ($sp)
	addi $sp, $sp, 4
	jr $ra

# get input
keyboard:
	lw $t1, 0($t0)
	andi $t1, $t1, 0x0001
	beq $t1, $zero, keyboard
	
	lw $a0, 4($t0)
	
	jr $ra
	
#exit game
exit:
	li $v0, 10
	syscall