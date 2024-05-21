; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/22 00:22:59 星期三

#Requires AutoHotkey v2.0

A_MaxHotkeysPerInterval := 1000

leftmargin := 180

CoordMode "Mouse", "Screen"

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
  Global x1
  Global y1
  Global win
  Global x0
  Global y0
  Global w0
  Global h0
  Global title0

  Global origin_x
  Global origin_y
  Global real_width
  Global real_height
  SetWinDelay(0)
  MouseGetPos(&x2, &y2)
  WinGetPos(&x, &y, &w, &h, win)
  x_new := x + x2 - x1
  y_new := y + y2 - y1
  w_new := w
  h_new := h
  If (x_new < origin_x) {
    x_new := origin_x
  } Else If (x_new + w > real_width + origin_x) {
    x_new := real_width + origin_x - w
  }
  If (y_new < origin_y) {
    y_new := origin_y
  } Else If (y_new + h > real_height + origin_y) {
    y_new := real_height + origin_y - h
  }
  If (h_new > real_height) {
    h_new := real_height
  }
  If (w_new > real_width) {
    w_new := real_width
  }
  ; WinMove, ahk_id %move_window_id%, , x_new, y_new, w_new, h_new
  WinMove(x_new, y_new, w_new, h_new, win)
  x1 := x2
  y1 := y2
}

MonitorWorkArea() {
  Global origin_x
  Global origin_y
  Global real_width
  Global real_height
  loop MonitorGetCount() {
    MouseGetPos(&_temp_x, &_temp_y)
    MonitorGet(A_index, &monitor_left, &monitor_top, &monitor_right, &monitor_bottom)
    If (_temp_x >= monitor_left and _temp_x <= monitor_right and _temp_y >= monitor_top and _temp_y <= monitor_bottom) {
      MonitorGetWorkArea(A_index, &workarea_left, &workarea_top, &workarea_right, &workarea_bottom)
      origin_x := workarea_left
      origin_y := workarea_top
      real_width := workarea_right - workarea_left
      real_height := workarea_bottom - workarea_top
      If (workarea_left == 0) {
        origin_x := leftmargin
        real_width := workarea_right - workarea_left - leftmargin
      }
    }
  }
}

RButton & LButton:: {
  Global x1
  Global y1
  Global win
  Global x0
  Global y0
  Global w0
  Global h0
  Global title0
  MouseGetPos &x1, &y1, &win
  ; _max := WinGetMinMax(win)
  WinGetPos(&x0, &y0, &w0, &h0, win)
  title0 := WinGetTitle(win)
  Print([
    "x1: " . x1,
    "y1: " . y1,
    ; "win: " . win,
    ; "_max: " . _max,
    "x0: " . x0,
    "y0: " . y0,
    "w0: " . w0,
    "h0: " . h0,
    "title0: " . title0,
  ])
  MonitorWorkArea()
  SetTimer(MoveWindowWatcher, 10)
  SetTimer(Tooltip, -3000)
}
