code segment byte public
	assume  cs:code,ds:code
    public  PadCh

PadCh   proc far  
; адреса параметров в стеке:
Len     equ  byte ptr [bp+6]  ;  адрес параметра Len:Byte
Ch1     equ  byte ptr [bp+8]  ;  адрес параметра Сh1 :Char
S       equ  dword ptr [bp+10];  адрес строки S:string
Res     equ  dword ptr [bp+14];  адрес строки результата
        push  bp      ; сохранение bp
        mov   bp,sp   ; настройка bp на вершину стека
        push  ds      ; сохранение ds
        les   di,Res  ; es:di:=адрес результата
        lds   si,S    ; ds:si:=адрес исходной строки
        cld ; очистка флага направления (инкремент)
        lodsb ; al:=(ds:[si]), si:=si+1 (al - длина S)
        stosb ; (es:[di]):=al, di:=di+1 (запись длины)
        mov   ch,0; подготовка сх в качестве счетчика
        mov   cl,al; количества символов строки S
        jcxz  CopyChStr ; если S - пустая строка (сх=0)         
        push cx ;Сохраняем значение длины строки   
        rep movsb ; Копируем строку cx:=cx-1, si:=si+1 и di:=di+1
        pop cx; Получаем длину строки      
        sub cl, Len ;Находим разницу повторений 
		cmp cl,0
		jge Exit		
        neg cl
        jmp CopyStr
; Заполням строку символ С
CopyChStr:        
        mov cl, Len
CopyStr:   
        mov al, Ch1 ; записываем символ, которым будем заполнять строку 
        rep  stosb ; заполняем строку символами cx:=cx-1 и di:=di+1
        mov al, Len ; записываем длину строки
        mov di, word ptr[bp+14] ; возвращаем индекс к началу строки
        stosb ; записываем длину и смещаемся di:=di+1
Exit:   pop   ds      ; восстановить ds
        pop   bp      ; восстановить bp
        ret 8; выход с удалением параметров Ch1,Ch2 и адреса S (Res удалять нельзя!)
PadCh  endp
code   ends
       end