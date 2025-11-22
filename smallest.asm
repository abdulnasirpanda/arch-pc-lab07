%include 'in_out.asm'

section .data
msg db "Наименьшее число: ",0
a dd 17
b dd 23  
c dd 45

section .bss
min resb 10

section .text
global _start
_start:
    ; --- Записываем 'a' в переменную 'min'
    mov ecx, [a]
    mov [min], ecx
    
    ; --- Сравниваем 'min' и 'b'
    cmp ecx, [b]
    jl check_c
    mov ecx, [b]
    mov [min], ecx
    
check_c:
    ; --- Сравниваем 'min' и 'c'
    mov ecx, [min]
    cmp ecx, [c]
    jl finish
    mov ecx, [c]
    mov [min], ecx
    
finish:
    mov eax, msg
    call sprint
    mov eax, [min]
    call iprintLF
    call quit
