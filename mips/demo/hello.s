.data
hello:  .asciiz "Hello World!\n"

.text
main:
  li  $v0, 4      # load immediate, v0 = 4 (4 is print string system call)
  la  $a0, hello  # load address of string to print into a0
  syscall

  li  $v0, 10     # exit syscall
  syscall
