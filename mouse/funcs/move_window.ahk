; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/22 00:22:59 星期三

; mw_: move window
; wa_: work area
; _m_: monitor
; _t_: temp
; _n_: new

MoveWindowWatcher(wa_x, wa_y, wa_w, wa_h) {
  Global mw
  Global mw_x0
  Global mw_y0
  Global mw_w0
  Global mw_h0
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
  mw_x1 := mw_x2
  mw_y1 := mw_y2

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
}

GetWorkAreaXYWH(x, y) {
  loop MonitorGetCount() {
    MonitorGet(A_index, &_m_left, &_m_top, &_m_right, &_m_bottom)
    If (x >= _m_left and x <= _m_right and y >= _m_top and y <= _m_bottom) {
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

  ; [x] TODODONE: exclude ahk_class AutoHotkeyGUI

  mv_max := WinGetMinMax(mw)
  if (mv_max) {
    Return
  }

  wa := GetWorkAreaXYWH(mw_x1, mw_y1)
  SetTimer(() => MoveWindowWatcher(wa*), 10)
}
