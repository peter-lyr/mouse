; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/06 20:46:22 星期四

NvimQtImageEyeFlag := 0

ActivateNvimQtExe() {
  Global NvimQtImageEyeFlag
  If WinExist("ahk_exe nvim-qt.exe") {
    WinActivate("ahk_exe nvim-qt.exe")
  } Else {
    Run("nvim-qt.exe")
    WinWaitActivate("ahk_exe nvim-qt.exe")
  }
  If (WinExist("ahk_exe Image Eye.exe")) {
    WinMinimize("ahk_exe Image Eye.exe")
    NvimQtImageEyeFlag := 0
  } Else {
    NvimQtImageEyeFlag := 1
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

#HotIf WinActive("ahk_exe WXWork.exe")

!l:: {
  ActivateNvimQtExe()
}

#HotIf WinActive("ahk_exe nvim-qt.exe")

; 需要taskkill /f /im "Image Eye.exe"后才能行
~LCtrl & RShift:: {
  Global NvimQtImageEyeFlag
  If (WinExist("ahk_exe Image Eye.exe")) {
    If (NvimQtImageEyeFlag) {
      For id in WinGetList("ahk_exe Image Eye.exe") {
        WinMinimize(id)
      }
      NvimQtImageEyeFlag := 0
    } Else {
      For id in WinGetList("ahk_exe Image Eye.exe") {
        WinActivate(id)
      }
      WinActivate("ahk_exe nvim-qt.exe")
      NvimQtImageEyeFlag := 1
    }
  }
}

#HotIf
