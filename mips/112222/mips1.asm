# Homework 4 --> NO YET POSTED
#
# Useful review to get you going
#
# Things we should know to complete Homework 4
#
# 1) Select an random name from a list
# 

.data 

jose: 		.asciiz "Jose"
manuel: 	.asciiz "Manuel"
carlos:		.asciiz "Carlos"

underscore: 	.asciiz "_"

players:	.word	jose, manuel, carlos

prompt: 	.asciiz "Enter letter: "

.text
	jal select_random_player
	# $a0 = player name
	# $a1 = random integer or index (NOT the multiplication result - 0,1,2...) 
	
	# calculate player name length
	jal strlen
	# $a0 = string length
	
	# randomly select an integer 0 to strlen INDEX
	
	# print out player name with letter at INDEX removed
	
	# ask user to enter a letter
	
	# if it matches missing letter player WINS prints "Awesome!"
	
	# else print "Try next time"
	

	addi $t0, $zero, 0
loop:
	move $a0, $t0
	li $v0, 1
	syscall
	
	addi $t0, $t0, 1
	ble $t0, 5, loop
	
	j exit

	
	la $a0, prompt
	li $v0, 4
	#syscall
	
	li $v0, 12
	#syscall
	
	# save input
	move $s4, $v0
	
	move $a0, $s4
	li $v0, 11
	#syscall
	
	li $a0, 95
	#la $a0, underscore
	li $v0, 11
	#syscall
		
	# getting a random integer
	li $a1, 3 # provide upper bound 
	li $v0, 42
	syscall
	
	# save random int using register $s0
	move $s0, $a0
	
	# random int is returned in register $a0
	#li $v0, 1 
	#syscall

	# how to select one of the names from the array players
	# players array
	# players[0] --> beginning of array 
	#addi $t0, $zero, 0 # index 0 is the first item in array players
	mulo $t0, $s0, 4
	
	# save player in register $s1
	lw $s1, players($t0)
	
	# prints player name
	move $a0, $s1
	li $v0, 4
	#syscall
	
	
	
	
	
	#addi $t0, $t0, 4 # index 1 is the first item in array players
	#lw $a0, players($t0)
	#li $v0, 4
	#syscall

	#addi $t0, $t0, 4 # index 2 is the first item in array players
	#lw $a0, players($t0)
	#li $v0, 4
	#syscall

exit:
	li $v0, 10
	syscall


# FUNCTION: select_random_player
# Argument list here...
# Return values: $a0 = player name, $a1 = index or random value
select_random_player:
	# write your code here
	# YOUR CODE HERE
	lw $a0, jose
	li $a1, 0
	
	jr $ra
	
# FUNCTION: strlen
# Argument list here...
# Return values: $a0 = string length
strlen:
	# write your code here
	# YOUR CODE HERE
	li $a0, 5
	
	jr $ra
