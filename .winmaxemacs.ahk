#Requires AutoHotkey v2.0

#Include %A_ScriptDir%\config.ahk

emacs := "ahk_exe emacs.exe"

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

WinGetPos(&_mw_x0, &_mw_y0, &_mw_w0, &_mw_h0, emacs)
If (WinGetMinMax(emacs) == 1) {
  WinRestore(emacs)
}
GetCurWorkAreaXYWH(_mw_x0 + _mw_w0 / 2, _mw_y0 + _mw_h0 / 2, &wa_x, &wa_y, &wa_w, &wa_h)
WinMove(wa_x, wa_y, wa_w, wa_h, emacs)
