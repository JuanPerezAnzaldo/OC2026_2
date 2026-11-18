
%macro PROTOENTRADA 0
	push ebp
	mov ebp,esp
%endmacro
 
%macro PROTOSALIDA 0
	mov esp,ebp
	pop ebp
%endmacro
 
%macro BIT 1
	push ecx
	mov cl, byte[ebp+12];bit
	and cl, 7
	%1 al, cl;shl setbit, shr getbit
	pop ecx
%endmacro
 
 
section	.text
    global _setbit
    global _getbit
 
    _setbit:
        PROTOENTRADA
		push ebx
		mov ebx, dword[ebp+8];value
		mov al, 1
 
		BIT shl
 
		or byte[ebx], al
		pop ebx
		PROTOSALIDA
		ret
 
    _getbit:
        PROTOENTRADA
		mov eax, 0
		mov al, byte[ebp+8];value
 
		BIT shr
 
		and eax, 1;0 o 1
		PROTOSALIDA
		ret
 