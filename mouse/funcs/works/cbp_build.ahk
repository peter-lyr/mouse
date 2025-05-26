; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/04 13:41:37 Tuesday

CbpBuildDo() {
  ok := 0
  For id in WinGetList("ahk_exe codeblocks.exe") {
    ok := 1
    ActivateWaitSend(id, "{Esc}{F7}")
  }
  If (ok) {
    If (WinExist("ahk_exe nvim-qt.exe")) {
      WinActivate("ahk_exe nvim-qt.exe")
    } Else {
      Run("nvim-qt.exe")
    }
  }
  Return ok
}

CbpBuild() {
  If (Not CbpBuildDo()) {
    Send("{F6}")
  }
}

#HotIf WinExist("ahk_exe codeblocks.exe") And WinActive("ahk_exe nvim-qt.exe")

F6:: {
  CbpBuild()
}

#HotIf
