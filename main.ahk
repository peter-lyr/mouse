#Requires AutoHotkey v2.0

A_HotkeyInterval := 2000 ; 默认
A_MaxHotkeysPerInterval := 1000 ; 2000ms内运行触发1000个按键

SetWinDelay(0)

CoordMode("Mouse", "Screen")
CoordMode("Pixel", "Screen")

#Include %A_ScriptDir%\mouse\funcs\utils.ahk
#Include %A_ScriptDir%\mouse\config.ahk
#Include %A_ScriptDir%\mouse\init.ahk

#Include %A_ScriptDir%\mouse\funcs\move_window.ahk
#Include %A_ScriptDir%\mouse\funcs\rbutton_pressed_win.ahk
#Include %A_ScriptDir%\mouse\directions\right_up.ahk
#Include %A_ScriptDir%\mouse\directions\right_down.ahk
#Include %A_ScriptDir%\mouse\directions\left.ahk

#Include %A_ScriptDir%\mouse\last.ahk

SetTimer(RButtonPressedWatcher, 10)

RButtonPressedWatcher() {
  If (RemoteDesktopActiveOrRButtonPressed()) {
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

#HotIf Not RemoteDesktopActiveOrRButtonPressed()

RButton:: {
  RButtonDown()
}

~LButton & RButton:: {
  LButtonRButton()
}

~LButton:: {
  LButtonDown()
}

RButton Up:: {
  RButtonUp()
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
