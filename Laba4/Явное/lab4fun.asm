.386
.model flat
	public PadCh
.code
start: ;процедура входа dll, в данном случае – пустая
;заглушка
 mov al,1 ; надо вернуть ненулевое число в EAX
 ret 12
		
PadCh proc
; адреса параметров в стеке:
S equ dword ptr [ebp+8]; адрес строки S
Res equ dword ptr [ebp+12]; адрес строки результата
							
	push ebp ; сохранение bp
	mov ebp,esp ; настройка bp на вершину стека
	mov edi,Res ; es:di:=адрес результата
	mov esi,S ; ds:si:=адрес исходной строки
	cld; очистка флага направления (инкремент)
	lodsb; al:=(ds:[si]), si:=si+1 (al - длина S)
	stosb; (es:[di]):=al, di:=di+1 (запись длины)
	mov ecx,0; подготовка сх в качестве счетчика
    mov   cl,al; количества символов строки S
    jcxz  CopyChStr ; если S - пустая строка (сх=0)         
    push ecx ;Сохраняем значение длины строки   
    rep movsb ; Копируем строку cx:=cx-1, si:=si+1 и di:=di+1
    pop ecx; Получаем длину строки      
    sub cl, 12 ;Находим разницу повторений
	cmp cl, 0
	jge Exit	
	neg cl
    jmp CopyStr
; Заполням строку символ С
CopyChStr:        
    mov cl, 12
CopyStr:   
    mov al, 's' ; записываем символ, которым будем заполнять строку 
    rep  stosb ; заполняем строку символами cx:=cx-1 и di:=di+1
    mov al, 12
    mov edi, dword ptr[ebp+12] ; возвращаем индекс к началу строки
    stosb ; записываем длину и смещаемся di:=di+1
Exit:   
    pop   ebp      ; восстановить bp
    ret 8; выход с удалением параметров Ch1,Ch2 и адреса S (Res удалять нельзя!)
PadCh endp
 end start
