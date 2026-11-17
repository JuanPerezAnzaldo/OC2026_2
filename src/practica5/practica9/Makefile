build:
	nasm -f elf -I ../../../lib/ p9.asm
	ld -m elf_i386 p9.o -o ../../../bin/practica9.exe ../../../lib/libpc_io.a

	gcc -m32 -c main.c
	gcc -m32 p9.o main.o -L ../../../lib -lpc_io -no-pie -z noexecstack -o ../../../bin/practica9c.exe
run:
	./../../../bin/practica9.exe
runc:
	./../../../bin/practica9c.exe