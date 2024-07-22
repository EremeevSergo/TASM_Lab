code segment
	assume cs:code,ds:code
	extrn PadCh:far ; описание внешней far-процедуры
	
Res db 20 dup(?) ; строка результата	
S db 4, 'Fife', 248 dup(?) ; исходная строка

start: mov ax, cs; настройка сегмента данных
	mov ds,ax ; на сегмент кода
	push ds; сегмент строки результата Res
	mov ax, offset Res
	push ax; смещение Res
	push ds; сегмент исходной строки S
	mov ax, offset S
	push ax; смещение S
	mov al, 'X'; параметр Ch1
	push ax
	mov al, 10; параметр Len 
	push ax
	call PadCh ; far-вызов Change
	; чтение адреса результата функции Change из стека
	pop bx ; bx:=смещение Res
	pop ds ; ds:=сегмент Res
	mov ch, 0; подготовка в сх длины
	; строки Res
	mov cl, [bx]
	jcxz Exit; выход, если строка Res пуста
Write: inc bx; продвижение указателя символа bx:=bx+1
	mov dl, [bx]; dl:=очередной символ Res
	mov ah, 2; вывод символа из dl
	int 21h ; на экран средствами DOS
	loop Write; цикл по длине строки Res
Exit: mov ax, 4c00h; завершение программы
	int 21h ; чеpез функцию DOS
code ends
end start