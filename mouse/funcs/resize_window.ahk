; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/22 23:02:09 星期三

; rw_: resize window
; _n_: new
; _c_: current
; _d_: direction

ResizeWindow() {
  MouseGetPos &rw_x1, &rw_y1, &rw
  If (WinGetMinMax(rw) == 1) {
    Return
  }
  WinGetPos(&_c_x, &_c_y, &_c_w, &_c_h, rw)
  WinGetPos(&rw_x0, &rw_y0, &rw_w0, &rw_h0, rw)
  _y1 := _c_h * (rw_x1 - _c_x) / _c_w + _c_y
  _y2 := _c_h * (_c_x - rw_x1) / _c_w + _c_y + _c_h
  If (rw_x1 < _c_x + _c_w / 3 or ((rw_y1 > _y1) and (rw_y1 < _y2))) {
    _d_left := 1
    _d_width := 1
    _d_x := 1
  } Else If (rw_x1 > _c_x + _c_w * 2 / 3 or ((rw_y1 < _y1) and (rw_y1 > _y2))) {
    _d_left := -1
    _d_width := 1
    _d_x := 0
  } Else {
    _d_left := 0
    _d_width := 0
    _d_x := 0
  }
  If (rw_y1 < _c_y + _c_h / 3 or ((rw_y1 < _y1) and (rw_y1 < _y2))) {
    _d_up := 1
    _d_height := 1
    _d_y := 1
  } Else If (rw_y1 > _c_y + _c_h * 2 / 3 or ((rw_y1 > _y1) and (rw_y1 > _y2))) {
    _d_up := -1
    _d_height := 1
    _d_y := 0
  } Else {
    _d_up := 0
    _d_height := 0
    _d_y := 0
  }
  Loop {
    If (RButtonIsPressed() == 0) {
      WinMove(rw_x0, rw_y0, rw_w0, rw_h0, rw)
      Break
    }
    If (MButtonIsPressed() == 0) {
      Break
    }
    MouseGetPos &rw_x2, &rw_y2
    WinGetPos(&_c_x, &_c_y, &_c_w, &_c_h, rw)
    rw_x2 -= rw_x1
    rw_y2 -= rw_y1
    _n_x := _c_x + rw_x2 * _d_x
    _n_y := _c_y + rw_y2 * _d_y
    _n_w := _c_w - rw_x2 * _d_left * _d_width
    _n_h := _c_h - rw_y2 * _d_up  * _d_height
    If (_c_x != _n_x Or _c_y != _n_y Or _c_w != _n_w Or _c_h != _n_h) {
      WinMove(_n_x, _n_y, _n_w, _n_h, rw)
    }
    rw_x1 := (rw_x2 + rw_x1)
    rw_y1 := (rw_y2 + rw_y1)
  }
}
