tasm32/ml lab4fun.asm
pause
tlink32/Tpd /c lab4fun.obj,,,,lab4fun.def
pause
tasm32/ml lab4.asm
pause
implib lab4fun.lib lab4fun.dll
pause
tlink32/Tpe/aa/x/c lab4.obj
pause
td32 lab4.exe