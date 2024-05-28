; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/28 09:59:12 Tuesday

#Requires AutoHotkey v2.0

GuiOpt := "+LastFound +ToolWindow +AlwaysOnTop -Caption"
circle_diameter := 300
circle := Gui()
circle.Opt(GuiOpt)
_show_wh := "W" . circle_diameter . " H" . circle_diameter
circle.Show(_show_wh . " NA")
WinSetRegion("0-0 " . _show_wh . " E", circle.Hwnd)
; WinSetTransparent(0, "Ahk_id " . circle.Hwnd)
OnMessage 0x0201, WM_LBUTTONDOWN

WM_LBUTTONDOWN(wParam, lParam, msg, hwnd) {
  X := lParam & 0xFFFF
  Y := lParam >> 16
  Control := ""
  thisGui := GuiFromHwnd(hwnd)
  thisGuiControl := GuiCtrlFromHwnd(hwnd)
  if thisGuiControl {
      thisGui := thisGuiControl.Gui
      Control := "`n(in control " . thisGuiControl.ClassNN . ")"
  }
  ToolTip "You left-clicked in Gui window at client coordinates " X "x" Y "." Control
  Return
}

^!+r::Reload
^!+q::ExitApp
