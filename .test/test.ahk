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

; MouseGetPos &x1, &y1
; color := Integer(PixelGetColor(x1, y1))
; MsgBox(color & 0xff + (color >> 8) & 0xff + (color >> 16) & 0xff)

; ; function wrap
;
; Test(tt) {
;   temp() {
;     Tooltip ">>>>" . tt . ">>>"
;   }
;   return temp
; }
;
; f8:: {
;   Test("ver")()
; }

; ; Func
; Temp__() {
;   Tooltip ">>>>"
; }
;
; MsgBox(Type(Temp__)) ; Func

; ; 匿名函数
; Strip(text) {
;   Return Trim(text, " `r`t`n")
; }
;
; Join(string_array, sep:="`n") {
;   res := ""
;   for index, value in string_array {
;     if (Type(value) == "Func") {
;       res .= Type(value) . sep
;     } else {
;       res .= String(value) . sep
;     }
;   }
;   Return Strip(res)
; }
;
; a(arr) {
; }
;
; b := [
;   "ww", () => {
;     Send("{Enter}")
;   },
;   "ii", () => Send("{Enter}"),
; ]
;
; MsgBox(Join(b))

; ; 匿名函数
; a := () => [
;   Tooltip(">>>>"),
;   MsgBox("iiii"),
; ]
; ; MsgBox(Type(a))
; a()

; ^+c:: {
;   A_Clipboard := "" ; 清空剪贴板
;   Send("^c")
;   ClipWait
;   Tooltip(A_Clipboard . ">>>")
;   ; SetTimer () => [Tooltip(A_Clipboard . ">>>")], -100
; }

; Loop Parse A_Clipboard, "`n", "`r"
; {
;     Result := MsgBox("File number " A_Index " is " A_LoopField ".`n`nContinue?",, 4)
;     if Result = "No"
;         break
; }
