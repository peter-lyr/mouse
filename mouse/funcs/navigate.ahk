; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/23 13:46:15 Thursday

NavigateUp(j) {
  If (j) {
    Return "<Alt-Up>"
  }
  If (WinActive("ahk_exe explorer.exe")) {
    Send("!{Up}")
  }
}

NavigateForward(j) {
  If (j) {
    Return "NavigateForward"
  }
  If (WinActive("ahk_exe nvim-qt.exe")) {
    Send("^i")
    Return
  }
  Send("!{Right}")
}

NavigateBackward(j) {
  If (j) {
    Return "NavigateBackward"
  }
  If (WinActive("ahk_exe nvim-qt.exe")) {
    Send("^o")
    Return
  }
  Send("!{Left}")
}
