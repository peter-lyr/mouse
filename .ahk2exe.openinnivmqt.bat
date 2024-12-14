@echo off
cd %~dp0
set exe=openinnivmqt.exe
REM Ahk2Exe.exe /icon .openinnivmqt.ico /base "C:\Program Files\AutoHotKey\v2\AutoHotkey32.exe" /in .openinnivmqt.ahk /out %exe% /compress 1
Ahk2Exe.exe /base "C:\Program Files\AutoHotKey\v2\AutoHotkey32.exe" /in .openinnivmqt.ahk /out %exe% /compress 1
exit
