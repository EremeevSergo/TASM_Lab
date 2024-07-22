tasm.exe lab2.asm/l
pause
tasm.exe lab2fun.asm/l
pause
tlink.exe lab2.obj + lab2fun.obj
pause
td.exe lab2.exe