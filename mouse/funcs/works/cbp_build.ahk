; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/04 13:41:37 Tuesday

CbpBuildDo() {
  Try {
    wid := WinGetId("A")
  }
  ok := 0
  For id in WinGetList("ahk_exe codeblocks.exe") {
    ok := 1
    WinActivate(id)
    ActivateWaitSend(id, "{Esc}{F7}")
    WinWaitActive(id)
    Send("!{Esc}")
  }
  If (ok) {
    If (WinExist(wid)) {
      WinActivate(wid)
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
