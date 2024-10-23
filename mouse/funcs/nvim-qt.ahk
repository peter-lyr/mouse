; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/06 20:46:22 星期四

ActivateNvimQtExe() {
  ActivateOrOpen("ahk_exe nvim-qt.exe", "nvim-qt.exe")
}

ActivateWindowsTerminalExe() {
  ActivateOrOpen("ahk_exe WindowsTerminal.exe", "nvim.exe")
}

ActivateMstscExe() {
  If WinExist("ahk_exe mstsc.exe") {
    Loop 6 {
      WinActivate("ahk_exe mstsc.exe")
      If WinActive("ahk_exe mstsc.exe") {
        Break
      }
    }
  }
}

ActivateEmacs() {
  ActivateOrOpen("ahk_exe emacs.exe", "runemacs.exe")
}

TaskkillNvim() {
  Run("taskkill /f /im nvim-qt.exe")
  Run("taskkill /f /im nvim.exe")
}

TaskkillEmacs() {
  Run("taskkill /f /im emacs.exe")
}
