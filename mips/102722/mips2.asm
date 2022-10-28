
.data

ask: .asciiz "What's your name? "
name: .space 128


.text 
	# print text in console
	li $v0, 4
	la $a0, ask
	syscall
	
	# wait for user input
	li $v0, 8
	la $a0, name
	li $a1, 128
	syscall
	
	
	# terminate program
	li $v0, 10
	syscall