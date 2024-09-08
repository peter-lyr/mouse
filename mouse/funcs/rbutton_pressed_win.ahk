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

TransparentDownCurWin() {
  _t := WinGetTransparent("A")
  If (_t == "") {
    _t := 255
  }
  _t -= 10
  If (_t < 10) {
    _t := 10
  }
  WinSetTransparent(_t, "A")
}

TransparentUpCurWin() {
  _t := WinGetTransparent("A")
  If (_t == "") {
    _t := 255
  }
  _t += 10
  If (_t > 255) {
    _t := 255
  }
  WinSetTransparent(_t, "A")
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

KillIfStillExist(win) {
  If (WinExist(win)) {
    WinKill(win)
  }
}

ActivateAndAltF4UnderMouse() {
  MouseGetPos , , &_win
  WinActivate(_win)
  WinWaitActive(_win)
  If WinActive("ahk_exe emacs.exe") {
    Send("^x")
    Send("^c")
  } Else If WinActive("ahk_class Progman") {
    ; 桌面
    Send("!{F4}")
  } Else {
    Send("!{F4}")
    SetTimer(() => KillIfStillExist(_win), 1000)
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

BarColors := [
  "0X3357FF", "0X33FF57", "0X33FFA1", "0X33FFD1",
  "0X5733FF", "0X57FF33", "0XA133FF", "0XD133FF",
  "0XFF33A1", "0XFF33D1", "0XFF5733",
]

Lines := []
TextPos := []

Chars := [
  "a", "b", "c", "d", "e",
  "f", "g", "h", "i", "j",
  "k", "l", "m", "n", "o",
  "p", "q", "r", "s", "t",
  "u", "v", "w", "x", "y",
  "z",
]

DrawRectangle(x, y, w, h, index) {
  Global TextPos
  GuiOpt := "+LastFound +ToolWindow +AlwaysOnTop -Caption +Disabled"
  bar := 4
  text_size := 24
  ; 先上下再左右
  X := [x, x, x, x + w - bar]
  Y := [y, y + h - bar, y, y]
  bar := bar * 96 / A_ScreenDPI
  w := w * 96 / A_ScreenDPI
  h := h * 96 / A_ScreenDPI
  W := [w, w, bar, bar]
  H := [bar, bar, h, h]
  color := BarColors[Mod(index, BarColors.Length) + 1]
  Loop 4 {
    line := Gui()
    line.Opt(GuiOpt)
    line.BackColor := color
    _show_wh := Format("X{:}Y{:}W{:}H{:}", X[A_Index], Y[A_Index], W[A_Index], H[A_Index])
    line.Show(_show_wh . " NA")
    WinSetTransparent(100, "Ahk_id " . line.Hwnd)
    Lines.Push(line)
  }
  line := Gui()
  line.Opt(GuiOpt)
  line.Add("Text", , Chars[Mod(index, Chars.Length)])
  line.BackColor := color
  x := X[1]
  ; y := Y[1] + text_size
  y := Y[1]
  For pos in TextPos {
    x0 := pos[1]
    y0 := pos[2]
    _dx := x - x0
    _dy := y - y0
    _c := Sqrt(_dx ** 2 + _dy ** 2)
    ; If (_c < text_size) {
    ;   x += text_size
    ;   y += text_size
    ; }
    ; _c := Sqrt(_dx ** 2)
    If (_c < text_size) {
      x += text_size
      ; y += text_size
    }
  }
  TextPos.Push([x, y])
  _show_wh := Format("X{:}Y{:}W{:}H{:}", x, y, text_size, text_size)
  line.Show(_show_wh . " NA")
  WinSetTransparent(225, "Ahk_id " . line.Hwnd)
  Lines.Push(line)
}

KillRectangles() {
  Global Lines
  For line in Lines {
    line.Destroy()
  }
  Lines := []
}

DrawRectangles(X, Y, W, H, I) {
  KillRectangles()
  For i in I {
    index := A_Index
    DrawRectangle(X[index], Y[index], W[index], H[index], i)
  }
}
