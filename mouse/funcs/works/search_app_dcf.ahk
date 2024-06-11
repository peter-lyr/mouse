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
  ExplorerOpen(CmdRunOutput(cmd))
}

#HotIf WinActive("ahk_exe explorer.exe")

F7:: {
  StartAppDcfFolder()
}

#HotIf
