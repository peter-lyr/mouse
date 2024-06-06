; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/24 23:00:00 星期五

#Requires AutoHotkey v2.0

GetSystemScreenDpi() {
  hwnd := WinExist("ahk_class Shell_TrayWnd")
  dpi := DllCall("user32\GetDpiForWindow", "Ptr", hwnd)
  Return dpi And dpi Or 0
}

dpi := GetSystemScreenDpi()

MyGui := Gui()
GuiOpt := "+LastFound +ToolWindow +AlwaysOnTop -Caption +Disabled"
; MyGui := Gui()
MyGui.Opt(GuiOpt)
; MyGui.BackColor := "Red"
; MyGui.Show("NA")

radius := 150
diameter := radius * 2
_show_opt := "W" . diameter * dpi / 96 . " H" . diameter * dpi / 96

_diff := diameter*Tan(0.017453292519943295*22.5)
_diff_short := diameter-_diff
_diff_long := diameter+_diff

MyGui.Show(_show_opt . " NA")
WinSetRegion("0-0 " . _show_opt . " E", MyGui.Hwnd)
MyGui.Move(800, 200, diameter, diameter)
WinSetTransparent(20, "Ahk_id " . MyGui.Hwnd)

; 获取图形控件的HDC（设备上下文句柄）
; hdc := MyGui["MyGraphic"].HDC
hdc := DllCall("GetDC", "Ptr", MyGui.Hwnd)

; 创建一个红色的画笔
redPen := DllCall("CreatePen", "Int", 0, "Int", 2, "UInt", 0xFF0000)

; 选择画笔到HDC
; oldPen := DllCall("SelectObject", "Ptr", hdc, "Ptr", redPen)
DllCall("SelectObject", "Ptr", hdc, "Ptr", redPen)

; Loop 8 {
;   ; 移动到起始点（50,50）
;   DllCall("MoveToEx", "Ptr", hdc, "Int", 0, "Int", 0, "Ptr", 0)
;
;   ; 绘制到结束点（200,200），从而绘制一条直线
;   DllCall("LineTo", "Ptr", hdc, "Int", 600, "Int", 600)
; }


; 移动到起始点（50,50）
DllCall("MoveToEx", "Ptr", hdc, "Int", _diff_short, "Int", 0, "Ptr", 0)

; 绘制到结束点（200,200），从而绘制一条直线
DllCall("LineTo", "Ptr", hdc, "Int", _diff_long, "Int", diameter * dpi / 96)


; 移动到起始点（50,50）
DllCall("MoveToEx", "Ptr", hdc, "Int", _diff_long, "Int", 0, "Ptr", 0)

; 绘制到结束点（200,200），从而绘制一条直线
DllCall("LineTo", "Ptr", hdc, "Int", _diff_short, "Int", diameter * dpi / 96)


; 移动到起始点（50,50）
DllCall("MoveToEx", "Ptr", hdc, "Int", 0, "Int", _diff_short, "Ptr", 0)

; 绘制到结束点（200,200），从而绘制一条直线
DllCall("LineTo", "Ptr", hdc, "Int", diameter * dpi / 96, "Int", _diff_long)


; 移动到起始点（50,50）
DllCall("MoveToEx", "Ptr", hdc, "Int", 0, "Int", _diff_long, "Ptr", 0)

; 绘制到结束点（200,200），从而绘制一条直线
DllCall("LineTo", "Ptr", hdc, "Int", diameter * dpi / 96, "Int", _diff_short)

; MsgBox(Integer(150-150*Tan(0.017453292519943295*22.5)))


; ; 恢复旧的画笔
; DllCall("SelectObject", "Ptr", hdc, "Ptr", oldPen)

; ; 删除创建的红色画笔
; DllCall("DeleteObject", "Ptr", redPen)

; 更新GUI
; MyGui["MyGraphic"].Redraw()

^!+r::Reload
^!+q::ExitApp
