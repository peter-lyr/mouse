#Requires AutoHotkey v2.0

WinActivate("ahk_exe nvim-qt.exe")
WinWaitActive("ahk_exe nvim-qt.exe")

Send("{Escape}{Escape}:e{Space}^v{Enter}")
