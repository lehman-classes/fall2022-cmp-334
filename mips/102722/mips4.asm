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
	
	# a[2] = 15
	addi $s2, $zero, 15
	addi $t0, $t0, 4 # index
	sw $s2, array($t0)
	
  # reset index to 0
	addi $t0, $zero, 0

while:
	beq $t0, 12, exit
	
  # store the value in the current index to $t9
	lw $t9, array($t0)
	
  # print value
	li $v0, 1
	addi $a0, $t9, 0
	syscall
	
	li $v0, 4
	la $a0, lf
	syscall
	
  # increment index
	addi $t0, $t0, 4
	
	j while
	

exit:
	# terminate
	li $v0, 10
	syscall
