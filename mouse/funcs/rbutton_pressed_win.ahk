; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/20 14:10:22 Monday

WinMaximizeRestoreRbuttonPressWin() {
  _win := GetRbuttonPressWin()
  If (Not WinExist(_win)) {
    Return
  }
  If (WinGetMinMax(_win)) {
    WinRestore(_win)
  } Else {
    WinMaximize(_win)
    WinActivate(_win)
  }
}

WinMaximizeRestoreA() {
  If (WinGetMinMax("A")) {
    WinRestore("A")
  } Else {
    WinMaximize("A")
    WinActivate("A")
  }
}

WinMinimizeRbuttonPressWin() {
  _win := GetRbuttonPressWin()
  If (Not WinExist(_win)) {
    Return
  }
  WinMinimize(_win)
}

TransparentToggleRbuttonPressWin() {
  _win := GetRbuttonPressWin()
  If (Not WinExist(_win)) {
    Return
  }
  If (255 != WinGetTransparent(_win)) {
    WinSetTransparent(255, _win)
  } Else {
    WinSetTransparent(200, _win)
  }
}

TransparentToggleA() {
  If (255 != WinGetTransparent("A")) {
    WinSetTransparent(255, "A")
  } Else {
    WinSetTransparent(200, "A")
  }
}

TopMostToggleRbuttonPressWin() {
  _win := GetRbuttonPressWin()
  If (Not WinExist(_win)) {
    Return
  }
  WinSetAlwaysOnTop(-1, _win)
}

TopMostToggleA() {
  WinSetAlwaysOnTop(-1, "A")
}

^#l:: {
  TopMostToggleA()
}

^#;:: {
  TransparentToggleA()
}

^#k:: {
  WinMaximizeRestoreA()
}
