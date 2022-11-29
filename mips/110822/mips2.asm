.data 

hello: .asciiz "Hello world!"

.text 

	li $v0, 4
	la $a0, hello
	syscall
	
	li $t1, 5
	li $t2, 3
	
	# R-Type Instructions (Register addressing)
	add $t0, $t1, $t2
	
	# I-Type Instructions (Immediate addressing)
	addi $a3, $v0, 15
	# 001000 00010 00111 0000 0000 0000 1111 
	
	# Base addressing
	lw $t0, 128($a0)
	
	# PC Relative addressing
	# beq $zero, $a1, exit
	
	# J-Type Instructions
	# Register Direct addressing
	jr $a1
	
	j exit
	
exit:
	li $v0, 10
	syscall