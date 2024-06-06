; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/06 00:14:59 星期四

StartAppDcfFolder() {
  ClickActiveWindow(25, 25)
  If (Not WinActive("ahk_exe explorer.exe")) {
    Return
  }
  Send("!d")
  Sleep 200
  Send("^c")
  Sleep 100
  Send("{Enter}")
  cmd := "cd " . A_ScriptDir . "\mouse\funcs\works\ && search_start_sub_dir.py " . A_Clipboard . " app.dcf"
  result := CmdRunOutput(cmd)
  If Not result {
    Return
  }
  A_Clipboard := result
  ClickActiveWindow(25, 25)
  If (Not WinActive("ahk_exe explorer.exe")) {
    Return
  }
  Sleep 200
  Send("!d")
  Sleep 200
  Send("^v")
  Sleep 10
  Send("{Enter}")
}

#HotIf WinExist("ahk_exe explorer.exe")

~F7:: {
  StartAppDcfFolder()
}

#HotIf
