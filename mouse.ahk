#Requires AutoHotkey v2.0

A_HotkeyInterval := 2000 ; 默认
A_MaxHotkeysPerInterval := 1000 ; 2000ms内运行触发1000个按键

#Include %A_ScriptDir%\mouse\utils\init.ahk
#Include %A_ScriptDir%\mouse\init.ahk

#Include %A_ScriptDir%\mouse\layers\layer1.ahk
#Include %A_ScriptDir%\mouse\funcs\rbutton_pressed_win.ahk

#Include %A_ScriptDir%\mouse\last.ahk

SetTimer(RButtonPressedWatcher, 10)

RButtonPressedWatcher() {
  _temp := GetLMButtonFlag()
  If (Not RButtonIsPressed() Or _temp) {
    If (_temp == 1) {
      IncLMButtonFlag()
      Tooltip
      HideCircle()
    }
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
  ResetWheelFlag()
  ResetMButtonFlag()
  ResetLButtonFlag()
}

~RButton & WheelDown:: {
  RButtonWheelDown()
}

~RButton & WheelUp:: {
  RButtonWheelUp()
}

RButton & MButton:: {
  RButtonMButton()
}

RButton & LButton:: {
  RButtonLButton()
}

InitCircle()
