%include "../../../lib/pc_io.inc"

bskey equ 0x7F

section .text
    global _start

_start:
    mov edx, msg
    call puts

    mov edx, cadena
    mov ax, lenCad
    call capturar

    mov edx, cadena
    call atoi

    mov edx, cadenaNum
    mov ecx, lenCad
    add eax, 33
    call itoa

    mov edx, msgNum
    call puts

    mov edx, cadenaNum
    call puts

    mov al, 0x0A
    call putchar

    ; --- FIN DE PROGRAMA ---
    mov eax, 1
    xor ebx, ebx
    int 0x80


    atoi:
        push ebx
        push ecx
        push edx
        push esi

        mov esi, edx
        xor eax, eax
        xor ecx, ecx

        .espacios:
            mov bl, [esi]
            cmp bl, ' '
            je .sigEspacio
            cmp bl, 0x09
            je .sigEspacio
            jmp .signo

        .sigEspacio:
            inc esi
            jmp .espacios

        .signo:
            cmp bl, '-'
            jne .mas
            mov ecx, 1
            inc esi
            jmp .digitos

        .mas:
            cmp bl, '+'
            jne .digitos
            inc esi

        .digitos:
            movzx ebx, byte [esi]
            cmp bl, '0'
            jb .aplicarSigno
            cmp bl, '9'
            ja .aplicarSigno

            sub bl, '0'
            imul eax, eax, 10
            add eax, ebx
            inc esi
            jmp .digitos

        .aplicarSigno:
            cmp ecx, 1
            jne .fin
            neg eax

        .fin:
            pop esi
            pop edx
            pop ecx
            pop ebx
    ret


    itoa:
        push ebx
        push ecx
        push edx
        push esi
        push edi

        mov edi, edx
        mov esi, edx
        xor ebx, ebx

        cmp eax, 0
        jne .esNegativo
        mov byte [edi], '0'
        inc edi
        jmp .finCad

        .esNegativo:
            cmp eax, 0
            jge .extraer
            mov byte [edi], '-'
            inc edi
            neg eax

        .extraer:
            mov ecx, 10

        .dividir:
            cmp eax, 0
            je .sacarPila
            xor edx, edx
            div ecx
            add dl, '0'
            push edx
            inc ebx
            jmp .dividir

        .sacarPila:
            cmp ebx, 0
            je .finCad
            pop edx
            mov [edi], dl
            inc edi
            dec ebx
            jmp .sacarPila

        .finCad:
            mov byte [edi], 0
            mov eax, esi

            pop edi
            pop esi
            pop edx
            pop ecx
            pop ebx
    ret
    
capturar:
        push eax
        push ebx
        push ecx
        push edx

        mov ebx, edx
        movzx ecx, ax
        dec ecx

        .leer:
            call getch

            cmp al, 0x0D
            je .fin
            cmp al, 0x0A
            je .fin

            cmp al, bskey
            jne .esCaracter
            cmp edx, ebx
            jbe .leer

            dec edx
            call borrar
            jmp .leer

        .esCaracter:
            push eax
            mov eax, edx
            sub eax, ebx
            cmp eax, ecx
            pop eax
            jae .leer

            mov [edx], al
            inc edx
            call putchar
            jmp .leer

        .fin:
            mov byte [edx], 0

            mov al, 0x0A
            call putchar

            pop edx
            pop ecx
            pop ebx
            pop eax
    ret

    borrar:
        push eax
        mov al, 0x08
        call putchar
        mov al, ' ' 
        call putchar
        mov al, 0x08
        call putchar
        pop eax
    ret


section .data
    lenCad  equ 64
    msg     db "cadena: ", 0
    msgNum  db "numero: ", 0

section .bss
    cadena      resb 64
    cadenaNum   resb 64

