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

^#k:: {
  WinMaximizeRestoreA()
}
