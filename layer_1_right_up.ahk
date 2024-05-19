; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/19 23:55:59 星期日

Layer1RightUp_Msg := Join([
  ; "Press     LButton: xxx",
  ; "Press     MButton: xxx",
  "Release   RButton: xxx",
  "Wheel Scroll   Up: xxx",
  "Wheel Scroll Down: xxx",
])

; Layer1RightUp_LButton() {
; }
;
; Layer1RightUp_MButton() {
; }

Layer1RightUp_RButtonUp() {
  Tooltip
}

Layer1RightUp_WheelUp() {
  Print("Layer1RightUp_WheelUp")
}

Layer1RightUp_WheelDown() {
  Print("Layer1RightUp_WheelDown")
}

Layer1RightUp() {
  Global wheelup_flag
  Global wheeldown_flag
  if (not IsSet(wheeldown_flag)) {
    wheeldown_flag := 0
  }
  if (not IsSet(wheelup_flag)) {
    wheelup_flag := 0
  }
  If (RButtonIsPressed()) {
    ; If (MButtonIsPressed()) {
    ;   Layer1RightUp_MButton()
    ; } Else
    ; If (LButtonIsPressed()) {
    ;   Layer1RightUp_LButton()
    ; } Else
    If (wheelup_flag) {
      wheelup_flag := 0
      Layer1RightUp_WheelUp()
    } Else If (wheeldown_flag) {
      wheeldown_flag := 0
      Layer1RightUp_WheelDown()
    } Else {
      CheckPrint(Layer1RightUp_Msg)
    }
  } Else {
    Layer1RightUp_RButtonUp()
  }
}

AddFunction(1, "right_up", Layer1RightUp)