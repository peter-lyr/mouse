@echo off
cd %~dp0
set exe=winmaxemacs.exe
Ahk2Exe.exe /icon .winmaxemacs.ico /base "C:\Program Files\AutoHotKey\v2\AutoHotkey32.exe" /in .winmaxemacs.ahk /out %exe% /compress 1
exit
