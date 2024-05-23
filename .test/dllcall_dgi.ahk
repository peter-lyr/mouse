; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/24 01:56:13 星期五

#Requires AutoHotkey v2.0


; 创建一个新的GUI对象
MyGui := Gui()

; ; 添加一个画布控件
; ; MyGui.Add("Graphic", "w300 h300", "MyGraphic")
; MyGui.Add("Picture", "w300 h300", "C:\Users\llydr\Pictures\photo_2024-03-05_01-55-39.jpg")
; ; MyGui.Add("Picture", "w300 h-1", "MyGraphic")
; ; MyGui.AddPicture("w300 h300", "MyGraphic")
;
; ; 显示GUI窗口
; ; MyGui.Show("w400 h400", "Draw Concentric Circles")
; MyGui.Show("w400 h400")

GuiOpt := "+LastFound +ToolWindow +AlwaysOnTop -Caption"
; MyGui := Gui()
MyGui.Opt(GuiOpt)
; MyGui.BackColor := "Red"
; MyGui.Show("NA")
MyGui.Show("w150 h150")
WinSetRegion("0-0 W300 H300 E", MyGui.Hwnd)
MyGui.Move(800, 300, 300, 300)
; WinSetTransparent(120, "Ahk_id " . MyGui.Hwnd)

; 获取画布的DC（设备上下文）
hdc := DllCall("GetDC", "Ptr", MyGui.Hwnd)

; 创建一个红色的画笔
redPen := DllCall("CreatePen", "Int", 0, "Int", 2, "UInt", 0xFF0000)
; 选择画笔到DC
oldPen := DllCall("SelectObject", "Ptr", hdc, "Ptr", redPen)

; 创建一个绿色的画笔
greenPen := DllCall("CreatePen", "Int", 0, "Int", 2, "UInt", 0x00FF00)
; 选择画笔到DC
DllCall("SelectObject", "Ptr", hdc, "Ptr", greenPen)

; 画第一个圆
DllCall("Ellipse", "Ptr", hdc, "Int", 50, "Int", 50, "Int", 250, "Int", 250)
; 画第二个圆（同心圆）
DllCall("Ellipse", "Ptr", hdc, "Int", 100, "Int", 100, "Int", 200, "Int", 200)

; 恢复原来的画笔
DllCall("SelectObject", "Ptr", hdc, "Ptr", oldPen)
; 删除创建的画笔
DllCall("DeleteObject", "Ptr", redPen)
DllCall("DeleteObject", "Ptr", greenPen)

; 释放DC
DllCall("ReleaseDC", "Ptr", MyGui.Hwnd, "Ptr", hdc)

; ; 当窗口关闭时，退出脚本
; MyGui.OnEvent("Close", Func("GuiClose").Bind(MyGui))

; ; 关闭GUI的函数
; GuiClose(gui) {
;     gui.Destroy()
;     ExitApp
; }
