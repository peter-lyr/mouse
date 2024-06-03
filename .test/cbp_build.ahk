; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/03 23:34:49 星期一

#Requires AutoHotkey v2.0

^!i:: {
  If (WinExist("ahk_exe codeblocks.exe")) {
    WinActivate("ahk_exe codeblocks.exe")
    WinWait("ahk_exe codeblocks.exe")
    Send("{F7}")
  }
}

^!+r::Reload
^!+q::ExitApp
