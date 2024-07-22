includelib import32.lib
	extrn MessageBoxA:near
	extrn ExitProcess:near
includelib lab4fun.lib	
	extrn PadCh:near

.386
.model flat,stdcall
.data
	S db 6,"Number",0
	Res db 128 dup(0)
.code
start:
	mov eax, offset Res
	push eax; смещение Res
	mov eax, offset S
	push eax; смещение S

	call PadCh 

	call MessageBoxA,0,offset Res+1,offset S+1,0
	call ExitProcess,0 ; конец программы
end start

