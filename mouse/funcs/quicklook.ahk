; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/11 22:27:36 星期二

QuickLookWatcher() {
  If (Not WinExist("ahk_exe QuickLook.exe")) {
    Return
  }
  WinSetExStyle("+0x40000", "ahk_exe QuickLook.exe")
  ExStyle := WinGetExStyle("ahk_exe QuickLook.exe")
  If (ExStyle & 0x40000) {
    SetTimer(QuickLookWatcher, 0)
  }
}

SetTimer(QuickLookWatcher, 1000)
