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

MoveWindowWatcher() {
  Global mw
  Global mw_x1
  Global mw_y1

  Global wa_origin_x
  Global wa_origin_y
  Global wa_width
  Global wa_height

  MouseGetPos(&mw_x2, &mw_y2)
  WinGetPos(&_t_x, &_t_y, &_t_w, &_t_h, mw)

  _n_x := _t_x + mw_x2 - mw_x1
  _n_y := _t_y + mw_y2 - mw_y1
  _n_w := _t_w
  _n_h := _t_h

  If (_n_x < wa_origin_x) {
    _n_x := wa_origin_x
  } Else If (_n_x + _t_w > wa_width + wa_origin_x) {
    _n_x := wa_width + wa_origin_x - _t_w
  }
  If (_n_y < wa_origin_y) {
    _n_y := wa_origin_y
  } Else If (_n_y + _t_h > wa_height + wa_origin_y) {
    _n_y := wa_height + wa_origin_y - _t_h
  }
  If (_n_h > wa_height) {
    _n_h := wa_height
  }
  If (_n_w > wa_width) {
    _n_w := wa_width
  }
  WinMove(_n_x, _n_y, _n_w, _n_h, mw)
  mw_x1 := mw_x2
  mw_y1 := mw_y2
}

MonitorWorkArea(x, y) {
  Global wa_origin_x
  Global wa_origin_y
  Global wa_width
  Global wa_height
  loop MonitorGetCount() {
    MonitorGet(A_index, &m_left, &m_top, &m_right, &m_bottom)
    If (x >= m_left and x <= m_right and y >= m_top and y <= m_bottom) {
      MonitorGetWorkArea(A_index, &wa_left, &wa_top, &wa_right, &wa_bottom)
      wa_origin_x := wa_left
      wa_origin_y := wa_top
      wa_width := wa_right - wa_left
      wa_height := wa_bottom - wa_top
      If (wa_left == 0) {
        wa_origin_x := left_margin
        wa_width := wa_right - wa_left - left_margin
      }
    }
  }
}

RButton & LButton:: {
  Global mw_x1
  Global mw_y1
  Global mw
  MouseGetPos &mw_x1, &mw_y1, &mw
  mv_max := WinGetMinMax(mw)
  Print([
    "mw_x1: " . mw_x1,
    "mw_y1: " . mw_y1,
    ; "mw: " . mw,
    "mv_max: " . mv_max,
  ])
  MonitorWorkArea(mw_x1, mw_y1)
  SetTimer(MoveWindowWatcher, 10)
  SetTimer(Tooltip, -3000)
}
