; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/04 13:41:37 Tuesday

CbpBuild() {
  If (WinExist("ahk_exe codeblocks.exe")) {
    ActivateWaitMaximizeSend("ahk_exe codeblocks.exe", "{Esc}{F7}")
    If (WinExist("ahk_exe Downloader.exe")) {
      SetTimer () => WinActivate("ahk_exe Downloader.exe"), -400
    }
    SetTimer () => WinRestore("ahk_exe codeblocks.exe"), -200
    Return 1
  }
  Return 0
}

#HotIf WinExist("ahk_exe codeblocks.exe")

F6:: {
  If (Not CbpBuild()) {
    Send("{F6}")
  }
}

#HotIf
