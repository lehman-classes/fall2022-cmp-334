		.data
row:		.asciiz "\n-----+------+-----\n"
disRow:		.asciiz "\n-----+-----+-----\n"
sep:		.asciiz " | "
x:		.asciiz "  X "
o:		.asciiz "  O "
empty:		.asciiz "    "
row1:		.asciiz "  1  |  2  |  3  "
row2:		.asciiz "  4  |  5  |  6  "
row3:		.asciiz "  7  |  8  |  9  \n"
welcome:	.asciiz "Welcome to the game of Tic Tac Toe\n\n"
explain:	.asciiz "The board numbering is as follows.  Play in a cell by selecting the cell number.\n\n"
youAre:		.asciiz "\nYou (the player) will play as O.\n\n"
cell:		.asciiz "Choose a cell to play in (1-9): "
diff:		.asciiz "Please choose a difficulty (1-9): "
pAgain:		.asciiz "Play again (y or n)? "
cMove:		.asciiz "Computer's move.\n\n"
pMove:		.asciiz "Your move.\n"
cWin:		.asciiz "Way to lose.  I win!"
pWin:		.asciiz "Alright, whatever..  you win."
aTie:		.asciiz "Alright, so we tied.  Don't brag"
playAgain:	.asciiz "Would you like to play again (1=yes, 2=no)? "
nlnl:		.asciiz "\n\n"
nl:		.asciiz "\n"

##add more strings as the game continues

		.align 2
board:		.word 0,0,0,0,0,0,0,0,0						#store the board's initial state
cBoard1:	.space 36							#space for copy of board
win:		.word 1,2,3,4,5,6,7,8,9,1,4,7,2,5,8,3,6,9,1,5,9,3,5,7		#array of winning combinations
cBoard2: 	.space 36							#space for copy of board

		.text
		.globl main
main:
		li $v0, 4
		la $a0, welcome
		syscall				#display welcome message
		
		li $v0, 4
		la $a0, explain
		syscall				#display grid explanations
		
		li $v0, 4
		la $a0, row1
		syscall
		
		li $v0, 4
		la $a0, disRow
		syscall
		
		li $v0, 4
		la $a0, row2
		syscall
		
		li $v0, 4
		la $a0, disRow
		syscall	
		
		li $v0, 4
		la $a0, row3
		syscall				#display numbered board

		li $v0, 4
		la $a0, nl
		syscall

		addi $s4, $zero, 4		#random number generation purposes

diffi:		
		li $v0, 4
		la $a0, diff
		syscall				#display "choose difficulty"

		li $v0, 5
		syscall				#read input for cell number
		add $t0, $v0, $zero		#put input value into $t0

		li $v0, 4
		la $a0, nl
		syscall

		blez $t0, diffi
		bge $t0, 10, diffi		#branch if input is invalid

		add $s5, $t0, $zero		#place difficulty chosen in register

		li $v0, 4
		la $a0, youAre
		syscall				#display which letter user plays as
		
						#random number generation
		addi $t1, $zero, 8
		addi $t2, $zero, 3
		addi $t4, $zero, 9
		add $t0, $zero, $s4
		
		mul $t0, $t0, $t1
		add $t0, $t0, $t2
		div $t0, $t4
		mfhi $t0			#end random number generation
		
		la $s0, board			#load address of game board
		li $s1, 1			#1 represents x
		li $s2, 2			#2 represents o
		li $s3, 0			#0 represents empy cell
		
game:

firstMove:
		
		mul $t0, $t0, 4			#cell entries are words
		add $s0, $s0, $t0		#move pointer to computer first move
		sw $s1, 0($s0)			#place x in compute chosen cell
		sub $s0, $s0, $t0		#move pointer back to start of board array

		li $v0, 4
		la $a0, cMove
		syscall				#display that it's computer's move,

		add $a0, $s0, $zero
		jal displayBoard		#display current state of board

otherMoves:

		li $v0, 4
		la $a0, pMove
		syscall				#display that it's the user's move
