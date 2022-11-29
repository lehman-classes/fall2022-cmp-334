.data

.text
	li $s3, 4294967295 
	li $s2, 1 

	# assuming the value for b is at register @s3 and the value for c is at register $s2
	# a = b + c 
	add $s0, $s3, $s2
	
	# assuming the value for d is at register @s7 and the value for e is at register $s6	
	# a = b + c + d + e
	add $s0, $s3, $s2
	add $s0, $s0, $s7
	add $s0, $s0, $s6
	
	
	
	 
	
exit:
	li $v0, 10
	syscall
	