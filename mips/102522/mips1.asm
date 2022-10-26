
# data use by your program here
.data 

greeting: .asciiz "Hey there"

# actual instructions here
.text 
	# print string value at the greeting's label address
	li $v0, 4
	la $a0, greeting
	syscall
	
	
	# exit
	li $v0, 10
	syscall
	
	