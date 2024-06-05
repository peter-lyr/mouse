; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/06 00:14:59 星期四

StartAppDcfFolder() {
  ClickActiveWindow(10, 10)
  If (Not WinActive("ahk_exe explorer.exe")) {
    Return
  }
  Send("^l")
  Sleep 200
  Send("^c")
  Send("{Enter}")
  cmd := "cd " . A_ScriptDir . "\mouse\funcs\works\ && search_start_sub_dir.py " . A_Clipboard . " app.dcf"
  A_Clipboard := CmdRunOutput(cmd)
  ClickActiveWindow(10, 10)
  If (Not WinActive("ahk_exe explorer.exe")) {
    Return
  }
  Send("^l")
  Sleep 200
  Send("^v")
  Sleep 200
  Send("{Enter}")
}

#HotIf WinExist("ahk_exe explorer.exe")

~F7:: {
  StartAppDcfFolder()
}

#HotIf
