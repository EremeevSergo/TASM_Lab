includelib import32.lib
	extrn LoadLibraryA:near
	extrn GetProcAddress:near
	extrn MessageBoxA:near
	extrn ExitProcess:near

.386
.model flat,stdcall
.data
	S db 6,"String",0
	Res db 128 dup(0)
	PadCh dd 0
	libr db 'lab4fun.dll',0
	nameproc db 'PadCh',0
	hlib dd 0

.code
start:
	call LoadLibraryA,offset libr ;загрузка библиотеки
	mov hlib,eax
	call GetProcAddress,hlib,offset nameproc ;получение адреса функции
	mov PadCh,eax
	mov eax, offset Res
	push eax; смещение Res
	mov eax, offset S
	push eax; смещение S

	call PadCh 

	call MessageBoxA,0,offset Res+1,offset S+1,0
	call ExitProcess,0 ; конец программы

end start