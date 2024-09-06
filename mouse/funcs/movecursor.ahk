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

; MoveCursorEn := 0
;
; #HotIf MoveCursorEn
; space:: {
;   CursorClick()
; }
; d:: {
;   CursorX(CursorStep1)
; }
; a:: {
;   CursorX(-CursorStep1)
; }
; w:: {
;   CursorY(-CursorStep1)
; }
; s:: {
;   CursorY(CursorStep1)
; }
; l:: {
;   CursorX(CursorStep2)
; }
; h:: {
;   CursorX(-CursorStep2)
; }
; k:: {
;   CursorY(-CursorStep2)
; }
; j:: {
;   CursorY(CursorStep2)
; }
; b:: {
;   CursorX(CursorStep3)
; }
; c:: {
;   CursorX(-CursorStep3)
; }
; f:: {
;   CursorY(-CursorStep3)
; }
; v:: {
;   CursorY(CursorStep3)
; }
; m:: {
;   ActivateEmacs()
; }
; rshift:: {
;   ActivateNvimQtExe()
; }
; lshift:: {
;   ActivateNvimQtExe()
; }
; escape:: {
;   Global MoveCursorEn
;   MoveCursorEn := 0
; }
; #HotIf

K(items*) {
  menus := GetMenus(items)
  msg := GetMsg(menus)
  Tooltip(msg, 0, 0)
  SetTimer(Tooltip, -10000)
}

MoveCursor() {
  ; Global MoveCursorEn
  Global cursor_x0, cursor_y0
  Global wc_x, wc_y, wc_w, wc_h
  CursorNormalWaitSeconds := 8
  MouseGetPos(&cursor_x0, &cursor_y0)
  GetCurWorkAreaXYWH(cursor_x0, cursor_y0, &wc_x, &wc_y, &wc_w, &wc_h)
  MouseMove(cursor_x0+1, cursor_y0+0)
  MouseMove(cursor_x0+0, cursor_y0+1)
  MouseMove(cursor_x0+1, cursor_y0+1)
  MouseMove(cursor_x0+0, cursor_y0+0)
  ; MoveCursorEn := 1
  K(
    "space", ["Click", CursorClick, "Continue", CursorNormalWaitSeconds],
    "d", ["Step1 Right", () => CursorX(CursorStep1), "Continue", CursorNormalWaitSeconds],
    "a", ["Step1 Left", () => CursorX(-CursorStep1), "Continue", CursorNormalWaitSeconds],
    "w", ["Step1 Up", () => CursorY(-CursorStep1), "Continue", CursorNormalWaitSeconds],
    "s", ["Step1 Down", () => CursorY(CursorStep1), "Continue", CursorNormalWaitSeconds],
    "l", ["Step2 Right", () => CursorX(CursorStep2), "Continue", CursorNormalWaitSeconds],
    "h", ["Step2 Left", () => CursorX(-CursorStep2), "Continue", CursorNormalWaitSeconds],
    "k", ["Step2 Up", () => CursorY(-CursorStep2), "Continue", CursorNormalWaitSeconds],
    "j", ["Step2 Down", () => CursorY(CursorStep2), "Continue", CursorNormalWaitSeconds],
    "b", ["Step3 Right", () => CursorX(CursorStep3), "Continue", CursorNormalWaitSeconds],
    "c", ["Step3 Left", () => CursorX(-CursorStep3), "Continue", CursorNormalWaitSeconds],
    "f", ["Step3 Up", () => CursorY(-CursorStep3), "Continue", CursorNormalWaitSeconds],
    "v", ["Step3 Down", () => CursorY(CursorStep3), "Continue", CursorNormalWaitSeconds],
    "m", ["ActivateEmacs", ActivateEmacs, "Continue"],
    "rshift", ["ActivateNvimQtExe", ActivateNvimQtExe, "Continue"],
    "lshift", ["ActivateNvimQtExe", ActivateNvimQtExe, "Continue"],
  )
}
