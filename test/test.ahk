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


; ; f8:: {
;   ; 获取窗口的句柄（例如，通过 WinExist 或其他方法）
;   ; hwnd := WinExist("A") ; 替换为您的窗口标题
;   ; hwnd := WinExist("Program Manager") ; 替换为您的窗口标题
;   hwnd := WinExist("ahk_class Shell_TrayWnd") ; 替换为您的窗口标题
;
;   ; 调用 GetDpiForWindow 获取窗口的 DPI
;   dpi := DllCall("user32\GetDpiForWindow", "Ptr", hwnd)
;
;   ; 检查返回值
;   if (dpi)
;   {
;       MsgBox "窗口的 DPI 值为：" . dpi
;   }
;   else
;   {
;       ; MsgBox "无法获取窗口的 DPI 值。错误代码：" . GetLastError()
;   }
; ; }

; GetSystemScreenDpi() {
;   hwnd := WinExist("ahk_class Shell_TrayWnd")
;   dpi := DllCall("user32\GetDpiForWindow", "Ptr", hwnd)
;   Return dpi And dpi Or 0
; }

; GuiOpt := "+LastFound +ToolWindow +AlwaysOnTop -Caption"
; ; GuiOpt := "+LastFound +ToolWindow +AlwaysOnTop -Caption +Disabled" ; Disabled 无法捕获消息,需要用到系统的钩子hook,但我不会用
; circle := Gui()
; circle.Opt(GuiOpt)
; circle_radius := 150
; max_circles := 6
; circle_diameter := circle_radius * max_circles * 2
; _show_wh := "W" . circle_diameter . " H" . circle_diameter
; circle.Show(_show_wh . " NA")
; WinSetRegion("0-0 " . _show_wh . " E", circle.Hwnd)
; OnMessage 0x0201, WM_LBUTTONDOWN
;
; WM_LBUTTONDOWN(wParam, lParam, msg, hwnd)
; {
;   X := lParam & 0xFFFF
;   Y := lParam >> 16
;   Control := ""
;   thisGui := GuiFromHwnd(hwnd)
;   thisGuiControl := GuiCtrlFromHwnd(hwnd)
;   if thisGuiControl {
;     thisGui := thisGuiControl.Gui
;     Control := "`n(in control " . thisGuiControl.ClassNN . ")"
;   }
;   ; ToolTip "You left-clicked in Gui window '" thisGui.Title "' at client coordinates " X "x" Y "." Control
;   ToolTip "You left-clicked in Gui window at client coordinates " X "x" Y "." Control
; }

; 钩子
; MouseProc(nCode, wParam, lParam) {
;   If (nCode >= 0 && wParam = 0x201) {
;     MsgBox("你点击了一个被禁用的窗口。")
;   }
;   Return DllCall("CallNextHookEx", "ptr", MouseClickHook, "int", nCode, "ptr", wParam, "ptr", lParam)
; }
;
; MouseClickHook := DllCall("SetWindowsHookEx", "int", 14, "ptr", Func("MouseProc").Bind(), "ptr", 0, "uint", DllCall("GetCurrentThreadId"))
; ; MsgBox("钩子已安装，现在即使窗口被禁用，也可以捕获鼠标点击。")

; sss() {
;   ; WinGetPos(&x, &y, &w, &h, "ahk_exe WindowsSandboxClient.exe")
;   ; Tooltip(WinGetMinMax("ahk_exe WindowsSandboxClient.exe") . "," . x . "," . y . ", " . w . "," . h)
;
;   ; WinGetPos(&x, &y, &w, &h, "A")
;   ; Tooltip(WinGetMinMax("A") . "," . x . "," . y . ", " . w . "," . h)
;
;   MouseGetPos , , &win
;   WinGetPos(&x, &y, &w, &h,win)
;   Tooltip(WinGetMinMax(win) . ". " . WinGetTitle(win) . ":" . x . "," . y . ", " . w . "," . h)
; }
;
; SetTimer sss, 100

Send("#r")

; ^!+r::Reload
; ^!+q::ExitApp
