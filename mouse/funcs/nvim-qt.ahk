; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/06 20:46:22 星期四

ActivateNvimQtExe() {
  ; If (WinActive("ahk_exe mstsc.exe")) {
  ;   Send("{Ctrl Down}{Alt Down}{Home}")
  ;   Send("{Ctrl Down}{Alt Up}")
  ; }
  If WinExist("ahk_exe nvim-qt.exe") {
    WinActivate("ahk_exe nvim-qt.exe")
  }
}

ActivateMstscExe() {
  If WinExist("ahk_exe mstsc.exe") {
    Loop 6 {
      WinActivate("ahk_exe mstsc.exe")
    }
  }
}

#HotIf WinActive("ahk_exe WXWork.exe")

!l:: {
  ActivateNvimQtExe()
}

#HotIf

^!Home:: {
  ActivateNvimQtExe()
}

^!l:: {
  ActivateMstscExe()
}
