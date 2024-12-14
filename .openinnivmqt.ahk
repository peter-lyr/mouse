#Requires AutoHotkey v2.0

WinActivate("ahk_exe nvim-qt.exe")
WinWaitActive("ahk_exe nvim-qt.exe")

Send("{Escape}{Escape}:lua{Space}Joe[[^v]]{Enter}")
