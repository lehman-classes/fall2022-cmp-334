.section .text

.global __start

__start:
  ; STDIN = 0
  ; STDOUT = 1
  ; STDERR = 2

# syscall table MIPS_o32
# https://syscalls.w3challs.com/?arch=mips_o32
# 
# linux setup
# sudo apt install gcc-mips-linux-gnu
# sudo apt install qemu
# sudo apt install qemu-user
#
# steps to run
# 1. assembler - $ mips-linux-gnu-as hello.s -o hello.o
# 2. compiler -  $ mips-linux-gnu-gcc hello.o -o hello -nostdlib -static
# 3. run -       $ qemu-mips ./hello


# 0011 1010 0101 0000 0000 0101 0100 0000
  li $v0, 4004
#
  
  li $a0, 1
  la $a1, msg
  li $a2, 13
  syscall

  li $v0, 4001
  li $a0, 13
  syscall


.section .data

msg:
.asciz "Hello World!\n"

