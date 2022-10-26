
.data 
fileout:	.asciiz "demo.txt"
data:		.asciiz "Hey there\n"
input:		.space 10
errmsg: 	.asciiz "File couldn't be read"

.text

	# opening a file for writing
	# li $v0, 13
	# la $a0, fileout
	# li $a1, 1
	# li $a2, 0
	# syscall 
	
	# opening a file for reading
	li $v0, 13
	la $a0, fileout
	li $a1, 0
	li $a2, 0
	syscall 
	
	bltz $v0, error
	
	# saving file descriptor
	move $s0, $v0
	
	# write to file
	# li $v0, 15
	# move $a0, $s0
	# la $a1, data
	# li $a2, 9
	# syscall 
	
	# read from file
	li $v0, 14
	move $a0, $s0
	la $a1, input
	li $a2, 10
	syscall 
	
	# print to console data from file
	li $v0, 4
	la $a0, input
	syscall 
	
	# closing file
	li $v0, 16
	move $a0, $s0
	syscall 

	b exit

error:
	li $v0, 4
	la $a0, errmsg
	syscall
	
exit:
	# exit
	li $v0, 10
	syscall