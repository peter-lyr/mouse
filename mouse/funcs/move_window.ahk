; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/22 00:22:59 星期三

; mw_: move window
; wa_: work area
; _m_: monitor
; _t_: temp
; _n_: new

WinGap := 40

ScaleStep := 100
ScaleMinWidth := 600
ScaleMinHeight := 400

GetWorkAreaXYWH(index, &wa_x, &wa_y, &wa_w, &wa_h) {
  MonitorGetWorkArea(index, &wa_left, &wa_top, &wa_right, &wa_bottom)
  wa_x := wa_left
  wa_y := wa_top
  wa_w := wa_right - wa_left
  wa_h := wa_bottom - wa_top
  If (wa_left == 0) {
    wa_x := left_margin
    wa_w := wa_right - wa_left - left_margin
  }
}

GetCurWorkAreaXYWH(x, y, &wa_x, &wa_y, &wa_w, &wa_h) {
  loop MonitorGetCount() {
    MonitorGet(A_index, &_m_left, &_m_top, &_m_right, &_m_bottom)
    If (x >= _m_left and x <= _m_right and y >= _m_top and y <= _m_bottom) {
      GetWorkAreaXYWH(A_index, &wa_x, &wa_y, &wa_w, &wa_h)
    }
  }
}

GetLastWorkAreaXYWH(x, y, &wa_x, &wa_y, &wa_w, &wa_h) {
  loop MonitorGetCount() {
    MonitorGet(A_index, &_m_left, &_m_top, &_m_right, &_m_bottom)
    If (x >= _m_left and x <= _m_right and y >= _m_top and y <= _m_bottom) {
      index := A_index + 1
      If (index > MonitorGetCount()) {
        index := 1
      }
      GetWorkAreaXYWH(index, &wa_x, &wa_y, &wa_w, &wa_h)
    }
  }
}

MoveWindowWatcher() {
  Global mw_x0, mw_y0, mw_w0, mw_h0, mw
  Global mw_x1, mw_y1, mw
  Global wa_x, wa_y, wa_w, wa_h
  If (Not RButtonIsPressed()) {
    WinMove(mw_x0, mw_y0, mw_w0, mw_h0, mw)
    SetTimer(MoveWindowWatcher, 0)
  }
  If (Not LButtonIsPressed()) {
    SetTimer(MoveWindowWatcher, 0)
  }

  MouseGetPos(&mw_x2, &mw_y2)
  WinGetPos(&_t_x, &_t_y, &_t_w, &_t_h, mw)

  _n_x := _t_x + mw_x2 - mw_x1
  _n_y := _t_y + mw_y2 - mw_y1
  _n_w := _t_w
  _n_h := _t_h
  mw_x1 := mw_x2
  mw_y1 := mw_y2

  If (GetWheelCount() == 1) {
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
  }
  If (_t_x != _n_x Or _t_y != _n_y) {
    WinMove(_n_x, _n_y, _n_w, _n_h, mw)
  }
}

MoveWindow() {
  Global mw_x0, mw_y0, mw_w0, mw_h0, mw
  Global mw_x1, mw_y1, mw
  Global wa_x, wa_y, wa_w, wa_h

  MouseGetPos(&mw_x1, &mw_y1, &mw)

  if (WinGetMinMax(mw)) {
    Return
  }

  WinActivate(mw)

  WinGetPos(&mw_x0, &mw_y0, &mw_w0, &mw_h0, mw)
  GetCurWorkAreaXYWH(mw_x1, mw_y1, &wa_x, &wa_y, &wa_w, &wa_h)

  SetTimer(MoveWindowWatcher, 10)
}

MoveWindowCurScreenMax() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  GetCurWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
  WinMove(wa_x, wa_y, wa_w, wa_h, "A")
}

MoveWindowNextScreenMax() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  GetLastWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
  WinMove(wa_x, wa_y, wa_w, wa_h, "A")
}

MoveWindowCurScreenLeft() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  GetCurWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
  WinMove(wa_x, wa_y, wa_w / 2 - WinGap, wa_h, "A")
}

MoveWindowCurScreenRight() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  GetCurWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
  WinMove(wa_x + wa_w / 2 + WinGap, wa_y, wa_w / 2 - WinGap, wa_h, "A")
}

MoveWindowCurScreenUp() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  GetCurWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
  WinMove(wa_x, wa_y, wa_w, wa_h / 2 - WinGap, "A")
}

MoveWindowCurScreenDown() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  GetCurWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
  WinMove(wa_x, wa_y + wa_h / 2 + WinGap, wa_w, wa_h / 2 - WinGap, "A")
}

MoveWindowCurScreenLeftUp() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  GetCurWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
  WinMove(wa_x, wa_y, wa_w / 2 - WinGap, wa_h / 2 - WinGap, "A")
}

MoveWindowCurScreenLeftDown() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  GetCurWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
  WinMove(wa_x, wa_y + wa_h / 2 + WinGap, wa_w / 2 - WinGap, wa_h / 2 - WinGap, "A")
}

