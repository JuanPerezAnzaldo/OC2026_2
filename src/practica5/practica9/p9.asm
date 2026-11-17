%include "../../../lib/pc_io.inc"

%macro PROTOENTRADA 0
	push ebp
	mov ebp,esp
%endmacro

%macro PROTOSALIDA 0
	mov esp,ebp
	pop ebp
%endmacro

%macro WHILE 2
	.ciclo:
		cmp esi, ecx
		jl .cuerpo
		jmp .fin
	.cuerpo:
		mov edx, dword[ebx+esi*4]
		mov eax, dword[ebp-4]
		cmp edx, eax
		%1 .cambio; jl min, jg max, jmp suma
		jmp .incremento
	.cambio:
		mov edx, dword[ebx+esi*4]
		%2 dword[ebp-4], edx ;mov min/max, add sumatoria
		jmp .incremento
	.incremento:
		inc esi
		jmp .ciclo
	.fin:
%endmacro

section .text
	global _startd
	global _imprimir
	global _minimo
	global _maximo
	global _sumatoria

_startd:
	mov eax, 1
	int 0x80

_imprimir:
	push ebp
	mov ebp, esp
	sub esp, 4
	mov dword[ebp-4], msg3
	mov edx, [ebp-4]
	call puts
	mov edx, [ebp+8]
	call puts
	mov edx, [ebp+12]
	call puts
	mov esp, ebp
	pop ebp
	ret

_minimo:
	PROTOENTRADA
	sub esp, 4
	push ebx
	push ecx
	push edx
	push esi
	mov ebx, dword[ebp+8];arreglo
	mov ecx, dword[ebp+12];len
	mov edx, dword[ebx];arreglo[0]
	mov dword[ebp-4], edx;min=arreglo[0]
	mov esi, 0;i = 0

	WHILE jl, mov

	pop esi
	pop edx
	pop ecx
	pop ebx
	mov eax, dword[ebp-4]
	add esp, 4
	PROTOSALIDA
	ret

_maximo:
	PROTOENTRADA
	sub esp, 4
	push ebx
	push ecx
	push edx
	push esi
	mov ebx, dword[ebp+8];arreglo
	mov ecx, dword[ebp+12];len
	mov edx, dword[ebx];arreglo[0]
	mov dword[ebp-4], edx;max=arreglo[0]
	mov esi, 0;i = 0

	WHILE jg, mov;

	pop esi
	pop edx
	pop ecx
	pop ebx
	mov eax, dword[ebp-4]
	add esp, 4
	PROTOSALIDA
	ret

_sumatoria:
	PROTOENTRADA
	sub esp, 4
	push ebx
	push ecx
	push edx
	push esi
	mov ebx, dword[ebp+8];arreglo
	mov ecx, dword[ebp+12];len
	mov dword[ebp-4], 0;suma = 0
	mov esi, 0;i = 0

	WHILE jmp, add

	pop esi
	pop edx
	pop ecx
	pop ebx
	mov eax, dword[ebp-4]
	add esp, 4
	PROTOSALIDA
	ret

section .data
	msg1 db 'Hola mundo',0xa,0
	msg2 db 'OC',0xa,0
	msg3 db 'Practica 9',0xa,0
	x db 1
	y db 2