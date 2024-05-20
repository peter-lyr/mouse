; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/19 23:55:59 星期日

Layer1RightUp_RButtonUp(just_info:=0) {
  If (just_info) {
    Return "Release   RButton: xxx"
  }
  Tooltip
}

Layer1RightUp_WheelUp(just_info:=0) {
  If (just_info) {
    Return "Wheel Scroll   Up: xxx"
  }
  Print("Layer1RightUp_WheelUp")
}

Layer1RightUp_WheelDown(just_info:=0) {
  If (just_info) {
    Return "Wheel Scroll Down: xxx"
  }
  Print("Layer1RightUp_WheelDown")
}

Layer1RightUp() {
  If (RButtonIsPressed()) {
    If (GetWheelDownFlag()) {
      Layer1RightUp_WheelUp()
    } Else If (GetWheelUpFlag()) {
      Layer1RightUp_WheelDown()
    } Else {
      CheckPrint([
        Layer1RightUp_RButtonUp(1),
        Layer1RightUp_WheelUp(1),
        Layer1RightUp_WheelDown(1),
      ])
    }
  } Else {
    Layer1RightUp_RButtonUp()
  }
}

AddFunction(1, "right_up", Layer1RightUp)
