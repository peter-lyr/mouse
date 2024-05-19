#Requires AutoHotkey v2.0

#Include %A_ScriptDir%\base.ahk
#Include %A_ScriptDir%\rbutton_pressed.ahk

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

SetTimer(RButtonPressedWatcher, 10)

RButtonPressedWatcher() {
  if (not RButtonIsPressed()) {
    Return
  }
  UpdateRbuttonPressPos2()
  PrintRButtonPos2()
}

~RButton:: {
  UpdateRbuttonPressPos1()
  PrintRButtonPos1()
  DrawCircleAtRbuttonPressPos1()
}
WinSetRegion
~RButton Up:: {
  HideCircle()
}

InitCircle()
