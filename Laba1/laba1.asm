Myif macro i, neg_label, zer_label, pos_label
    cmp i, 0       ; Сравниваем число с нулем
    jl neg_label   ; Если число меньше нуля, переходим к метке NEG
    jz zer_label   ; Если число равно нулю, переходим к метке ZER
    jmp pos_label  ; Если число больше нуля, переходим к метке POS
endm

sseg segment stack 'stack'
    dw 256 dup(?)
sseg ends

data segment
    x db -2    ; Здесь хранится введенное число
    neg_msg db 10,13,' x < 0','$'
    zer_msg db 10,13,'x = 0','$'
    pos_msg db 10,13,'x > 0','$'
    
data ends

code segment
    assume cs:code, ds:data, ss:sseg

start:
    mov ax, data  ; Настройка сегментного регистра DS на данные
    mov ds, ax

    ; Вводим число (в данном коде предполагается, что число уже введено и хранится в переменной x)

    Myif x, neg, zer, pos
    jmp exit

neg:
    mov dx, offset neg_msg
    jmp exit

zer:
    mov dx, offset zer_msg
    jmp exit

pos:
    mov dx, offset pos_msg
    jmp exit

exit:
    mov ah, 9
    int 21h

    mov ah, 4ch
    int 21h
code ends
end start