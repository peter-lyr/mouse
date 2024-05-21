; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/22 00:22:59 星期三

#Requires AutoHotkey v2.0

; mw: move window
; wa: work area
; m: monitor
; _t: _temp
; _n: _new

A_MaxHotkeysPerInterval := 1000

left_margin := 180

CoordMode("Mouse", "Screen")
SetWinDelay(0)

Strip(text) {
  Return Trim(text, " `r`t`n")
}

Join(string_array, sep:="`n") {
  res := ""
  for index, value in string_array {
    res .= value . sep
  }
  Return Strip(res)
}

Print(arr) {
  Tooltip(Join(arr))
}

RButtonIsPressed() {
  Return GetKeyState("RButton", "P")
}

LButtonIsPressed() {
  Return GetKeyState("LButton", "P")
}

MoveWindowWatcher(wa_x, wa_y, wa_w, wa_h) {
  Global mw_x0
  Global mw_y0
  Global mw_w0
  Global mw_h0

  Global mw
  Global mw_x1
  Global mw_y1

  If (Not RButtonIsPressed()) {
    SetTimer , 0
    WinMove(mw_x0, mw_y0, mw_w0, mw_h0, mw)
    Return
  }
  If (Not LButtonIsPressed()) {
    SetTimer , 0
    Return
  }

  MouseGetPos(&mw_x2, &mw_y2)
  WinGetPos(&_t_x, &_t_y, &_t_w, &_t_h, mw)

  _n_x := _t_x + mw_x2 - mw_x1
  _n_y := _t_y + mw_y2 - mw_y1
  _n_w := _t_w
  _n_h := _t_h

  If (_n_x < wa_x) {
    _n_x := wa_x
  } Else If (_n_x + _t_w > wa_w + wa_x) {
    _n_x := wa_w + wa_x - _t_w
  }
  If (_n_y < wa_y) {
    _n_y := wa_y
  } Else If (_n_y + _t_h > wa_h + wa_y) {
    _n_y := wa_h + wa_y - _t_h
  }
  If (_n_h > wa_h) {
    _n_h := wa_h
  }
  If (_n_w > wa_w) {
    _n_w := wa_w
  }
  WinMove(_n_x, _n_y, _n_w, _n_h, mw)
  mw_x1 := mw_x2
  mw_y1 := mw_y2
}

GetWorkAreaXYWH(x, y) {
  loop MonitorGetCount() {
    MonitorGet(A_index, &m_left, &m_top, &m_right, &m_bottom)
    If (x >= m_left and x <= m_right and y >= m_top and y <= m_bottom) {
      MonitorGetWorkArea(A_index, &wa_left, &wa_top, &wa_right, &wa_bottom)
      wa_x := wa_left
      wa_y := wa_top
      wa_w := wa_right - wa_left
      wa_h := wa_bottom - wa_top
      If (wa_left == 0) {
        wa_x := left_margin
        wa_w := wa_right - wa_left - left_margin
      }
    }
  }
  Return [wa_x, wa_y, wa_w, wa_h]
}

MoveWindow() {
  Global mw
  Global mw_x0
  Global mw_y0
  Global mw_w0
  Global mw_h0
  Global mw_x1
  Global mw_y1
  MouseGetPos &mw_x1, &mw_y1, &mw
  WinGetPos(&mw_x0, &mw_y0, &mw_w0, &mw_h0, mw)
  mv_max := WinGetMinMax(mw)
  if (mv_max) {
    Return
  }
  ; Print([
  ;   "mw_x1: " . mw_x1,
  ;   "mw_y1: " . mw_y1,
  ;   ; "mw: " . mw,
  ;   "mv_max: " . mv_max,
  ; ])
  wa := GetWorkAreaXYWH(mw_x1, mw_y1)
  SetTimer(() => MoveWindowWatcher(wa*), 10)
  SetTimer(Tooltip, -3000)
}

RButton & LButton:: {
  MoveWindow()
}