userIn:
		li $v0, 4
		la $a0, cell
		syscall				#ask which cell user wants to play in

		li $v0, 5
		syscall				#read input for cell number
		add $t0, $v0, $zero		#put input value into $t0
		add $t1, $v0, $zero
		addi $t0, $t0 -1

		mul $t0, $t0, 4			#cells are word aligned
		add $s0, $s0, $t0		#move to chosen cell
		lw $s3, 0($s0)			#get cell
		sub $s0, $s0, $t0		#replace pointer back at start of array		
		
		bnez $s3, userIn		
		blez $t1, userIn
		bge $t1, 10, userIn		#branch if input is invalid
		
		add $s0, $s0, $t0		#move to chosen cell
		sw $s2, 0($s0)			#place o
		sub $s0, $s0, $t0		#replace pointer back at start of array
		
		li $v0, 4
		la $a0, nl
		syscall				#new line		

		add $a0, $s0, $zero
		jal displayBoard		#display current state of board
		
		add $a0, $s0, $zero
		jal gameOver
		add $t0, $v0, $zero		#check if game is over
		
		beq $t0, 10, aWin
		beq $t0, -10, aWin
		beq $t0, 0, aWin		#if a win or tie occured, branch
		
		add $a0, $s0, $zero
		add $a1, $zero, $zero
		jal max				#jump to minimax algorithm
		add $t0, $v0, $zero	

		mul $t0, $t0, 4			#cells are word aligned
		add $s0, $s0, $t0		#move to chosen cell
		sw $s1, 0($s0)			#place o
		sub $s0, $s0, $t0		#replace pointer back at start of array
	
		li $v0, 4
		la $a0, cMove
		syscall				#display that it's the user's move	
		
		add $a0, $s0, $zero
		jal displayBoard		#display current state of board
		
		add $a0, $s0, $zero
		jal gameOver			#check if game is over
		add $t0, $v0, $zero
		
		beq $t0, 10, aWin
		beq $t0, -10, aWin
		beq $t0, 0, aWin		#if win or tie occured, branch
	
		j otherMoves			#loop

aWin:						#if an end-game state has occured, check for win or tie
		li $v0, 4
		la $a0, nl
		syscall
		
		bne $t0, 10, noC		#if computer did not win, branch
		li $v0, 4
		la $a0, cWin
		syscall
noC:
		bne $t0, -10, noP		#if user did not win, branch
		li $v0, 4
		la $a0, pWin
		syscall	
noP:
		bne $t0, 0, noT			#if it is not a tie, branch
		li $v0, 4
		la $a0, aTie
		syscall			
noT:

		li $v0, 4
		la $a0, nlnl
		syscall
		
		li $v0, 4
		la $a0, playAgain
		syscall				#ask if user wants to play again

		li $v0, 5
		syscall				#read input for cell number
		add $t0, $v0, $zero		#put input value into $t0

		li $v0, 4
		la $a0, nl
		syscall		

		bne $t0, 1, notAgain		#if user chooses no, branch
		add $t1, $zero,$zero		#initialize with 0 for empty cell
		add $t0, $zero, $zero		#initialize counter
clearLoop:
		beq $t0, 9, doneClear		#loop to clear board for new game
		sw $t1, 0($s0)			#store empty cell
		addi $t0, $t0, 1		#increment counter
		addi $s0, $s0, 4		#more pointer to next element in board
		j clearLoop
doneClear:
		addi $s0, $s0, -36		#move pointer back to beginning of array
		addi $s4, $s4, 7		#for random number generation purposes
		j diffi

notAgain:	j exit				#EXIT


#########################################################################
###############function below for minimax algorithm######################
###############Arguments:			   ######################
###############  $a0 - address of board		   ######################
###############  $a1 - depth			   ######################
###############Return:				   ######################
###############  $v0 - best position to play	   ######################
#########################################################################

