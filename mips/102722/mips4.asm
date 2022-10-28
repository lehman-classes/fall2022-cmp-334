# Going from higher level language like Java to assembly
# 
# arrays
# int[] a = new int[5];
# 

.data

# int[] a = new int[3]
array: .space 12
lf: .asciiz "\n"

.text
	# a[0] = 5
	addi $s0, $zero, 5
	addi $t0, $zero, 0 # index
	sw $s0, array($t0)
	
	# a[1] = 10
	addi $s1, $zero, 10
	addi $t0, $t0, 4 # index
	sw $s1, array($t0)
	
	# a[1] = 10
	addi $s2, $zero, 15
	addi $t0, $t0, 4 # index
	sw $s2, array($t0)
	
	# print array
	addi $t0, $zero, 0
while:
	beq $t0, 12, exit
	
	lw $t9, array($t0)
	addi $t0, $t0, 4
	
	li $v0, 1
	addi $a0, $t9, 0
	syscall
	
	li $v0, 4
	la $a0, lf
	syscall
	
	
	j while
	

exit:
	# terminate
	li $v0, 10
	syscall