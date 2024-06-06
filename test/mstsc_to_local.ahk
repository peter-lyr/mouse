; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/06 21:13:53 星期四

; 好像mstsc里把这些热键都捕获了，如果mstsc里没有对这些热键进行响应，就不起作用了

#Requires AutoHotkey v2.0

SetTimer WaitForRdp, -2050

; Task View Switch Desktops Ctrl + Alt + Arrow keys
^!Left:: {
  Send("{Ctrl down}{Alt down}{Home}{Alt up}{Ctrl up}")
  Sleep 200
  Send("{Ctrl down}{LWin down}{Left}{LWin up}{Ctrl up}")
}

^!Right:: {
  Send("{Ctrl down}{LWin down}{Right}{LWin up}{Ctrl up}")
}

WaitForRdp() {
  If WinActive("ahk_class TscShellContainerClass") {
    WinWaitNotActive("ahk_class TscShellContainerClass", , 3600)
  }
  WinWaitActive("ahk_class TscShellContainerClass", , 3600)
  MsgBox(">>>")
  Reload
}
