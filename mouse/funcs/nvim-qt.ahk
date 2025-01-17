; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/06 20:46:22 星期四

ActivateNvimQtExe() {
  ActivateOrOpen("ahk_exe nvim-qt.exe", "nvim-qt.exe -- -u ~/AppData/Local/nvim/init-qt.vim")
}

ActivateOneNvimQtExeNext() {
  Global NvimQts
  Global NvimQtIndex
  NvimQtIndex := NvimQtIndex + 1
  If (NvimQtIndex > NvimQts.Length) {
    NvimQtIndex := 1
  }
  WinWaitActivate(NvimQts[NvimQtIndex])
}

ActivateOneNvimQtExePrev() {
  Global NvimQts
  Global NvimQtIndex
  NvimQtIndex := NvimQtIndex - 1
  If (NvimQtIndex == 0) {
    NvimQtIndex := NvimQts.Length
  }
  WinWaitActivate(NvimQts[NvimQtIndex])
}

ActivateOneNvimQtExe() {
  Global NvimQts
  Global NvimQtIndex
  NvimQts := WinGetList("ahk_exe nvim-qt.exe")
  NvimQtIndex := 1
  If NvimQts.Length <= 1 {
    ActivateNvimQtExe()
    G(".", ["ActivateNvimQtExe", ActivateNvimQtExe])
  } Else {
    ActivateOneNvimQtExeNext()
    K(
      ".", ["ActivateOneNvimQtExeNext", ActivateOneNvimQtExeNext],
      "j", ["ActivateOneNvimQtExeNext", ActivateOneNvimQtExeNext],
      "k", ["ActivateOneNvimQtExePrev", ActivateOneNvimQtExePrev],
      "space", ["Exit", K_Escape],
      "enter", ["ActivateMstscExe", () => [
        ActivateMstscExe(),
        K_Escape()
      ]],
    )
  }
}

; ActivateNvimQtExeNoNet() {
;   ActivateOrOpen("ahk_exe nvim-qt.exe", "nvim-qt.exe -- -u ~/AppData/Local/nvim/init-no-net.vim")
; }

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