max:
		add $t0, $a0, $zero		#load address of array into $t0
		add $t1, $a1, $zero		#load depth into $t1
		
		addi $sp, $sp, -44		#allocate space on stack
		sw $t0, 0($sp)
		sw $t1, 4($sp)
		sw $t2, 8($sp)
		sw $t3, 12($sp)
		sw $t4, 16($sp)
		sw $t5, 20($sp)
		sw $t6, 24($sp)
		sw $t7, 28($sp)
		sw $t8, 32($sp)
		sw $t9, 36($sp)
		sw $ra, 40($sp)			#push elements
				
		jal gameOver			#check if game is over
		
		lw $ra, 40($sp)
		lw $t9, 36($sp)
		lw $t8, 32($sp)
		lw $t7, 28($sp)
		lw $t6, 24($sp)
		lw $t5, 20($sp)
		lw $t4, 16($sp)
		lw $t3, 12($sp)
		lw $t2, 8($sp)
		lw $t1, 4($sp)
		lw $t0, 0($sp)
		addi $sp, $sp, 44		#de-allocate memory on stack

		add $t2, $v0, $zero		#put returned value into $t2 (win/loss state)
		abs $t3, $t2			#take absolute value of returned value for easier comparison
		
		beq $t3, 10, over
		beq $t3, 0, over
		bgt $t1, $s5, over		#if game is over OR depth is larger than max depth
		j notOver
over:
		add $v0, $t2, $zero		#return win/loss state
		jr $ra
notOver:

		addi $t3, $zero, -20		#max = -infinity
		add $t4, $zero, $zero		#initialize counter
forLoop:		
		beq $t4, 9, endFor		#for(i = 0, i < 9, i++)
		
		lw $t5, 0($t0)			#get element from board
		
		bne $t5, 0, endIf		#if cell is not empty, branch
		
		la $t5, cBoard1			#get array space for copied array
		
		add $t6, $zero, $zero		#initialize counter
		mul $t7, $t4, 4			
		sub $t0, $t0, $t7		#move pointer of $t0 to begining of array
copy:
		beq $t6, 9, copied		#loop for copying board
		lw $t7, 0($t0)			#get element from board
		sw $t7, 0($t5)			#put element to copied board
		addi $t0, $t0, 4		#more pointer to next element
		addi $t5, $t5, 4		#copy array
		addi $t6, $t6, 1		#increment counter
		j copy
copied:
		addi $t0, $t0, -36
		addi $t5, $t5, -36		#move pointers to beginings of arrays
		mul $t7, $t4, 4
		add $t0, $t0, $t7		#move pointer back to original position
		
		add $t5, $t5, $t7		#move pointer to ith position relative to board
		sw $s1, 0($t5)			#put x in such position
		sub $t5, $t5, $t7		#move pointer back
		
		addi $sp, $sp, -80
		add $t6, $zero, $zero		#initialize counter
		mul $t7, $t4, 4			
		sub $t0, $t0, $t7		#move pointer of $t0 to begining of array
push:
		beq $t6, 9, pushed		#push board onto stack
		lw $t7, 0($t0)			#get element from board
		sw $t7, 0($sp)			#push element on stack
		addi $t0, $t0, 4		#move pointer to next element
		addi $sp, $sp, 4		#push array on stack
		addi $t6, $t6, 1		#increment counter
		j push
pushed:
		addi $t0, $t0, -36
		addi $sp, $sp, -36		#move pointers to beginings of arrays
		mul $t7, $t4, 4
		add $t0, $t0, $t7		#move pointer back to original position
		
		sw $t0, 36($sp)
		sw $t1, 40($sp)
		sw $t2, 44($sp)
		sw $t3, 48($sp)
		sw $t4, 52($sp)
		sw $t5, 56($sp)
		sw $t6, 60($sp)
		sw $t7, 64($sp)
		sw $t8, 68($sp)
		sw $t9, 72($sp)
		sw $ra, 76($sp)			#push elements
		
		add $a0, $t5, $zero
		addi $a1, $t1, 1		#pass arguments
		jal min				#call function
		
		lw $ra, 76($sp)
		lw $t9, 72($sp)
		lw $t8, 68($sp)
		lw $t7, 64($sp)
		lw $t6, 60($sp)
		lw $t5, 56($sp)
		lw $t4, 52($sp)
		lw $t3, 48($sp)
		lw $t2, 44($sp)
		lw $t1, 40($sp)
		lw $t0, 36($sp)
		
		addi $t6, $zero, 9		#initialize counter
		mul $t7, $t4, 4			
		sub $t0, $t0, $t7		#move pointer of $t0 to begining of array
		addi $t0, $t0, 32
		addi $sp, $sp, 32
