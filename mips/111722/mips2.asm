.data 

walter:		.asciiz "Walter"
skyler:		.asciiz "Skyler"
jesse:		.asciiz "Jesse"
saul:		.asciiz "Saul"
marie:		.asciiz "Marie"
hank:		.asciiz "Hank"
gus:		.asciiz "Gus"
tuco:		.asciiz "Tuco"
salamanca:	.asciiz "Salamanca"
eladio:		.asciiz "Eladio"


characters: 	.word walter, skyler, jesse, saul, marie, hank, gus, tuco, salamanca, eladio 


newline:	.asciiz "\n"

result:		.space 20


.text
	# select random name
	la $a0, characters
	li $a1, 10
	jal select_random_name
	
	# save results
	move $s0, $v0 # selected name
	move $s1, $a0 # name index
	
	# print results
	addi $a0, $s1, 0
	li $v0, 1
	syscall
	
	move $a0, $s0
	li $v0, 4
	syscall
	
	
	# get random int from 0 to 11
	#addi $a0, $zero, 11
	#jal random
	
	#move $s7, $v0

#addi $a0, $v0, 0
#li $v0, 1
#syscall

#mulou $t0, $s7, 4

#la $s5, characters
#add $s5, $s5, $t0
	
	# calculate string length
#	lw $a0, ($s5)

#li $v0, 4
#syscall
	#jal strlen
	
	# store string length in register $s0
	#move $s0, $v0
	
	# printing strlen int
	#addi $a0, $s0, 0
	#li $v0, 1
	#syscall
	
	# print a new line
	#jal new_line
	
	# get random value from 0 to string length
	#move $a0, $s0
	#jal random
	
	# store random int in register $s1
	#move $s1, $v0 
	
	# print random value
	#addi $a0, $s1, 0
	#li $v0, 1
	#syscall
	
	# print a new line
	#jal new_line
	
	# print guess word
	#la $a2, result
	#move $a1, $s1
	#la $a0, baseball
	#jal print_guess

	# exit
	li $v0, 10
	syscall
	

new_line:
	li $v0, 4
	#li $a0, 13
	la $a0, newline
	syscall

# FUNCTION printGuess(String text, int index, int count)
# Argument: 	$a0 = text
#		$a1 = index
#		$a2 = count
# returns result in $a0, negative return indicates error	
print_guess:
	move $t0, $a0
	li $t1, 0
	
	next_letter:
		lb $t2, 0($t0) # load character
		beqz $t2, print_guess_ret # if character is null return
		
		beq $t1, $a1, print_space # if counter equals index print space
	
		# print character
		li $v0, 11 
		move $a0, $t2
		syscall
		
		j continue
	
	print_space:
		li $v0, 11
		li $a0, 32 
		syscall
			
	continue:
		#sb $t2, 0($a2)
		#addi $a2, $a2, 1 # store
		
		addi $t0, $t0, 1 # next character
		addi $t1, $t1, 1 # increment counter
		j next_letter
		
	print_guess_ret:
		jr $ra
	 

# FUNCTION random(int max)
# Argument $a0 = max, must be greater than zero
# returns result in $v0, negative return indicates error	
random:
	move $a1, $a0
	li $v0, 42
	syscall
	
	move $v0, $a0 # save result to $v0
	jr $ra
	

# FUNCTION strlen(String value)
# Argument $a0 = value
# returns result in $v0
strlen:
	li $v0, 0
	next:
		lb $t1, 0($a0) 
		beqz $t1, strlen_ret
		addi $a0, $a0, 1
		addi $v0, $v0, 1
		j next
	strlen_ret:
		jr $ra
		
# FUNCTION selectRandomName(String[] array, int length)
# Argument $a0 = array of names
# 	   $a1 = array length
# returns result in $v0 (selected name), $a0 name index	
select_random_name:
	# save params
	move $t0, $a0 # array address
	move $t1, $a1 # array length
	
	# get random int 
	addi $a0, $t1, 0 
	jal random
	
	# save index
	move $t2, $v0
	
	# mult random int x 4
	mulou $t3, $t2, 4


#lw $a0, characters($t3)
#li $v0, 4
#syscall
			
	# result
	lw $v0, characters($t3)
	move $a0, $t2
	
	jr $ra
		
		

