#Requires AutoHotkey v2.0

A_HotkeyInterval := 2000 ; 默认
A_MaxHotkeysPerInterval := 1000 ; 2000ms内运行触发1000个按键

#Include %A_ScriptDir%\mouse\utils\utils.ahk
#Include %A_ScriptDir%\mouse\mouse.ahk

#Include %A_ScriptDir%\mouse\funcs\rbutton_pressed_win.ahk
#Include %A_ScriptDir%\mouse\directions\right_up.ahk
#Include %A_ScriptDir%\mouse\directions\right.ahk
#Include %A_ScriptDir%\mouse\directions\right_down.ahk

#Include %A_ScriptDir%\mouse\last.ahk

SetTimer(RButtonPressedWatcher, 10)

RButtonPressedWatcher() {
  If (RemoteDesktopActive()) {
    Return
  }
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

#HotIf Not RemoteDesktopActive()

RButton:: {
  RButtonDown()
}

~LButton & RButton:: {
  LButtonRButton()
  RButtonDown()
}

RButton Up:: {
  HideCircle()
  CallFunction()
  ResetWheelFlag()
  ResetMButtonFlag()
  ResetLButtonFlag()
  ResetWheelCount()
}

~RButton & WheelDown:: {
  RButtonWheelDown()
}

~RButton & WheelUp:: {
  RButtonWheelUp()
}

~WheelDown:: {
  WheelDownDo()
}

~WheelUp:: {
  WheelUpDo()
}

RButton & MButton:: {
  RButtonMButton()
}

RButton & LButton:: {
  RButtonLButton()
}

InitCircle()

#HotIf
