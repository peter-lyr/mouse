; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/25 13:44:04 Saturday

MouseActionFlagMax := 3
MouseActionFlag := 1
; 0: 鼠标右键没有功能
; 1: 鼠标右键有功能
; 2: 鼠标右键没有功能,但能显示每个位置功能

GetMouseActionFlag() {
  Global MouseActionFlag
  Return MouseActionFlag
}

DisMouseActionFlag() {
  Global MouseActionFlag
  MouseActionFlag := 0
}

ToggleMouseActionFlag() {
  Global MouseActionFlag
  MouseActionFlag += 1
  If (MouseActionFlag > MouseActionFlagMax) {
    MouseActionFlag := 1
  }
  Print("MouseActionFlag: " . MouseActionFlag)
}

LButtonRButtonDisMouseActionFlag() {
  While (1) {
    If (Not RButtonIsPressed() And Not LButtonIsPressed()) {
      SetTimer(DisMouseActionFlag, -20)
      Break
    }
  }
}

^!s:: {
  ToggleMouseActionFlag()
}

^!r::Reload

^!c:: {
  Run(A_ScriptDir . "\ahk2exe.bat")
  ExitApp
}

#HotIf A_IsCompiled
^!q::ExitApp
#HotIf Not A_IsCompiled
^+!q::ExitApp
#HotIf
