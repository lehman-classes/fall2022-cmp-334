# Going from higher level language like Java to assembly
# 
# conditional statements
# if (a > b) {...} else {...}

# loops
# for, while, do-while

.data
lf: .asciiz "\n"

.text

	li, $t0, 0
	
loop:
	li $v0, 1
	add $a0, $t0, $zero
	syscall
	
	li $v0, 4
	la $a0, lf
	syscall
	
	addi $t0, $t0, 1
	blt $t0, 10, loop
	
	# terminate
	li $v0, 10
	syscall
	