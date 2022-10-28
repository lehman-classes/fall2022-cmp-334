.data 

name: .asciiz "What's your name? "
data: .asciiz ""

.text 
	# prints in the terminal "What's your name?"
	li $v0, 4
	la $a0, name
	syscall
	
	# read the input from the terminal
	li $v0, 8
	la $a0, data
	li $a1, 100
	syscall
	
	# print the value in data address
	li $v0, 4
	la $a0, data
	syscall
	
	# exit program
	li $v0, 10
	syscall
	
	
	