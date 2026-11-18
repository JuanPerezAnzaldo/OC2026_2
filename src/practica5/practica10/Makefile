
build:
	gcc -m32 -c main.c
	nasm -f elf -I ../../../lib/ p10.asm
	gcc -m32 p10.o main.o -L ../../../lib -lpc_io -no-pie -z noexecstack -o ../../../bin/practica10.exe
run:
	./../../../bin/practica10.exe
 