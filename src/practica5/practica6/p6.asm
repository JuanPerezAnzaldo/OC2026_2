%include "../../../lib/pc_io.inc"  ; incluir declaraciones de procedimiento externos

bskey equ 0x7F

section .text
    global _start

_start:
mov edx, msg
    call puts

    mov edx, cadena
    mov ax, lenCad
    call capturar

    mov edx, msgMay
    call puts

    mov edx, cadena
    call convertirMayusculas

    mov edx, cadena
    call puts

    mov edx, msgMin
    call puts

    mov edx, cadena
    call convertirMinusculas

    mov edx, cadena
    call puts

    ; --- FIN DE PROGRAMA ---
    mov eax, 1             ; Syscall exit
    xor ebx, ebx           ; Return 0
    int 0x80               ; Interrupción Linux 32-bit


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

    convertirMayusculas:
        push edx
        push eax

        .comp:
            mov al, [edx]
            cmp al, 0
            je .fin

            cmp al, 'a'
            jb .sig
            cmp al, 'z'
            ja .sig

            sub al, 0x20
            mov [edx], al

        .sig:
            inc edx
            jmp .comp

        .fin:
            pop eax
            pop edx
    ret

    convertirMinusculas:
        push edx
        push eax

        .comp:
            mov al, [edx]
            cmp al, 0
            je .fin

            cmp al, 'A'
            jb .sig
            cmp al, 'Z'
            ja .sig

            add al, 0x20
            mov [edx], al

        .sig:
            inc edx
            jmp .comp

        .fin:
            pop eax
            pop edx
    ret


    ;fin
    mov eax, 1
    xor ebx, ebx
    int 0x80

section .data
    lenCad  equ 255
    msg     db "Ingrese una cadena: ", 0
    msgMay  db "mayusculas: ", 0
    msgMin  db 0x0A,"minusculas: ", 0

section .bss
    cadena  resb 255

