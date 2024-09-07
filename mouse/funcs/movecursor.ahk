CursorStep1 := 300
CursorStep2 := 60
CursorStep3 := 10

CursorClick() {
  MouseClick("Left")
}

CursorX(distance) {
  Global cursor_x0, cursor_y0
  Global wc_x, wc_y, wc_w, wc_h
  cursor_x0 += distance
  If (cursor_x0 > wc_x + wc_w) {
    cursor_x0 := wc_x + wc_w
  }
  If (cursor_x0 < wc_x) {
    cursor_x0 := wc_x
  }
  MouseMove(cursor_x0, cursor_y0)
}

CursorY(distance) {
  Global cursor_x0, cursor_y0
  Global wc_x, wc_y, wc_w, wc_h
  cursor_y0 += distance
  If (cursor_y0 > wc_y + wc_h) {
    cursor_y0 := wc_y + wc_h
  }
  If (cursor_y0 < wc_y) {
    cursor_y0 := wc_y
  }
  MouseMove(cursor_x0, cursor_y0)
}

K_MoveCursor() {
  Global cursor_x0, cursor_y0
  Global wc_x, wc_y, wc_w, wc_h
  MouseGetPos(&cursor_x0, &cursor_y0)
  GetCurWorkAreaXYWH(cursor_x0, cursor_y0, &wc_x, &wc_y, &wc_w, &wc_h)
  MouseMove(cursor_x0+1, cursor_y0+0)
  MouseMove(cursor_x0+0, cursor_y0+1)
  MouseMove(cursor_x0+1, cursor_y0+1)
  MouseMove(cursor_x0+0, cursor_y0+0)
  K(
    "space", ["Click", CursorClick],
    "d", ["Step1 Right", () => CursorX(CursorStep1)],
    "a", ["Step1 Left", () => CursorX(-CursorStep1)],
    "w", ["Step1 Up", () => CursorY(-CursorStep1)],
    "s", ["Step1 Down", () => CursorY(CursorStep1)],
    "l", ["Step2 Right", () => CursorX(CursorStep2)],
    "h", ["Step2 Left", () => CursorX(-CursorStep2)],
    "k", ["Step2 Up", () => CursorY(-CursorStep2)],
    "j", ["Step2 Down", () => CursorY(CursorStep2)],
    "b", ["Step3 Right", () => CursorX(CursorStep3)],
    "c", ["Step3 Left", () => CursorX(-CursorStep3)],
    "f", ["Step3 Up", () => CursorY(-CursorStep3)],
    "v", ["Step3 Down", () => CursorY(CursorStep3)],
    "m", ["ActivateEmacs", ActivateEmacs],
    "rshift", ["ActivateNvimQtExe", ActivateNvimQtExe],
    "lshift", ["ActivateNvimQtExe", ActivateNvimQtExe],
  )
}
