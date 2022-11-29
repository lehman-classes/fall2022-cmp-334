# adder.asm
#
# The following program initializes an array of 10 elements and computes 
# a running sum of all elements in the array. The program prints the sum
# of all the entries in the array.

.data
message:    .asciiz "The sum of numbers in array is: "
array:      .word   0:10         # array of 10 words
array_size: .word   10           # size of array

.text
main:
        la   $a0, array          # load address of array
        la   $a1, array_size     # load address of array_size
        lw   $a1, 0($a1)         # load value of array_size variable
loop:
        sll  $t1, $t0, 2         # t1 = (i * 4)
        add  $t2, $a0, $t1       # t2 contains address of array[i]
        sw   $t0, 0($t2)         # array[i] = i
        addi $t0, $t0, 1         # i = i+1
        add  $t4, $t4, $t0       # sum($t4) = ($t4 + array[i])
        slt  $t3, $t0, $a1       # $t3 = ( i < array_size)
        bne  $t3, $zero, loop    # if ( i < array_size ) then loop

        li   $v0, 4              # system call to print string
        la   $a0, message        # load address of message into arg register
        syscall                  # make call
        
        li   $v0, 1              # system call to print an integer
        or   $a0, $t4, $zero     # load value to print into arg register
        syscall                  # make call

        li   $v0, 10             # system call to terminate program
        syscall                  # make call