MoveWindowCurScreenRightUp() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  GetCurWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
  WinMove(wa_x + wa_w / 2 + WinGap, wa_y, wa_w / 2 - WinGap, wa_h / 2 - WinGap, "A")
}

MoveWindowCurScreenRightDown() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  GetCurWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
  WinMove(wa_x + wa_w / 2 + WinGap, wa_y + wa_h / 2 + WinGap, wa_w / 2 - WinGap, wa_h / 2 - WinGap, "A")
}

MoveWindowCurScreenCenter() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  GetCurWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
  ; WinMove(wa_x + wa_w / 4 + WinGap, wa_y + wa_h / 4 + WinGap, wa_w / 2 - WinGap, wa_h / 2 - WinGap, "A")
  WinMove(wa_x + wa_w / 6 + WinGap, wa_y + wa_h / 6 + WinGap, wa_w * 2 / 3 - WinGap, wa_h * 2 / 3 - WinGap, "A")
}

ScaleWindowDecWidth() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  w := _mw_w0 - ScaleStep
  If w < ScaleMinWidth {
    w := ScaleMinWidth
  }
  WinMove(_mw_x0 , _mw_y0, w, _mw_h0, "A")
  WinGetPos(, , &w, , "A")
  WinMove(_mw_x0 + _mw_w0 / 2 - w / 2, _mw_y0, w, _mw_h0, "A")
}

ScaleWindowIncWidth() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  w := _mw_w0 + ScaleStep
  GetCurWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
  If w > wa_w {
    w := wa_w
  }
  WinMove(_mw_x0 + _mw_w0 / 2 - w / 2, _mw_y0, w, _mw_h0, "A")
}

ScaleWindowDecHeight() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  h := _mw_h0 - ScaleStep
  If h < ScaleMinHeight {
    h := ScaleMinHeight
  }
  WinMove(_mw_x0 , _mw_y0, _mw_w0, h, "A")
  WinGetPos(, , , &h, "A")
  WinMove(_mw_x0, _mw_y0 + _mw_h0 / 2 - h / 2, _mw_w0, h, "A")
}

ScaleWindowIncHeight() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  h := _mw_h0 + ScaleStep
  GetCurWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
  If h > wa_h {
    h := wa_h
  }
  WinMove(_mw_x0, _mw_y0 + _mw_h0 / 2 - h / 2, _mw_w0, h, "A")
}

MoveWindowRight() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  GetCurWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
  x := _mw_x0 + ScaleStep
  If x + _mw_w0 > wa_x + wa_w {
    x := wa_x + wa_w - _mw_w0
  }
  WinMove(x, _mw_y0, _mw_w0, _mw_h0, "A")
}

MoveWindowLeft() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  GetCurWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
  x := _mw_x0 - ScaleStep
  If x < wa_x {
    x := wa_x
  }
  WinMove(x, _mw_y0, _mw_w0, _mw_h0, "A")
}

MoveWindowDown() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  GetCurWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
  y := _mw_y0 + ScaleStep
  If y + _mw_h0 > wa_y + wa_h {
    y := wa_y + wa_h - _mw_h0
  }
  WinMove(_mw_x0, y, _mw_w0, _mw_h0, "A")
}

MoveWindowUp() {
  Global wa_x, wa_y, wa_w, wa_h
  WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, "A")
  If (WinGetMinMax("A") == 1) {
    WinRestore("A")
  }
  GetCurWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
  y := _mw_y0 - ScaleStep
  If y < wa_y {
    y := wa_y
  }
  WinMove(_mw_x0, y, _mw_w0, _mw_h0, "A")
}

#HotIf WinExist("ahk_exe emacs.exe")

Emacsframes := []
Emacsframes2 := []

CheckEmacs(wid) {
  Global wa_x, wa_y, wa_w, wa_h
  Global Emacsframes
  Global Emacsframes2
  Try {
    WinGetPos(&_x0, &_y0, &_w0, &_h0, wid)
    If (wa_x == _x0 And wa_y == _y0 And wa_w == _w0 And wa_h == _h0) {
      If (Not StrInArray(String(wid), Emacsframes)) {
        Emacsframes.Push(String(wid))
      } Else If (Not StrInArray(String(wid), Emacsframes2)) {
        Emacsframes2.Push(String(wid))
      }
    }
  }
}

EmacsFrameMoveWindowCurScreenMax() {
  Global Emacsframes
  Global Emacsframes2
  If (WinActive("ahk_exe emacs.exe")) {
    _wid := WinGetId("A")
    If (Not StrInArray(String(_wid), Emacsframes) Or Not StrInArray(String(_wid), Emacsframes2)) {
      MoveWindowCurScreenMax()
      SetTimer(() => CheckEmacs(_wid), 500)
    }
  }
}

SetTimer(EmacsFrameMoveWindowCurScreenMax, 5000)

#HotIf
