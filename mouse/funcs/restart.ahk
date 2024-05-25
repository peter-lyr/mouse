; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/25 13:44:04 Saturday

SuspendFlag := 0

GetSuspendFlag() {
  Global SuspendFlag
  Return SuspendFlag
}

DisSuspendFlag() {
  Global SuspendFlag
  SuspendFlag := 0
}

ToggleSuspendFlag() {
  Global SuspendFlag
  SuspendFlag := 1 - SuspendFlag
  Print("SuspendFlag: " . SuspendFlag)
}

LButtonRButtonDisSuspendFlag() {
  While (1) {
    If (Not RButtonIsPressed() And Not LButtonIsPressed()) {
      SetTimer(DisSuspendFlag, -20)
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

#HotIf A_IsCompiled
^!q::ExitApp
#HotIf Not A_IsCompiled
^+!q::ExitApp
#HotIf
