; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/25 13:44:04 Saturday

MouseActionFlagMax := 3
MouseActionFlag := 1
; 0: 鼠标右键没有功能
; 1: 鼠标右键有功能
; 2: 鼠标右键没有功能,但能显示每个位置功能
MouseActionFlagHotIf := 1

GetMouseActionFlag() {
  Global MouseActionFlag
  If (Not IsSet(MouseActionFlag)) {
    Return 1
  }
  Return MouseActionFlag
}

DisMouseActionFlag() {
  Global MouseActionFlag
  MouseActionFlag := 0
}

EnMouseActionFlag() {
  Global MouseActionFlag
  MouseActionFlag := 1
}

OnlyShowMouseActions() {
  Global MouseActionFlag
  MouseActionFlag := 2
  RButtonDownFake()
}

ToggleMouDrawCircleAtRbuttonPressPos1CntseActionFlagHotIf() {
  Global MouseActionFlagHotIf
  MouseActionFlagHotIf := 1 - MouseActionFlagHotIf
}

ToggleMouseActionFlag() {
  Global MouseActionFlag
  If (Not IsSet(MouseActionFlag)) {
    MouseActionFlag := 1
  }
  MouseActionFlag += 1
  If (MouseActionFlag >= MouseActionFlagMax) {
    MouseActionFlag := 0
  }
  If (MouseActionFlag == 2) {
    RButtonDownFake()
  } Else {
    HideCircle()
    SetTimer(RButtonPressedWatcherFake, 0)
  }
  If (MouseActionFlag == 0) {
    Print("Right Mouse Has No Function")
  } Else If (MouseActionFlag == 1) {
    Print("Right Mouse Has Function")
  } Else If (MouseActionFlag == 2) {
    Print("Right Mouse Has No Function, But Can Show")
  }
}

LButtonRButtonDisMouseActionFlag() {
  Global MouseActionFlag
  If (Not IsSet(MouseActionFlag) Or MouseActionFlag == 1) {
    Return
  }
  While (1) {
    If (Not RButtonIsPressed() And Not LButtonIsPressed()) {
      SetTimer(EnMouseActionFlag, -20)
      Break
    }
  }
}

^!t:: {
  ToggleMouseActionFlagHotIf()
}

^!s:: {
  ToggleMouseActionFlag()
}

^!r:: {
  CmdRunSilent(A_ScriptDir . "\mouse.exe")
  WinWaitActivate("ahk_exe mouse.exe")
  SetTimer(() => Send("{Space}"), -80)
}

^!c:: {
  CmdRunSilent(A_ScriptDir . "\ahk2exe.bat")
  ExitApp
}

^!m:: {
  CmdRunSilent("taskkill /f /im mouse.exe")
  CmdRunSilent("main.ahk")
  ExitApp
}

#HotIf A_IsCompiled
^!q::ExitApp
#HotIf Not A_IsCompiled
^+!q::ExitApp
#HotIf