pop:
		beq $t6, 0, popped		#loop for popping board off of stack
		lw $t7, 0($sp)			#pop element off stack
		sw $t7, 0($t0)			#place element into board
		addi $t0, $t0 -4		#move pointer to previous space
		addi $sp, $sp -4		#push array on stack
		addi $t6, $t6, -1		#decrement counter
		j pop
popped:
		addi $t0, $t0, 4
		addi $sp, $sp, 4		
		mul $t7, $t4, 4
		add $t0, $t0, $t7		#move pointer back to original position
		
		addi $sp, $sp, 80		#de-allocate stack
		
		add $t6, $v0, $zero		#put returned in $t6
		
		ble $t6, $t3, notGreater	#if (x > max)
		add $t3, $t6, $zero		#max = x
		add $t8, $t4, $zero		#maxMove = i
notGreater:		
endIf:	
		addi $t0, $t0, 4		#move pointer to next element
		addi $t4, $t4, 1		#increment counter	
		
		j forLoop
endFor:
		beqz $t1, dep0			#if depth is not 0, return max
		add $v0, $t3, $zero
		jr $ra
dep0:
		add $v0, $t8, $zero		#if depth is 0, return best move
		jr $ra
		


min:
		add $t0, $a0, $zero		#load address of array into $t0
		add $t1, $a1, $zero		#load depth into $t1
		
		addi $sp, $sp, -44		#allocate space on stack
		sw $t0, 0($sp)
		sw $t1, 4($sp)
		sw $t2, 8($sp)
		sw $t3, 12($sp)
		sw $t4, 16($sp)
		sw $t5, 20($sp)
		sw $t6, 24($sp)
		sw $t7, 28($sp)
		sw $t8, 32($sp)
		sw $t9, 36($sp)
		sw $ra, 40($sp)			#push elements
				
		jal gameOver			#check if game is over
		
		lw $ra, 40($sp)
		lw $t9, 36($sp)
		lw $t8, 32($sp)
		lw $t7, 28($sp)
		lw $t6, 24($sp)
		lw $t5, 20($sp)
		lw $t4, 16($sp)
		lw $t3, 12($sp)
		lw $t2, 8($sp)
		lw $t1, 4($sp)
		lw $t0, 0($sp)
		addi $sp, $sp, 44		#de-allocate memory on stack
		
		add $t2, $v0, $zero		#put returned value into $t2 (win/loss state)
		abs $t3, $t2			#take absolute value of returned value for easier comparison
		
		beq $t3, 10, overMin
		beq $t3, 0, overMin
		bgt $t1, $s5, overMin		#if game is over OR depth is larger than max depth
		j notOverMin
overMin:
		add $v0, $t2, $zero		#return win/loss state
		jr $ra
notOverMin:
		addi $t3, $zero, 0		#$t3 = max = infinity
		
		add $t4, $zero, $zero		#initialize counter
forLoopMin:		
		beq $t4, 9, endForMin		#for(i = 0, i < 9, i++)
		
		lw $t5, 0($t0)			#get element from board
		
		bne $t5, 0, endIfMin		#if element is an empty cell
		
		la $t5, cBoard2			#get array space for copied array
		
		add $t6, $zero, $zero		#initialize counter
		mul $t7, $t4, 4			
		sub $t0, $t0, $t7		#move pointer of $t0 to begining of array
copyMin:
		beq $t6, 9, copiedMin		#loop for copying board
		lw $t7, 0($t0)			#get element from board
		sw $t7, 0($t5)			#put element in copy
		addi $t0, $t0, 4		#move pointer to next element
		addi $t5, $t5, 4		#copy array
		addi $t6, $t6, 1		#increment counter
		j copyMin
copiedMin:
		addi $t0, $t0, -36
		addi $t5, $t5, -36		#move pointers to beginings of arrays
		mul $t7, $t4,4
		add $t0, $t0, $t7		#move pointer back to original position
		
		add $t5, $t5, $t7		#move pointer to ith position relative to board
		sw $s2, 0($t5)			#put o in such position
		sub $t5, $t5, $t7		#move pointer back
		
		addi $sp, $sp, -80
		add $t6, $zero, $zero		#initialize counter
		mul $t7, $t4, 4			
		sub $t0, $t0, $t7		#move pointer of $t0 to begining of array
