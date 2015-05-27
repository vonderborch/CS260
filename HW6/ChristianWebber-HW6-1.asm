# Equations:
#	g(x)  = x^3 - 11
#	g'(x) = 3x^2

.data
	eleven: .double -11.0
	three: .double 3.0
	base: .double 1.0
	gooderr: .double 10E-6

.text
MAIN:
	j newtons_gee
	
	li $v0, 10
	syscall

# g(x) = x^3 - 11
newtons_top:
	# compute x^3
	mul.d $f2, $f0, $f0
	mul.d $f2, $f2, $f0
	# compute x^3 - 11 and return
	l.d $f1, eleven
	add.d $f2, $f2, $f1
	jr $ra

# g'(x) = 3x^2
newtons_bot:
	#compute x^2
	mul.d $f4, $f0, $f0
	#compute 3x^2 and return
	l.d $f1, three
	mul.d $f4, $f2, $f1
	jr $ra

newtons_err:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	# compute the top
	j newtons_top
	# compute the bottom
	j newtons_bot
	# divide both and return
	div.d $f6, $f2, $f4
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

newtons_nth:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	# compute g(x_n), g'(x_n), and E(n)
	j newtons_err
	
	# compute x_(n+1)
	sub.d $f0, $f0, $f6 #x(n) - E(n)
		
	#increment n
	addi $a0, $a0, 1	
	
	
	# check if the error is within a "good" range
	addi $v0, $zero, 0
	l.d $f1, gooderr
	c.lt.d $f6, $f1
	bc1t setgood
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
setgood:
	addi $v0, $zero, 1
	jr $ra

newtons_gee:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	# set x_0 to 1.0
	l.d $f0, base
	# set n to 0
	addi $a0, $zero, 0
	j while_gee
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

# newtons_gee loop
while_gee:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	addi $t0, $zero, 1
	bne $v0, $t0, newtons_nth
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra