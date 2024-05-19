#Requires AutoHotkey v2.0

#Include %A_ScriptDir%\base.ahk

; 在任务栏上滚动鼠标滚轮来调节音量
#HotIf MouseIsOver("ahk_class Shell_TrayWnd")
WheelUp::Send "{Volume_Up}"
WheelDown::Send "{Volume_Down}"
#HotIf

; f8:: {
;   ; send "{Enter}"
;     Print()
; }
;
; Print()

~RButton:: {
  Print()
}

~RButton Up:: {
  Tooltip
}
