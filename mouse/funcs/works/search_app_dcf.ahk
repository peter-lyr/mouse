; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/06 00:14:59 星期四

StartAppDcfFolder() {
  ClickActiveWindow(25, 25)
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
  cmd := "cd " . A_ScriptDir . "\mouse\funcs\works\ && search_start_sub_dir.py " . A_Clipboard . " app.dcf"
  result := CmdRunOutput(cmd)
  If Not result {
    Return
  }
  A_Clipboard := result
  ClickActiveWindow(25, 25)
  WinWaitActive("ahk_exe explorer.exe")
  Sleep 100
  Send("!d")
  Sleep 100
  Send("^v")
  Sleep 200
  Send("{Enter}")
  Send("!d")
  Send("{Esc}")
}

#HotIf WinExist("ahk_exe explorer.exe")

~F7:: {
  StartAppDcfFolder()
}

#HotIf
