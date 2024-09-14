#Requires AutoHotkey v2.0
#WinActivateForce ; 解决任务栏闪烁的问题

A_HotkeyInterval := 2000 ; 默认
A_MaxHotkeysPerInterval := 1000 ; 2000ms内运行触发1000个按键

SetWinDelay(0)

CoordMode("Mouse", "Screen")
CoordMode("Pixel", "Screen")

#Include %A_ScriptDir%\mouse\funcs\utils.ahk
#Include %A_ScriptDir%\config.ahk
#Include %A_ScriptDir%\mouse\init.ahk
#Include %A_ScriptDir%\mouse\menu.ahk

#Include %A_ScriptDir%\mouse\funcs\move_window.ahk
#Include %A_ScriptDir%\mouse\funcs\resize_window.ahk
#Include %A_ScriptDir%\mouse\funcs\rbutton_pressed_win.ahk
#Include %A_ScriptDir%\mouse\funcs\copy.ahk
#Include %A_ScriptDir%\mouse\funcs\navigate.ahk
#Include %A_ScriptDir%\mouse\funcs\restart.ahk
#Include %A_ScriptDir%\mouse\funcs\nvim-qt.ahk
#Include %A_ScriptDir%\mouse\funcs\explorer.ahk
#Include %A_ScriptDir%\mouse\funcs\msedge.ahk
#Include %A_ScriptDir%\mouse\funcs\wxwork.ahk
#Include %A_ScriptDir%\mouse\funcs\cycle_win.ahk
#Include %A_ScriptDir%\mouse\funcs\toggle.ahk
#Include %A_ScriptDir%\mouse\funcs\inputmethod.ahk
#Include %A_ScriptDir%\mouse\funcs\hjkl.ahk
#Include %A_ScriptDir%\mouse\funcs\switchwindow.ahk
#Include %A_ScriptDir%\mouse\funcs\movecursor.ahk
#Include %A_ScriptDir%\mouse\funcs\selclick.ahk

#Include %A_ScriptDir%\mouse\funcs\test-funcs.ahk
#Include %A_ScriptDir%\mouse\funcs\test.ahk

#Include %A_ScriptDir%\mouse\funcs\works\cbp_build.ahk
#Include %A_ScriptDir%\mouse\funcs\works\fileserv.ahk
#Include %A_ScriptDir%\mouse\funcs\works\search_app_dcf.ahk

#Include %A_ScriptDir%\mouse\directions\1x1\right.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\right_up.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\right_down.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\down.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\left.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\left_up.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\up.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\side_left.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\side_up.ahk

#Include %A_ScriptDir%\mouse\directions\1x2x1-ctrl.ahk
#Include %A_ScriptDir%\mouse\directions\1x2x2-shift.ahk
#Include %A_ScriptDir%\mouse\directions\1x2x3-ctrl-shift.ahk

; ==============
; 自定义全局鼠标
; ==============

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

~MButton Up:: {
  MButtonUp()
}

RButton & MButton:: {
  RButtonMButton()
}

RButton & LButton:: {
  RButtonLButton()
  LButtonRButtonDisMouseActionFlag()
}

InitCircle()

SetTimer(DetectInputMethod, 10)

#HotIf Not RemoteDesktopActiveOrRButtonPressed() And Not GetMouseActionFlag()

~RButton & LButton::
~LButton & RButton:: {
  LButtonRButtonDisMouseActionFlag()
}

#HotIf

; ==========
; 自定义菜单
; ==========

~Alt:: {
  MenuKeyCount()
}

~Alt Up:: {
  MenuKeyUp()
}

!Space:: {
  ToggleHJKL()
}
