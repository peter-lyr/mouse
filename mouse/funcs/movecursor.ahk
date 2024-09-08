CursorStep1 := 500
CursorStep2 := 200
CursorStep3 := 50
CursorStep4 := 10
CursorStep5 := 2

Cursor_distance := CursorStep1

CursorClick() {
  MouseClick("Left")
}

CursorX(dir) {
  Global cursor_x0, cursor_y0
  Global wc_x, wc_y, wc_w, wc_h
  cursor_x0 += Cursor_distance * dir
  If (cursor_x0 > wc_x + wc_w) {
    cursor_x0 := wc_x + wc_w
  }
  If (cursor_x0 < wc_x) {
    cursor_x0 := wc_x
  }
  MouseMove(cursor_x0, cursor_y0)
}

CursorY(dir) {
  Global cursor_x0, cursor_y0
  Global wc_x, wc_y, wc_w, wc_h
  cursor_y0 += Cursor_distance * dir
  If (cursor_y0 > wc_y + wc_h) {
    cursor_y0 := wc_y + wc_h
  }
  If (cursor_y0 < wc_y) {
    cursor_y0 := wc_y
  }
  MouseMove(cursor_x0, cursor_y0)
}

ChangeDistance(val) {
  Global Cursor_distance
  If val == 1 {
    Cursor_distance := CursorStep1
  } Else If val == 2 {
    Cursor_distance := CursorStep2
  } Else If val == 3 {
    Cursor_distance := CursorStep3
  } Else If val == 4 {
    Cursor_distance := CursorStep4
  } Else If val == 5 {
    Cursor_distance := CursorStep5
  }
}

GO_HJKL() {
  K_Escape()
  K_HJKL()
}

KT_MoveCursor_Ready() {
  Global cursor_x0, cursor_y0
  Global wc_x, wc_y, wc_w, wc_h
  MouseGetPos(&cursor_x0, &cursor_y0)
  GetCurWorkAreaXYWH(cursor_x0, cursor_y0, &wc_x, &wc_y, &wc_w, &wc_h)
  MouseMove(cursor_x0+1, cursor_y0+0)
  MouseMove(cursor_x0+0, cursor_y0+1)
  MouseMove(cursor_x0+1, cursor_y0+1)
  MouseMove(cursor_x0+0, cursor_y0+0)
}

MoveCursor_List := [
  "space", ["Click", CursorClick],
  "a", ["Step1 500", () => ChangeDistance(1)],
  "s", ["Step2 200", () => ChangeDistance(2)],
  "d", ["Step3 60", () => ChangeDistance(3)],
  "f", ["Step4 10", () => ChangeDistance(4)],
  "g", ["Step5 2", () => ChangeDistance(5)],
  "l", ["Right", () => CursorX(1)],
  "h", ["Left", () => CursorX(-1)],
  "k", ["Up", () => CursorY(-1)],
  "j", ["Down", () => CursorY(1)],
  "m", ["RightDown", () => [CursorX(1), CursorY(1)]],
  "n", ["LeftDown", () => [CursorX(-1), CursorY(1)]],
  "y", ["LeftUp", () => [CursorX(-1), CursorY(-1)]],
  "u", ["RightUp", () => [CursorX(1), CursorY(-1)]],
  ",", ["ActivateEmacs", ActivateEmacs],
  "rshift", ["ActivateNvimQtExe", ActivateNvimQtExe],
  "lshift", ["ActivateNvimQtExe", ActivateNvimQtExe],
  "tab", ["K_HJKL", GO_HJKL],
]

K_MoveCursor() {
  KT_MoveCursor_Ready()
  K(MoveCursor_List*)
}

KT_MoveCursor() {
  KT_MoveCursor_Ready()
  KT(MoveCursor_List*)
}
