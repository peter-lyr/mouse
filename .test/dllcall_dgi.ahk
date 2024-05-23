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

; 设置混合模式为透明
DllCall("SetBkMode", "Ptr", hdc, "Int", 1) ; TRANSPARENT = 1

; 创建一个半透明的蓝色画刷
blueBrush := DllCall("CreateSolidBrush", "UInt", 0x007800FF) ; ARGB (120, 0, 0, 255)
; 选择蓝色画刷到DC并画外圆
DllCall("SelectObject", "Ptr", hdc, "Ptr", blueBrush)
DllCall("Ellipse", "Ptr", hdc, "Int", 50, "Int", 50, "Int", 250, "Int", 250)
; 删除蓝色画刷
DllCall("DeleteObject", "Ptr", blueBrush)

; 创建一个半透明的红色画刷
redBrush := DllCall("CreateSolidBrush", "UInt", 0x00780000) ; ARGB (120, 255, 0, 0)
; 选择红色画刷到DC并画内圆
DllCall("SelectObject", "Ptr", hdc, "Ptr", redBrush)
DllCall("Ellipse", "Ptr", hdc, "Int", 100, "Int", 100, "Int", 200, "Int", 200)
; 删除红色画刷
DllCall("DeleteObject", "Ptr", redBrush)

; 释放DC
DllCall("ReleaseDC", "Ptr", MyGui.Hwnd, "Ptr", hdc)

; ; 当窗口关闭时，退出脚本
; MyGui.OnEvent("Close", Func("GuiClose").Bind(MyGui))

; ; 关闭GUI的函数
; GuiClose(gui) {
;     gui.Destroy()
;     ExitApp
; }