pushMin:
		beq $t6, 9, pushedMin		#loop to push board onto stack
		lw $t7, 0($t0)			#get element from board
		sw $t7, 0($sp)			#push element onto stack
		addi $t0, $t0, 4		#move pointer to next element
		addi $sp, $sp 4			#push array on stack
		addi $t6, $t6, 1		#increment counter
		j pushMin
pushedMin:
		addi $t0, $t0, -36
		addi $sp, $sp, -36		#move pointers to beginings of arrays
		mul $t7, $t4, 4
		add $t0, $t0, $t7		#move pointer back to original position
		
		sw $t0, 36($sp)
		sw $t1, 40($sp)
		sw $t2, 44($sp)
		sw $t3, 48($sp)
		sw $t4, 52($sp)
		sw $t5, 56($sp)
		sw $t6, 60($sp)
		sw $t7, 64($sp)
		sw $t8, 68($sp)
		sw $t9, 72($sp)
		sw $ra, 76($sp)			#push elements
		
		add $a0, $t5, $zero
		addi $a1, $t1, 1		#pass arguments
		jal max				#call function
		
		lw $ra, 76($sp)
		lw $t9, 72($sp)
		lw $t8, 68($sp)
		lw $t7, 64($sp)
		lw $t6, 60($sp)
		lw $t5, 56($sp)
		lw $t4, 52($sp)
		lw $t3, 48($sp)
		lw $t2, 44($sp)
		lw $t1, 40($sp)
		lw $t0, 36($sp)
		
		addi $t6, $zero, 9		#initialize counter
		mul $t7, $t4, 4			
		sub $t0, $t0, $t7		#move pointer of $t0 to begining of array
		addi $t0, $t0, 32
		addi $sp, $sp, 32
popMin:
		beq $t6, 0, poppedMin		#loop for popping board off of stack
		lw $t7, 0($sp)			#pop element off of stack
		sw $t7, 0($t0)			#place element into board
		addi $t0, $t0, -4		#move pointer to previous element
		addi $sp, $sp, -4		#push array on stack
		addi $t6, $t6, -1		#decrement counter
		j popMin
poppedMin:
		addi $t0, $t0, 4
		addi $sp, $sp, 4		
		mul $t7, $t4, 4
		add $t0, $t0, $t7		#move pointer back to original position
		
		addi $sp, $sp, 80		#de-allocate stack
		
		add $t6, $v0, $zero		#put returned in $t6
		
		bge $t6, $t3, notLess		#if (x < min)
		add $t3, $t6, $zero		#min = x
notLess:
endIfMin:
		addi $t0, $t0, 4		#move pointer to next element
		addi $t4, $t4, 1		#increment counter
		
		j forLoopMin
endForMin:

		add $v0, $t3, $zero		#return min
		jr $ra
		

#########################################################################################
###############function above for minimax algorithm######################################
#########################################################################################


####################################################################################
###############function below checks for a game over state/analysis#################
###############Arguments:					   #################
###############  $a0 - address of board				   #################
###############Return:						   #################
###############  $v0 - number indicating win/lose state		   #################
####################################################################################

gameOver:
		la $t1, win			#load address of array with all winning states
		add $t2, $a0, $zero		#load address of board into $t2
		li $t0, 0			#initialize counter
		
		li $t8, 0			#initialize max x counter
		li $t9, 0			#initialize max o counter
		
winGame:
		beq $t0, 8, noWin		#if checked for each win state and none found, computer has not won
		
		li $t5, 0			#initialize/reinitialize x counter
		li $t6, 0			#initialize/reinitialize o counter

firstCheck:
		lw $t3, 0($t1)			#get first position of win position
		addi $t3, $t3, -1		#decrement for correct array position
		mul $t3, $t3, 4			#numbers stored as word (4bytes)
		add $t2, $t2, $t3		#move pointer of board array to first win position
		
		lw $t4, 0($t2)			#get what's stored in board
		
		sub $t2, $t2, $t3		#move pointer of board back to first position
		
		bne $t4, 1, noX1
		addi $t5, $t5, 1		#found x
