; in_out.asm
; Assembly library for input/output operations

section .text

; -------------------------------------------
; String length calculation
; eax = pointer to string
; returns: eax = length
; -------------------------------------------
slen:
    push    ebx
    mov     ebx, eax

.next:
    cmp     byte [eax], 0
    jz      .finished
    inc     eax
    jmp     .next

.finished:
    sub     eax, ebx
    pop     ebx
    ret

; -------------------------------------------
; String print
; eax = pointer to string
; -------------------------------------------
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen

    mov     edx, eax
    pop     eax

    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     80h

    pop     ebx
    pop     ecx
    pop     edx
    ret

; -------------------------------------------
; String print with line feed
; eax = pointer to string
; -------------------------------------------
sprintLF:
    call    sprint

    push    eax
    mov     eax, 0Ah
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax
    pop     eax
    ret

; -------------------------------------------
; String input
; ecx = buffer, edx = buffer length
; -------------------------------------------
sread:
    push    eax
    push    ebx
    mov     eax, 3
    mov     ebx, 0
    int     80h
    pop     ebx
    pop     eax
    ret

; -------------------------------------------
; Integer print (positive)
; eax = number to print
; -------------------------------------------
iprint:
    push    eax
    push    ecx
    push    edx
    push    esi
    mov     ecx, 0

.divide:
    inc     ecx
    mov     edx, 0
    mov     esi, 10
    idiv    esi
    add     edx, 48
    push    edx
    cmp     eax, 0
    jnz     .divide

.print:
    dec     ecx
    mov     eax, esp
    call    sprint
    pop     eax
    cmp     ecx, 0
    jnz     .print

    pop     esi
    pop     edx
    pop     ecx
    pop     eax
    ret

; -------------------------------------------
; Integer print with line feed
; eax = number to print
; -------------------------------------------
iprintLF:
    call    iprint

    push    eax
    mov     eax, 0Ah
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax
    pop     eax
    ret

; -------------------------------------------
; ASCII to integer conversion
; eax = pointer to string
; returns: eax = number
; -------------------------------------------
atoi:
    push    ebx
    push    ecx
    push    edx
    push    esi
    mov     esi, eax
    mov     eax, 0
    mov     ecx, 0

.multiply:
    xor     ebx, ebx
    mov     bl, [esi+ecx]
    cmp     bl, 48
    jl      .finished
    cmp     bl, 57
    jg      .finished

    sub     bl, 48
    add     eax, ebx
    mov     ebx, 10
    mul     ebx
    inc     ecx
    jmp     .multiply

.finished:
    mov     ebx, 10
    div     ebx
    pop     esi
    pop     edx
    pop     ecx
    pop     ebx
    ret

; -------------------------------------------
; Exit program
; -------------------------------------------
quit:
    mov     ebx, 0
    mov     eax, 1
    int     80h
    ret
