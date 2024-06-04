; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/23 13:46:15 Thursday

NavigateUp(j) {
  If (j) {
    Return "<Alt-Up>"
  }
  Send("!{Up}")
}

NavigateForward(j) {
  If (j) {
    If (WinActive("ahk_exe BCompare.exe")) {
      Return "<Ctrl-P>"
    }
    If (WinActive("ahk_exe nvim-qt.exe")) {
      Return "<Ctrl-I>"
    }
    Return "<Alt-Right>"
  }
  If (WinActive("ahk_exe BCompare.exe")) {
    Send("^p")
    Return
  }
  If (WinActive("ahk_exe nvim-qt.exe")) {
    Send("^i")
    Return
  }
  Send("!{Right}")
}

NavigateBackward(j) {
  If (j) {
    If (WinActive("ahk_exe BCompare.exe")) {
      Return "<Ctrl-N>"
    }
    If (WinActive("ahk_exe nvim-qt.exe")) {
      Return "<Ctrl-O>"
    }
    Return "<Alt-Left>"
  }
  If (WinActive("ahk_exe BCompare.exe")) {
    Send("^n")
    Return
  }
  If (WinActive("ahk_exe nvim-qt.exe")) {
    Send("^o")
    Return
  }
  Send("!{Left}")
}
