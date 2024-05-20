#Requires AutoHotkey v2.0

A_HotkeyInterval := 2000 ; 默认
A_MaxHotkeysPerInterval := 1000 ; 2000ms内运行触发1000个按键

#Include %A_ScriptDir%\mouse\utils\init.ahk
#Include %A_ScriptDir%\mouse\rbutton_pressed.ahk
#Include %A_ScriptDir%\mouse\layers\layer_1_right_up.ahk
#Include %A_ScriptDir%\mouse\funcs\rbutton_pressed_win.ahk

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
