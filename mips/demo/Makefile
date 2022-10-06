all: clang mips mips-qemu

clang:
	gcc -o hello hello.c

mips:
	mars hello.s

mips-qemu:
	mips-linux-gnu-gcc -o mips-hello hello.c -static
