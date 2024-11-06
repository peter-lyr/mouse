; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/23 13:46:15 Thursday

NavigateUp(j) {
  Return j And "<Alt-Up>" Or Send("!{Up}")
}

NavigateForward(j) {
  If (WinActive("ahk_exe BCompare.exe")) {
    Return j And "<Ctrl-P>" Or Send("^p")
  }
  If (WinActive("ahk_exe nvim-qt.exe")) {
    Return j And "<Ctrl-I>" Or Send("^i")
  }
  Return j And "<Alt-Right>" Or Send("!{Right}")
}

NavigateBackward(j) {
  If (WinActive("ahk_exe BCompare.exe")) {
    Return j And "<Ctrl-N>" Or Send("^n")
  }
  If (WinActive("ahk_exe nvim-qt.exe")) {
    Return j And "<Ctrl-O>" Or Send("^o")
  }
  Return j And "<Alt-Left>" Or Send("!{Left}")
}

BatPyToBak() {
  Run(Join([GetPy("batpy2bak.py"), "tobak"], " "))
}

BatPyToDesktop() {
  Run(Join([GetPy("batpy2bak.py"), "todesktop"], " "))
}
