; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/06 20:46:22 星期四

ActivateNvimQtExe() {
  ; If (WinActive("ahk_exe mstsc.exe")) {
  ;   Send("{Ctrl Down}{Alt Down}{Home}")
  ;   Send("{Ctrl Down}{Alt Up}")
  ; }
  WinActivate("ahk_exe nvim-qt.exe")
}

ActivateMstscExe() {
  WinActivate("ahk_exe mstsc.exe")
}

^!Home:: {
  ActivateNvimQtExe()
}

^!End:: {
  ActivateMstscExe()
}
