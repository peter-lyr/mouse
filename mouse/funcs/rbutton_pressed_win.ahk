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
  PrintLater("Transparent " . WinGetTransparent(_win))
}

TransparentDownRbuttonPressWin() {
  _win := GetRbuttonPressWin()
  If (Not WinExist(_win)) {
    Return
  }
  _t := WinGetTransparent(_win)
  _t -= 10
  If (_t < 10) {
    _t := 10
  }
  WinSetTransparent(_t, _win)
  PrintLater("Transparent " . _t)
}

TransparentUpRbuttonPressWin() {
  _win := GetRbuttonPressWin()
  If (Not WinExist(_win)) {
    Return
  }
  _t := WinGetTransparent(_win)
  _t += 10
  If (_t > 255) {
    _t := 255
  }
  WinSetTransparent(_t, _win)
  PrintLater("Transparent " . _t)
}

TransparentToggleA() {
  If (255 != WinGetTransparent("A")) {
    WinSetTransparent(255, "A")
  } Else {
    WinSetTransparent(200, "A")
  }
  PrintLater("Transparent " . WinGetTransparent("A"))
}

TopMostToggleRbuttonPressWin() {
  _win := GetRbuttonPressWin()
  If (Not WinExist(_win)) {
    Return
  }
  WinSetAlwaysOnTop(-1, _win)
  ExStyle := WinGetExStyle(_win)
  if (ExStyle & 0x8) {
    PrintLater("Top Most")
  } Else {
    PrintLater("Top Most Canceled")
  }
}

TopMostToggleA() {
  WinSetAlwaysOnTop(-1, "A")
  ExStyle := WinGetExStyle("A")
  if (ExStyle & 0x8) {
    PrintLater("Top Most")
  } Else {
    PrintLater("Top Most Canceled")
  }
}

ActivateAndAltF4UnderMouse() {
  MouseGetPos , , &_win
  WinActivate(_win)
  WinWaitActive(_win)
  If WinActive("ahk_exe emacs.exe") {
    Send("^x")
    Send("^c")
  } Else {
    ; Send("!{F4}")
    WinKill(_win)
  }
}

ActivateAndTaskKillUnderMouse() {
  MouseGetPos , , &_win
  _process_name := WinGetProcessName(_win)
  If StrInArray(_process_name, no_taskkill_processes) {
    Return
  }
  Run('taskkill /f /im "' . _process_name . '"')
}

ActivateAndCtrlClickUnderMouse() {
  MouseGetPos &_x, &_y, &_win
  WinActivate(_win)
  WinWaitActive(_win)
  Send("^{Click " . _x . ", " . _y . "}")
}

ActivateAndShiftClickUnderMouse() {
  MouseGetPos &_x, &_y, &_win
  WinActivate(_win)
  WinWaitActive(_win)
  Send("+{Click " . _x . ", " . _y . "}")
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
