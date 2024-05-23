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

; s := ""
; Loop 11000 {
;   v := SysGet(A_Index)
;   If (Not v) {
;     Continue
;   }
;   s .= Format("{:04}", A_Index) . ":" . v . "`t`t"
;   If (A_Index / 5 == 0) {
;     s .= "`n"
;   }
; }
;
; MsgBox(s)

; ; 调用 GetSystemMetricsForDpi 获取系统缩放值
; nIndex := 0 ; 例如，获取屏幕宽度
; dpi := 96 ; 假设 DPI 为 96
; ; result := DllCall("user32\GetSystemMetricsForDpi", "Int", nIndex, "UInt", dpi)
; result := DllCall("user32\GetDC", "Int", nIndex, "UInt", dpi)
;
; ; 检查返回值
; if (result)
; {
;     MsgBox "系统缩放值为：" . result
; }
; else
; {
;     ; MsgBox "无法获取系统缩放值。错误代码：" . GetLastError()
; }



; ; 获取屏幕的设备上下文（DC）
; hdc := DllCall("user32\GetDC", "Ptr", 0)
;
; ; 获取物理屏幕的宽度和高度
; width := DllCall("gdi32\GetDeviceCaps", "Ptr", hdc, "Int", 8) ; HORZSIZE
; height := DllCall("gdi32\GetDeviceCaps", "Ptr", hdc, "Int", 10) ; VERTSIZE
;
; ; 释放设备上下文（DC）
; DllCall("user32\ReleaseDC", "Ptr", 0, "Ptr", hdc)
;
; ; 显示结果
; MsgBox "物理屏幕宽度：" . width . " 毫米，高度：" . height . " 毫米, hdc: " . hdc


; f8:: {
  ; 获取窗口的句柄（例如，通过 WinExist 或其他方法）
  ; hwnd := WinExist("A") ; 替换为您的窗口标题
  ; hwnd := WinExist("Program Manager") ; 替换为您的窗口标题
  hwnd := WinExist("ahk_class Shell_TrayWnd") ; 替换为您的窗口标题

  ; 调用 GetDpiForWindow 获取窗口的 DPI
  dpi := DllCall("user32\GetDpiForWindow", "Ptr", hwnd)

  ; 检查返回值
  if (dpi)
  {
      MsgBox "窗口的 DPI 值为：" . dpi
  }
  else
  {
      ; MsgBox "无法获取窗口的 DPI 值。错误代码：" . GetLastError()
  }
; }

^!+r::Reload
^!+q::ExitApp
