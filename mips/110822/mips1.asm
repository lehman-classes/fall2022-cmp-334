
.data 

hello: .asciiz "Hello"

.text
	li $t1, 9
	
	sub $v0, $t1, 5
	la $a0, hello
	syscall
	
	
	li $v0, 10
	syscall