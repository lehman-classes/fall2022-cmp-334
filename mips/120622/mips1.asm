
.data

hello: .asciiz "Aello"

data: .space 20

.text

	la $t0, hello
	lb $t1, 0($t0)
	lb $t2, 1($t0)
	lb $t3, 2($t0)
	lb $t4, 3($t0)
	
	
	sb $t1, data
	