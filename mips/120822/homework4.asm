# Homework 4
#
 

.data 

word1:	.asciiz "Nauseous"   
word2:	.asciiz "Dilate"
word3:	.asciiz "Fuchsia"
word4:	.asciiz "Minuscule"
word5:	.asciiz "Ingenious"
word6:	.asciiz "Sacrilegious"
word7:	.asciiz "Orangutan"
word8:	.asciiz "Paraphernalia"
word9:	.asciiz "Epitome"
word10:	.asciiz "Slough"

# Base from address      0      4      8      12     16     20     24     28     32     36
spelling_words:	.word	word1, word2, word3, word4, word5, word6, word7, word8, word9, word10

selected_word:	.space 4 
selected_x:	.space 4

user_won: .asciiz "You win!"

prompt: 	.asciiz "Type a letter to complete the spelling of "

.text
	# (1) getting an item from array
	#la $t1, spelling_words
	#lw $t2, 28($t1)
	
	# get a random number X from 0 to 9
	# X * 4 = Base from Address*
	
	# (2) getting an item from array
	li $t0, 36
	lw $t1, spelling_words($t0)
	
	
	#li $v0, 4
	#move $a0, $t2
	#syscall
	
	# STEP 1
	jal select_random_word
	# $a0 = randomly selected word
	# $a1 = random integer or index (NOT the multiplication result - 0,1,2...) 
	
	lb $t2, 0($t1) # S
	li $v0, 11
	move $a0, $t2
	syscall
	
	lb $t3, 1($t1) # l
	lb $t4, 2($t1) # o
	lb $t5, 3($t1) # u
	lb $t6, 4($t1) # g
	lb $t7, 5($t1) # h
	lb $s0, 6($t1) # null or 0
	
	
	# STEP 2
	# calculate selected word length
	jal strlen
	# $a0 = string length
	
	li $v0, 42
	li $a0, 0
	li $a1, 6
	syscall
	
	li $v0, 1
	syscall	
	# STEP 3
	# randomly select an integer 0 to strlen INDEX
	# YOUR CODE HERE
	
	lb $s1, 2($t1)
	li $t4, 095
	
	
	# STEP 4
	# print out, "Type a letter to complete the spelling of Occu_rence  "
	# Ask the user to complete the spelling of the word. 
	# For example, if the word is Occurrence and the INDEX is 4 (result from step 3), 
	# then ask the user "Type a letter to complete the spelling of  Occu_rence  "
	# YOUR CODE HERE
	
	
	li $v0, 12
	syscall 
	
	beq $v0, $t4, you_win
	
	
you_win:
	li $v0, 4
	la $a0, user_won
	syscall 	
	# STEP 4
	# Check user input letter. If it matches the missing letter, print out "You win!". 
	# Otherwise, print out "Sorry, the correct spelling is [SPELLING WORD]". 
	# For example, if the SPELLING WORD is  Occurrence, then print out "Sorry, the correct spelling is Occurrence"
	# YOUR CODE HERE
	
	

exit:
	li $v0, 10
	syscall


# FUNCTION: select_random_word
# Argument list here...
# Return values: $a0 = random word, $a1 = index or random value
select_random_word:
	# write your code here
	# YOUR CODE HERE
	
	jr $ra
	
# FUNCTION: strlen
# Argument list here...
# Return values: $a0 = string length
strlen:
	# write your code here
	# YOUR CODE HERE
	
	jr $ra
