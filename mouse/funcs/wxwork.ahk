; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/12 12:04:04 星期三

ii := 0

ActivateWXWorkExe() {
  Global ii
  If WinActive("ahk_exe mstsc.exe") {
    Send("^!{Home}")
  }
  If (WinExist("ahk_exe WXWork.exe")) {
    WinActivate("ahk_exe WXWork.exe")
    Send("^!+{F1}")
    If (ii == 0) {
      SetTimer(() => Print("Set ShortCut For WXWork: <Ctrl-Alt-Shift-F1>"), -100)
    }
    ii := 1
  }
}

