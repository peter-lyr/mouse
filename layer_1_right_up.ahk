; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/19 23:55:59 星期日

Layer1RightUp_RButtonUp(just_info:=0) {
  If (just_info) {
    Return "R: xxx"
  }
  Tooltip
}

Layer1RightUp_WheelUp(just_info:=0) {
  If (just_info) {
    Return "U: Volume_Up"
  }
  Send "{Volume_Up}"
}

Layer1RightUp_WheelDown(just_info:=0) {
  If (just_info) {
    Return "D: Volume_Down"
  }
  Send "{Volume_Down}"
}

Layer1RightUp() {
  If (RButtonIsPressed()) {
    If (GetWheelDownFlag()) {
      Layer1RightUp_WheelDown()
    } Else If (GetWheelUpFlag()) {
      Layer1RightUp_WheelUp()
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
