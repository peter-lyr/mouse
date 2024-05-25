﻿#Requires AutoHotkey v2.0

A_HotkeyInterval := 2000 ; 默认
A_MaxHotkeysPerInterval := 1000 ; 2000ms内运行触发1000个按键

SetWinDelay(0)

CoordMode("Mouse", "Screen")
CoordMode("Pixel", "Screen")

#Include %A_ScriptDir%\mouse\funcs\utils.ahk
#Include %A_ScriptDir%\mouse\config.ahk
#Include %A_ScriptDir%\mouse\init.ahk

#Include %A_ScriptDir%\mouse\funcs\move_window.ahk
#Include %A_ScriptDir%\mouse\funcs\resize_window.ahk
#Include %A_ScriptDir%\mouse\funcs\rbutton_pressed_win.ahk
#Include %A_ScriptDir%\mouse\funcs\copy.ahk
#Include %A_ScriptDir%\mouse\funcs\navigate.ahk
#Include %A_ScriptDir%\mouse\funcs\restart.ahk

#Include %A_ScriptDir%\mouse\directions\1x1\right.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\right_up.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\right_down.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\left.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\left_up.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\up.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\side_left.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\side_up.ahk

#HotIf Not RemoteDesktopActiveOrRButtonPressed() And GetMouseActionFlag()

RButton:: {
  RButtonDown()
}

~LButton & RButton:: {
  LButtonRButton()
  LButtonRButtonDisMouseActionFlag()
}

~LButton:: {
  LButtonDown()
}

~LButton Up:: {
  LButtonUp()
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

~MButton:: {
  MButtonDown()
}

RButton & MButton:: {
  RButtonMButton()
}

RButton & LButton:: {
  RButtonLButton()
  LButtonRButtonDisMouseActionFlag()
}

InitCircle()

#HotIf Not RemoteDesktopActiveOrRButtonPressed() And Not GetMouseActionFlag()

~RButton & LButton::
~LButton & RButton:: {
  LButtonRButtonDisMouseActionFlag()
}

#HotIf
