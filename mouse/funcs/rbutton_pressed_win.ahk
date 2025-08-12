; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/20 14:10:22 Monday

WinMaximizeRestoreRbuttonPressWin() {
  _win := GetRbuttonPressWin()
  If (Not WinExist(_win)) {
    Return
  }
  If (WinGetMinMax(_win)) {
    WinRestore(_win)
  } Else {
    WinMaximize(_win)
    WinActivate(_win)
  }
}

WinMaximizeRestoreA() {
  If (WinGetMinMax("A")) {
    WinRestore("A")
  } Else {
    WinMaximize("A")
    WinActivate("A")
  }
}

WinMinimizeRestoreA_id := 0
WinMinimizeRestoreA_Restored := 0

WinMinimizeRestoreATimeOut() {
  Global WinMinimizeRestoreA_id
  WinMinimizeRestoreA_id := 0
}

WinMinimizeRestoreA() {
  If (WinActive(DesktopAhkClass)) {
    Return
  }
  Global WinMinimizeRestoreA_id
  Global WinMinimizeRestoreA_Restored
  If (WinMinimizeRestoreA_id == 0 Or WinMinimizeRestoreA_Restored == 1) {
    WinMinimizeRestoreA_id := WinGetId("A")
    WinMinimizeRestoreA_Restored := 0
    WinMinimize("A")
    SetTimer(WinMinimizeRestoreATimeOut, -3000)
  } Else {
    WinRestore(WinMinimizeRestoreA_id)
    WinActivate(WinMinimizeRestoreA_id)
    WinMinimizeRestoreA_Restored := 1
  }
}

WinMinimizeRbuttonPressWin() {
  _win := GetRbuttonPressWin()
  If (Not WinExist(_win)) {
    Return
  }
  WinMinimize(_win)
}

TransparentToggleRbuttonPressWin() {
  _win := GetRbuttonPressWin()
  If (Not WinExist(_win)) {
    Return
  }
  If (255 != WinGetTransparent(_win)) {
    WinSetTransparent(255, _win)
  } Else {
    WinSetTransparent(200, _win)
  }
  PrintLater("Transparent " . WinGetTransparent(_win))
}

TransparentDownCurWin() {
  _t := WinGetTransparent("A")
  If (_t == "") {
    _t := 255
  }
  _t -= 10
  If (_t < 10) {
    _t := 10
  }
  WinSetTransparent(_t, "A")
}

TransparentUpCurWin() {
  _t := WinGetTransparent("A")
  If (_t == "") {
    _t := 255
  }
  _t += 10
  If (_t > 255) {
    _t := 255
  }
  WinSetTransparent(_t, "A")
}

TransparentDownRbuttonPressWin() {
  _win := GetRbuttonPressWin()
  If (Not WinExist(_win)) {
    Return
  }
  _t := WinGetTransparent(_win)
  _t -= 10
  If (_t < 10) {
    _t := 10
  }
  WinSetTransparent(_t, _win)
  PrintLater("Transparent " . _t)
}

TransparentUpRbuttonPressWin() {
  _win := GetRbuttonPressWin()
  If (Not WinExist(_win)) {
    Return
  }
  _t := WinGetTransparent(_win)
  _t += 10
  If (_t > 255) {
    _t := 255
  }
  WinSetTransparent(_t, _win)
  PrintLater("Transparent " . _t)
}

TransparentToggleA() {
  If (255 != WinGetTransparent("A")) {
    WinSetTransparent(255, "A")
  } Else {
    WinSetTransparent(200, "A")
  }
  PrintLater("Transparent " . WinGetTransparent("A"))
}

TopMostToggleRbuttonPressWin() {
  _win := GetRbuttonPressWin()
  If (Not WinExist(_win)) {
    Return
  }
  WinSetAlwaysOnTop(-1, _win)
  ExStyle := WinGetExStyle(_win)
  if (ExStyle & 0x8) {
    PrintLater("Top Most")
  } Else {
    PrintLater("Top Most Canceled")
  }
}

TopMostToggleA() {
  WinSetAlwaysOnTop(-1, "A")
  ExStyle := WinGetExStyle("A")
  if (ExStyle & 0x8) {
    PrintLater("Top Most")
  } Else {
    PrintLater("Top Most Canceled")
  }
}

TryAltF4WinId := 0
TryAltF4WinProcessName := ""

KillIfStillExist() {
  Global TryAltF4WinId
  Global TryAltF4WinProcessName
  If (WinExist(TryAltF4WinId)) {
    WinKill(TryAltF4WinId)
  }
  If StrLower(TryAltF4WinProcessName) == "downloader.exe" {
    Run(Join([GetPy("25-del-Downfile-in-config.py"), "C:\nvenv\wk\Downloader_v3.3.7_内部版\Downloader_v3.3.7_内部版"], " "), , "Hide")
    Run(Join([GetPy("25-del-Downfile-in-config.py"), "C:\b\Downloader_v3.1.8_内部版"                                ], " "), , "Hide")
    Run(Join([GetPy("25-del-Downfile-in-config.py"), "C:\nvenv\wk\Downloader_v3.3.3"                                ], " "), , "Hide")
  }
  SetTimer(KillIfStillExist, 0)
}

ActivateAndAltF4UnderMouse() {
  Global TryAltF4WinId
  Global TryAltF4WinProcessName
  MouseGetPos , , &_win
  WinActivate(_win)
  WinWaitActive(_win)
  _process_name := WinGetProcessName(_win)
  If StrInArray(StrLower(_process_name), no_taskkill_processes) {
    If StrLower(_process_name) == "explorer.exe" {
      If WinActive(DesktopAhkClass) {
        Send("!{F4}")
      } Else {
        Send("^w")
      }
    } Else {
      Send("{Escape}")
    }
    Return
  }
  If WinActive("ahk_exe emacs.exe") {
    Send("^x")
    Send("^c")
  } Else If WinActive("ahk_class Progman") {
    ; 桌面
    Send("!{F4}")
  } Else {
    Send("!{F4}")
    TryAltF4WinId := _win
    TryAltF4WinProcessName := WinGetProcessName(TryAltF4WinId)
    SetTimer(KillIfStillExist, 1000)
  }
}

ActivateAndTaskKillUnderMouse() {
  MouseGetPos , , &_win
  _process_name := WinGetProcessName(_win)
  If StrInArray(StrLower(_process_name), no_taskkill_processes) {
    Return
  }
  Run('taskkill /f /im "' . _process_name . '"')
}

ActivateAndCtrlClickUnderMouse() {
  MouseGetPos &_x, &_y, &_win
  WinActivate(_win)
  WinWaitActive(_win)
  Send("^{Click " . _x . ", " . _y . "}")
}

ActivateAndShiftClickUnderMouse() {
  MouseGetPos &_x, &_y, &_win
  WinActivate(_win)
  WinWaitActive(_win)
  Send("+{Click " . _x . ", " . _y . "}")
}

^#l:: {
  TopMostToggleA()
}

^#;:: {
  TransparentToggleA()
}

^#k:: {
  WinMaximizeRestoreA()
}

^#j:: {
  WinMinimizeRestoreA()
}
