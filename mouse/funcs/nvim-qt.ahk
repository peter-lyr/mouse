; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/06 20:46:22 星期四

ActivateNvimQtExe() {
  Try {
    If WinExist("ahk_exe nvim-qt.exe") {
      WinActivate("ahk_exe nvim-qt.exe")
    } Else {
      Run("nvim-qt.exe")
      WinWaitActivate("ahk_exe nvim-qt.exe")
    }
  }
}

ActivateMstscExe() {
  If WinActive("ahk_class WeWorkWindow") {
    WinMinimize("ahk_class WeWorkWindow")
  }
  If WinExist("ahk_exe mstsc.exe") {
    Loop 6 {
      WinActivate("ahk_exe mstsc.exe")
    }
  }
}
