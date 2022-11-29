.data

name: .asciiz "\nEnter name: "
number: .asciiz "\nEnter favorite number: "
lf: .asciiz "\n"
result: .asciiz ", your favorite number is "

.text 

	addi $a0, $zero, 20
	li $a1, 12
	li $a2, 23
	li $a3, 7
	jal add_params
	
	li $v0, 1
	move $a0, $s0
	syscall
	
exit:
	li $v0, 10
	syscall


# add(a, b, c, d);
add_params:
	# $a0, $a1, $a2, $a3 are equivalent to a, b, c, d
	add $s0, $a0, $a1
	add $s0, $s0, $a2
	add $s0, $s0, $a3
	
	# return value is in $s0
	jr $ra

