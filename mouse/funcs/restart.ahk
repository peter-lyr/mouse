; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/25 13:44:04 Saturday

#HotIf A_IsCompiled
^!q::ExitApp
#HotIf Not A_IsCompiled
^+!q::ExitApp
#HotIf

SuspendFlag := 0

GetSuspendFlag() {
  Global SuspendFlag
  Return SuspendFlag
}

ToggleSuspendFlag() {
  Global SuspendFlag
  SuspendFlag := 1 - SuspendFlag
  Print("SuspendFlag: " . SuspendFlag)
}

LButtonRButtonDisSuspendFlag() {
  While (1) {
    If (Not RButtonIsPressed() And Not LButtonIsPressed()) {
      SuspendFlag := 0
      Break
    }
  }
}

^!s:: {
  ToggleSuspendFlag()
}

^!r::Reload

^!c:: {
  Run(A_ScriptDir . "\ahk2exe.bat")
  ExitApp
}
