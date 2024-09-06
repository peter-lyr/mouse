CursorStep1 := 300
CursorStep2 := 60
CursorStep3 := 10

K_menus := ""
MoveCursorEn := 0

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

; TestHotKey(this) {
;   MsgBox(this)
; }

Escape() {
  Global MoveCursorEn
  ; MsgBox(MoveCursorEn)
  MoveCursorEn := 0
  K_Hot()
}

K_Hot() {
  Global K_menus
  On := "On"
  If MoveCursorEn == 0 {
    On := "Off"
    Tooltip
  }
  For k, v in K_menus {
    ; HotKey "{" . k . "}", v[2]
    ; HotKey "{" . k . "}", CursorClick
    ; HotKey ",", CursorClick
    ; HotKey ",", (this) => CursorClick()
    ; HotKey ",", (*) => CursorClick(), On
    ; HotKey "{" . k . "}", (*) => v[2](), On
    ; HotKey "{" . k . "}", (*) => v[2]()
    ; HotKey k, (*) => v[2]()
    ; HotKey k, (*) => CursorClick()
    HotKey k, (key) => K_menus[key][2](), On
    ; HotKey ",", TestHotKey
    ; MsgBox "{" . k . "}" . "|" . Type(v[2])
    ; MsgBox "{" . k . "}" . "|" . v[1]
    ; Break
  }
  HotKey "escape", (*) => Escape(), On
}

K(items*) {
  Global K_menus
  Global MoveCursorEn
  MoveCursorEn := 1
  K_menus := GetMenus(items)
  msg := GetMsg(K_menus)
  CoordMode("Tooltip", "Screen")
  Tooltip(msg, 0, 0)
  ; SetTimer(Tooltip, -10000)
  K_Hot()
}

MoveCursor() {
  Global cursor_x0, cursor_y0
  Global wc_x, wc_y, wc_w, wc_h
  CursorNormalWaitSeconds := 8
  MouseGetPos(&cursor_x0, &cursor_y0)
  GetCurWorkAreaXYWH(cursor_x0, cursor_y0, &wc_x, &wc_y, &wc_w, &wc_h)
  MouseMove(cursor_x0+1, cursor_y0+0)
  MouseMove(cursor_x0+0, cursor_y0+1)
  MouseMove(cursor_x0+1, cursor_y0+1)
  MouseMove(cursor_x0+0, cursor_y0+0)
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
