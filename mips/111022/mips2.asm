.data 

prompt: .asciiz "\nEnter number: "
result: .asciiz "\nValue returned: "

.text

	jal get_integer
	
	move $s0, $v0
	
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall
	
exit:
	li $v0, 10
	syscall

get_integer:
# Prompt the user to enter an integer value. Read and return
# it. It takes no parameters.

li $v0, 4 # system call code for printing a

# string = 4

la $a0, prompt # address of string is argument 0 to

# print_string

syscall # call operating system to perform

# print operation

li $v0, 5 # get ready to read in integers
syscall # system waits for input, puts the

# value in $v0

jr $ra