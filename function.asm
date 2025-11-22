%include 'in_out.asm'

section .data
msg_x db "Введите x: ",0
msg_a db "Введите a: ",0
msg_result db "Результат f(x): ",0

section .bss
x resb 10
a resb 10
result resb 10

section .text
global _start
_start:
    ; --- Ввод x
    mov eax, msg_x
    call sprint
    mov ecx, x
    mov edx, 10
    call sread
    
    ; --- Преобразование x в число
    mov eax, x
    call atoi
    mov [x], eax
    
    ; --- Ввод a  
    mov eax, msg_a
    call sprint
    mov ecx, a
    mov edx, 10
    call sread
    
    ; --- Преобразование a в число
    mov eax, a
    call atoi
    mov [a], eax
    
    ; --- Вычисление f(x)
    mov ebx, [x]    ; ebx = x
    mov ecx, [a]    ; ecx = a
    
    ; --- Сравниваем x и a
    cmp ebx, ecx
    jge else_case
    
    ; --- Если x < a: f(x) = 2a - x
    mov eax, ecx    ; eax = a
    add eax, eax    ; eax = 2a (using addition instead of multiplication)
    sub eax, ebx    ; eax = 2a - x
    jmp output
    
else_case:
    ; --- Если x ≥ a: f(x) = 8
    mov eax, 8
    
output:
    mov [result], eax
    mov eax, msg_result
    call sprint
    mov eax, [result]
    call iprintLF
    call quit
