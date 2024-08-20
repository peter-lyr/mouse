; 测试捕获ClassNN，并画一个矩形
SetTitleMatchMode(2)
hwnd := WinGetId("ahk_exe Fileserv.exe")
controlList := WinGetControls(hwnd)

WinGetPos(&x0, &y0, , , hwnd)

Strip(text) {
  Return Trim(text, " `r`t`n")
}

Join(string_array, sep:="`n") {
  res := ""
  for index, value In string_array {
    res .= value . sep
  }
  Return Strip(res)
}

Msg(arr) {
  MsgBox(Join(arr))
}

for classnn in controlList
{
  Try {
    controlgetpos(&x, &y, &w, &h, classnn, hwnd)
    ; Msg([x0, y0, x, y, w, h])
  } Catch as e {
    MsgBox(type(classnn))
  }
  ; DrawRectangle(x0 + x, y0 + y, w, h)
  ; Break
}

DrawRectangle(x, y, w, h) {
  GuiOpt := "+LastFound +ToolWindow +AlwaysOnTop -Caption +Disabled"
  circle := Gui()
  circle.Opt(GuiOpt)
  circle.BackColor := "black"
  _show_wh := Format("X{:}Y{:}W{:}H{:}", x, y, w, h)
  circle.Show(_show_wh . " NA")
  WinSetTransparent(20, "Ahk_id " . circle.Hwnd)
  hdc := DllCall("GetDC", "Ptr", circle.Hwnd)
  DllCall("SetBkMode", "Ptr", hdc, "Int", 1)
  pen := DllCall("CreatePen", "Int", 0, "Int", 10, "UInt", 0X0000FF)
  DllCall("SelectObject", "Ptr", hdc, "Ptr", pen)
  DllCall("MoveToEx", "Ptr", hdc, "Int", 0,     "Int", 0, "Ptr", 0)
  DllCall("LineTo",   "Ptr", hdc, "Int", 0,     "Int", 0+h-1)
  DllCall("MoveToEx", "Ptr", hdc, "Int", 0,     "Int", 0+h-1, "Ptr", 0)
  DllCall("LineTo",   "Ptr", hdc, "Int", 0+w-1, "Int", 0+h-1)
  DllCall("MoveToEx", "Ptr", hdc, "Int", 0+w-1, "Int", 0+h-1, "Ptr", 0)
  DllCall("LineTo",   "Ptr", hdc, "Int", 0+w-1, "Int", 0)
  DllCall("MoveToEx", "Ptr", hdc, "Int", 0,     "Int", 0, "Ptr", 0)
  DllCall("LineTo",   "Ptr", hdc, "Int", 0+w-1, "Int", 0)
  DllCall("ReleaseDC", "Ptr", circle.Hwnd, "Ptr", hdc)
}
