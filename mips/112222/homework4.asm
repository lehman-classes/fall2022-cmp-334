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

spelling_words:	.word	word1, word2, word3, word4, word5, word6, word7, word8, word9, word10

prompt: 	.asciiz "Type a letter to complete the spelling of "

.text
	
	# STEP 1
	jal select_random_word
	# $a0 = randomly selected word
	# $a1 = random integer or index (NOT the multiplication result - 0,1,2...) 
	
	# STEP 2
	# calculate player name length
	jal strlen
	# $a0 = string length
	
	# STEP 3
	# randomly select an integer 0 to strlen INDEX
	# YOUR CODE HERE
	
	# STEP 4
	# print out, "Type a letter to complete the spelling of Occu_rence  "
	# Ask the user to complete the spelling of the word. 
	# For example, if the word is Occurrence and the INDEX is 4 (result from step 3), 
	# then ask the user "Type a letter to complete the spelling of  Occu_rence  "
	# YOUR CODE HERE
	
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
