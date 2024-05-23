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
; WinSetRegion("0-0 W500 H500 E", MyGui.Hwnd)
MyGui.Move(800, 200, 150, 150)
; WinSetTransparent(120, "Ahk_id " . MyGui.Hwnd)

; 获取画布的DC（设备上下文）
hdc := DllCall("GetDC", "Ptr", MyGui.Hwnd)

; 设置混合模式为透明
DllCall("SetBkMode", "Ptr", hdc, "Int", 1) ; TRANSPARENT = 1

; 定义颜色数组
colors := [0x007800FF, 0x0078FF00, 0x00780000, 0x00FFFF00, 0x00FF00FF]

; 循环绘制同心圆，从最大到最小
Loop 5 {
    ; 创建半透明的画刷
    brush := DllCall("CreateSolidBrush", "UInt", colors[6-A_Index])
    ; 选择画刷到DC
    DllCall("SelectObject", "Ptr", hdc, "Ptr", brush)
    ; 绘制圆
    radius := 150 - (A_Index - 1) * 20
    DllCall("Ellipse", "Ptr", hdc, "Int", 150 - radius, "Int", 150 - radius, "Int", 150 + radius, "Int", 150 + radius)
    ; 删除画刷
    DllCall("DeleteObject", "Ptr", brush)
}

; 释放DC
DllCall("ReleaseDC", "Ptr", MyGui.Hwnd, "Ptr", hdc)

; ; 当窗口关闭时，退出脚本
; MyGui.OnEvent("Close", Func("GuiClose").Bind(MyGui))

; ; 关闭GUI的函数
; GuiClose(gui) {
;     gui.Destroy()
;     ExitApp
; }

^!+r::Reload
^!+q::ExitApp
