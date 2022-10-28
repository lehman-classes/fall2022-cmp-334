# Going from higher level language like Java to assembly
# 
# conditional statements
# if (a > b) {...} else {...}

# loops
# for, while, do-while

.data
# a: .byte 00000010
# b: .byte 00001000
ifmsg: .asciiz "greater than"
elsemsg: .asciiz "less than"

.text
	li $t0, 8 # a
	li $t1, 2 # b
	
	bgt $t0 $t1, if
else:
	li $v0, 4
	la $a0, elsemsg
	syscall
	b exit
if:
	li $v0, 4
	la $a0, ifmsg
	syscall

	# loading a single byte into a 4 byte register
	# lb $t1, a
	# lb $t2, b
	

exit:
	li $v0, 10
	syscall
