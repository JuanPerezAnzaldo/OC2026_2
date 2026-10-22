extern canonical_off
extern canonical_on

bskey equ 0x7F

section .text
    global _start

_start:
    call miGetche
    call miGetche
    call miGetche
    
    mov al, 0x0A
    call miPutchar

    call miGetch
    call miGetch
    call miGetch

    mov al, 0x0A
    call miPutchar


    mov edx, msg
    call miPuts

    mov edx, cadena
    mov ax, lenCad
    call capturar

    mov edx, msgMay
    call miPuts

    mov edx, cadena
    call convertirMayusculas

    mov edx, cadena
    call miPuts

    mov edx, msgMin
    call miPuts

    mov edx, cadena
    call convertirMinusculas

    mov edx, cadena
    call miPuts
                
    mov al, 0x0A
    call miPutchar

    ; --- FIN DE PROGRAMA ---
    mov eax, 1
    xor ebx, ebx
    int 0x80

    capturar:
        push eax
        push ebx
        push ecx
        push edx

        mov ebx, edx
        movzx ecx, ax
        dec ecx

        .leer:
            call miGetch

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
            call miPutchar
            jmp .leer

        .fin:
            mov byte [edx], 0

            mov al, 0x0A
            call miPutchar

            pop edx
            pop ecx
            pop ebx
            pop eax
    ret

    borrar:
        push eax
        mov al, 0x08
        call miPutchar
        mov al, ' ' 
        call miPutchar
        mov al, 0x08
        call miPutchar
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

    miPutchar:
        push eax
        push ebx
        push ecx
        push edx

        push eax
        mov eax, 4
        mov ebx, 1
        mov ecx, esp
        mov edx, 1
        int 0x80
        pop eax

        pop edx
        pop ecx
        pop ebx
        pop eax
    ret

    miPuts:
        push eax
        push edx

        .imprimir:
            mov al, [edx]
            cmp al, 0
            je .fin
            
            call miPutchar
            inc edx
            jmp .imprimir

        .fin:
            pop edx
            pop eax
    ret 

    miGetch:
        push ebx
        push ecx
        push edx

        call canonical_off
        push eax
        mov eax, 3
        mov ebx, 0
        mov ecx, esp
        mov edx, 1
        int 0x80 
        pop eax
        call canonical_on

        pop edx
        pop ecx
        pop ebx
    ret

    miGetche:
        call miGetch        
        call miPutchar
    ret

    
section .data
    lenCad  equ 255
    msg     db "cadena: ", 0
    msgMay  db "mayusculas: ", 0
    msgMin  db 0x0A,"minusculas: ", 0

section .bss
    cadena  resb 255