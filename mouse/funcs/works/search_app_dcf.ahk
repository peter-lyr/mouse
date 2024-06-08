; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/06 00:14:59 星期四

StartAppDcfFolder() {
  A_Clipboard := ""
  While 1 {
    Send("!d")
    Sleep 10
    Send("^c")
    If (A_Clipboard) {
      Sleep 10
      Send("{Esc}")
      Break
    }
  }
  cmd := A_ScriptDir . "\mouse\funcs\works\search_start_sub_dir.py " . A_Clipboard . " app.dcf"
  result := CmdRunOutput(cmd)
  If Not result {
    Return
  }
  A_Clipboard := result
  WinActivate("ahk_exe explorer.exe")
  WinWaitActive("ahk_exe explorer.exe")
  Sleep 100
  Send("!d")
  Sleep 100
  Send("^v")
  Sleep 200
  Send("{Enter}")
  Sleep 200
  Send("!d")
  Sleep 200
  Send("{Enter}")
}

#HotIf WinExist("ahk_exe explorer.exe")

~F7:: {
  StartAppDcfFolder()
}

#HotIf