noX1:

		bne $t4, 2, noO1
		addi $t6, $t6, 1		#found o
noO1:

secondCheck:
		lw $t3, 4($t1)			#get second position of win position
		addi $t3, $t3, -1		#decrement for correct array position
		mul $t3, $t3, 4			#numbers stored as word (4bytes)
		add $t2, $t2, $t3		#move pointer of board array to first win position
		
		lw $t4, 0($t2)			#get what's stored in board
		
		sub $t2, $t2, $t3		#move pointer of board back to first position
		
		bne $t4, 1, noX2
		addi $t5, $t5, 1		#found x
noX2:

		bne $t4, 2, noO2
		addi $t6, $t6, 1		#found o
noO2:

thirdCheck:
		lw $t3, 8($t1)			#get third position of win position
		addi $t3, $t3, -1		#decrement for correct array position
		mul $t3, $t3, 4			#numbers stored as word (4bytes)
		add $t2, $t2, $t3		#move pointer of board array to first win position
		
		lw $t4, 0($t2)			#get what's stored in board
		
		sub $t2, $t2, $t3		#move pointer of board back to first position
		
		bne $t4, 1, noX3
		addi $t5, $t5, 1		#found x
noX3:

		bne $t4, 2, noO3
		addi $t6, $t6, 1		#found o
noO3:

		bne $t5, 3, xNoWin
		li $v0, 10			#return 10 if x wins
		jr $ra
xNoWin:

		bne $t6, 3, oNoWin
		li $v0, -10			#return -10 if o wins
		jr $ra
oNoWin:
		
		add $t1, $t1, 12		#move pointer to next triple of position wins
		addi $t0, $t0, 1		#increment counter
		
		j winGame

noWin:

tieGame:
		li $t0, 0			#reinitialize counter
		
tieCheck:
		beq $t0, 9, tie			#if all spaces have plays in them, there is a tie.  If not, game not over.
		
		lw $t3, 0($t2)			#get element on board

		beqz $t3, notATie
		
		addi $t2, $t2, 4		#move pointer to next element in array
		addi $t0, $t0, 1		#increment counter
		
		j tieCheck

tie:
		li $v0, 0			#return 0 if there is a tie
		jr $ra

notATie:
		la $t1, win			#load address of array with all winning states
		add $t2, $a0, $zero		#load address of board into $t2
		li $t0, 0			#initialize counter
		
		li $s6, 0			#initialize points counter
		li $s7, 0			#initialize points counter
		
undone:
		beq $t0, 8, checked		#if checked for each win state and none found, computer has not won
		
		li $t5, 0			#initialize/reinitialize x counter
		li $t6, 0			#initialize/reinitialize o counter

firstCheckT:
		lw $t3, 0($t1)			#get first position of win position
		addi $t3, $t3, -1		#decrement for correct array position
		mul $t3, $t3, 4			#numbers stored as word (4bytes)
		add $t2, $t2, $t3		#move pointer of board array to first win position
		
		lw $t4, 0($t2)			#get what's stored in board
		
		sub $t2, $t2, $t3		#move pointer of board back to first position
		
		bne $t4, 1, noX1T
		addi $t5, $t5, 1		#found x
noX1T:

		bne $t4, 2, noO1T
		addi $t6, $t6, 1		#found o
noO1T:

secondCheckT:
		lw $t3, 4($t1)			#get second position of win position
		addi $t3, $t3, -1		#decrement for correct array position
		mul $t3, $t3, 4			#numbers stored as word (4bytes)
		add $t2, $t2, $t3		#move pointer of board array to first win position
		
		lw $t4, 0($t2)			#get what's stored in board
		
		sub $t2, $t2, $t3		#move pointer of board back to first position
		
		bne $t4, 1, noX2T
		addi $t5, $t5, 1		#found x
noX2T:

		bne $t4, 2, noO2T
		addi $t6, $t6, 1		#found o
noO2T:

