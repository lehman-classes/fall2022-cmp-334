
.data 
# your program data. Think of it as your constants or static values 
hello: .asciiz "Hello World\n"


.text
# you program instructions. Think of it as every single line of code you write

main:
	li $v0, 4
	la $a0, hello
	syscall 
	
	li $v0, 10
	syscall 
  

