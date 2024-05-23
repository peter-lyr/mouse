@echo off
set exe=mouse.exe
taskkill /f /im %exe%
Ahk2Exe.exe /icon ..ico /base "C:\Program Files\AutoHotKey\v2\AutoHotkey32.exe" /in main.ahk /out %exe% /compress 1
exit
