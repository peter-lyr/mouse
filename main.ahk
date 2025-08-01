﻿#Requires AutoHotkey v2.0
#WinActivateForce ; 解决任务栏闪烁的问题

A_HotkeyInterval := 2000 ; 默认
A_MaxHotkeysPerInterval := 1000 ; 2000ms内运行触发1000个按键

MouseActionFlagHotIf := 1

MenuEn := 1

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
#Include %A_ScriptDir%\mouse\funcs\excel.ahk
#Include %A_ScriptDir%\mouse\funcs\excel_insert.ahk
#Include %A_ScriptDir%\mouse\funcs\excel_normal.ahk
#Include %A_ScriptDir%\mouse\funcs\msedge.ahk
#Include %A_ScriptDir%\mouse\funcs\wxwork.ahk
#Include %A_ScriptDir%\mouse\funcs\cycle_win.ahk
#Include %A_ScriptDir%\mouse\funcs\toggle.ahk
#Include %A_ScriptDir%\mouse\funcs\inputmethod.ahk
#Include %A_ScriptDir%\mouse\funcs\hjkl.ahk
#Include %A_ScriptDir%\mouse\funcs\switchwindow.ahk
#Include %A_ScriptDir%\mouse\funcs\movecursor.ahk
#Include %A_ScriptDir%\mouse\funcs\selclick.ahk
#Include %A_ScriptDir%\mouse\funcs\dl_click.ahk
#Include %A_ScriptDir%\mouse\funcs\7z.ahk
#Include %A_ScriptDir%\mouse\funcs\bins-to-file.ahk
#Include %A_ScriptDir%\mouse\funcs\copy-to-desktop.ahk

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
#Include %A_ScriptDir%\mouse\directions\1x1\left_down.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\up.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\side_left.ahk
#Include %A_ScriptDir%\mouse\directions\1x1\side_up.ahk

#Include %A_ScriptDir%\mouse\directions\1x2x1-ctrl.ahk
#Include %A_ScriptDir%\mouse\directions\1x2x2-shift.ahk
#Include %A_ScriptDir%\mouse\directions\1x2x3-ctrl-shift.ahk

RunSilent := "Hide"
; RunSilent := "Max"

Run(GetPy("input_method.py"), , RunSilent)
Run(GetPy("keyboard_mouse.py"), , RunSilent)
Run(GetPy("tts.py"), , RunSilent)

; Run(A_ScriptDir . "\py\keyboard_mouse.py", , "")

; ==============
; 自定义全局鼠标
; ==============

^!+CapsLock::CapsLock
CapsLock::Ctrl

#HotIf Not RemoteDesktopActiveOrRButtonPressed() And GetMouseActionFlag() And MouseActionFlagHotIf

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

; SetTimer(DetectInputMethod, 10)

#HotIf Not RemoteDesktopActiveOrRButtonPressed() And Not GetMouseActionFlag() And MouseActionFlagHotIf

~RButton & LButton::
~LButton & RButton:: {
  LButtonRButtonDisMouseActionFlag()
}

#HotIf

#HotIf MenuEn

; ==========
; 自定义菜单
; ==========

~Alt:: {
  MenuKeyCount()
  Excel_Alt()
}

~Alt Up:: {
  MenuKeyUp()
}

#HotIf Not (WinActive("ahk_exe EXCEL.EXE") Or WinActive("ahk_exe wps.exe"))

^Space:: {
  ToggleHJKL()
}

#HotIf

; ===============
; 去除搜狗广告弹窗（尝试），downloader多开
; ===============

^!l:: {
  Send("^#{Right}")
}

^!h:: {
  Send("^#{Left}")
}

#HotIf WinExist("ahk_exe ShellExperienceHost.exe")

ShouldDownloaderY() {
  win_title := WinGetTitle("ahk_class #32770 ahk_exe Downloader.exe")
  If (win_title != "Error" And win_title != "Downloader") {
    Return 0
  }
  Return 1
}

DetectSomeWins() {
  If WinExist("ahk_exe ShellExperienceHost.exe") {
    WinKill("ahk_exe ShellExperienceHost.exe")
  }
  If WinExist("Error ahk_exe Downloader.exe") {
    If (!ShouldDownloaderY()) {
      Return
    }
    WinActivate("Error ahk_exe Downloader.exe")
    WinWaitActive("Error ahk_exe Downloader.exe")
    WinWaitActive("Error ahk_exe Downloader.exe")
    Send("!y")
  }
  If WinExist("ahk_class #32770 ahk_exe Downloader.exe") { ; 关闭保持
    If (!ShouldDownloaderY()) {
      Return
    }
    WinActivate("ahk_class #32770 ahk_exe Downloader.exe")
    WinWaitActive("ahk_class #32770 ahk_exe Downloader.exe")
    WinWaitActive("ahk_class #32770 ahk_exe Downloader.exe")
    Send("!y")
    If WinExist("ahk_class #32770 ahk_exe Downloader.exe") {
      Send("{Space}")
    }
  }
}

SetTimer(DetectSomeWins, 1000)

WinSetTransparent(182, "ahk_class Shell_TrayWnd")

#HotIf