thirdCheckT:
		lw $t3, 8($t1)			#get third position of win position
		addi $t3, $t3, -1		#decrement for correct array position
		mul $t3, $t3, 4			#numbers stored as word (4bytes)
		add $t2, $t2, $t3		#move pointer of board array to first win position
		
		lw $t4, 0($t2)			#get what's stored in board
		
		sub $t2, $t2, $t3		#move pointer of board back to first position
		
		bne $t4, 1, noX3T
		addi $t5, $t5, 1		#found x
noX3T:

		bne $t4, 2, noO3T
		addi $t6, $t6, 1		#found o
noO3T:

		mul $t8, $t5, $t6		#multiply counts together
		add $t9, $t5, $t6		#add counts together
		
		bnez $t8, prodNot0
		bne $t9, 2, sumNot2		#if product is 0 and sum is 2, then...
		bne $t5, 2, not2X		#if there are 2 x's in a row with no o, return 7
		addi $v0, $zero, 7
		jr $ra
not2X:
		bne $t6, 2, sumNot2		#if there are 2 o's in a row with no x, return -7
		addi $v0, $zero, -9
		jr $ra 
sumNot2:
		bne $t9, 1, prodNot0
		bne $t5, 1, not1X		#if there is one alone x in R or C, store possible return value
		addi $s6, $zero, 5
		j prodNot0
not1X:
		bne $t6, 1, prodNot0		#if there is one alone o in R or C, store possible return value
		addi $s6, $zero, -5		
prodNot0:
		
		bne $t8, 1, prodNot1		#if there is one x and one o in R or C, store possible return value
		addi $s7, $zero, 1
prodNot1:					
		bne $t9, 3, notSum3		#if row is filled in R or C, store possible return value
		addi $s7, $zero, 1
notSum3:						
																	
		add $t1, $t1, 12		#move pointer to next triple of position wins
		addi $t0, $t0, 1		#increment counter
		
		j undone

checked:

		beqz $s6, lowerPoints		#if higher points situation found, return that, otherwise, return lower point situation
		add $v0, $zero, $s6
		jr $ra
lowerPoints:
		add $v0, $zero, $s7
		jr $ra

################################################################################
###############function above checks for a game over state######################
################################################################################



##################################################################################
###############function below displays current state of board#####################
###############Arguments:				     #####################
###############  $a0 - address of board			     #####################
##################################################################################

displayBoard:
		add $t0, $a0, $zero		#load address of board into $t0
		li $t1, 0			#initiate counter
		
disWhile:
		beq $t1, 9, disWhileDone	#while there still exists possible entries
		
		lb $t2, 0($t0)			#get first entry in cell
		 
		bne $t1, 3, not4
		li $v0, 4
		la $a0, row
		syscall				#display row seperation if at 4th entry
not4:
		bne $t1, 6, not7
		li $v0, 4
		la $a0, row
		syscall				#display row seperation if at 7th entry
not7:
		bne $t1, 1, not2
		li $v0, 4
		la $a0, sep
		syscall				#display cell seperation
not2:		
		bne $t1, 2, not3
		li $v0, 4
		la $a0, sep
		syscall				#display cell seperation
not3:
		bne $t1, 4, not5
		li $v0, 4
		la $a0, sep
		syscall				#display cell seperation
not5:	
		bne $t1, 5, not6
		li $v0, 4
		la $a0, sep
		syscall				#display cell seperation
not6:
		bne $t1, 7, not8
		li $v0, 4
		la $a0, sep
		syscall				#displaycell seperation
not8:		
		bne $t1, 8, not9
		li $v0, 4
		la $a0, sep
		syscall				#display cell seperation
not9:
		bne $t2, 0, notEmpt
		li $v0, 4
		la $a0, empty
		syscall				#display empty cell
notEmpt:
		bne $t2, 1, notX
		li $v0, 4
		la $a0, x
		syscall				#display X
notX:
		bne $t2, 2, notO
		li $v0, 4
		la $a0, o
		syscall				#display O
notO:		

		addi $t0, $t0, 4		#move pointer to next element in grid
		addi $t1, $t1, 1		#increment counter

		j disWhile			#jump to while loop

disWhileDone:

		li $v0, 4
		la $a0, nlnl
		syscall				#display newline

		jr $ra				#return to function		

##################################################################################
###############function above displays current state of board#####################
##################################################################################

exit:
		nop