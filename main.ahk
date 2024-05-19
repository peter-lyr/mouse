#Requires AutoHotkey v2.0

A_HotkeyInterval := 2000 ; 默认
A_MaxHotkeysPerInterval := 1000 ; 2000ms内运行触发1000个按键

#Include %A_ScriptDir%\base.ahk
#Include %A_ScriptDir%\rbutton_pressed.ahk
#Include %A_ScriptDir%\layer_1_right_up.ahk

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
  If (Not RButtonIsPressed()) {
    Return
  }
  UpdateRbuttonPressPos2()
  GetPos1StateFromPos2()
}

RButton:: {
  UpdateRbuttonPressPos1()
  DrawCircleAtRbuttonPressPos1()
}

RButton Up:: {
  HideCircle()
  CallFunction()
}

~RButton & WheelDown:: {
  RButtonWheelDown()
}

~RButton & WheelUp:: {
  RButtonWheelUp()
}

InitCircle()
