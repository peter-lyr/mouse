; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/04 22:41:07 星期二

#Requires AutoHotkey v2.0

^#Enter:: {
  If (WinExist("ahk_class CabinetWClass")) {
    WinActivate("ahk_class CabinetWClass")
  }
  if Not WinWaitActive("ahk_class CabinetWClass", , 0.02) {
    Run("explorer.exe")
    WinWaitNotActive("A")
    Sleep 300
  } Else {
    Send("^t")
    Sleep 300
  }
  Send("^l")
  Sleep 100
  Send("^v")
  Sleep 300
  Send("{Enter}")
}

^!+r::Reload
^!+q::ExitApp
