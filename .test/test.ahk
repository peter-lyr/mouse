; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/19 18:03:22 星期日

#Requires AutoHotkey v2.0

; ; 在任务栏上滚动鼠标滚轮来调节音量
; #HotIf MouseIsOver("ahk_class Shell_TrayWnd")
; WheelUp::Send "{Volume_Up}"
; WheelDown::Send "{Volume_Down}"
; #HotIf

; f8:: {
;   ; send "{Enter}"
;     Print()
; }

; Print()

MouseGetPos &x1, &y1
MsgBox(PixelGetColor(x1, y1))
