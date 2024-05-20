; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/20 14:18:09 Monday

Layer1RightDown_RButtonUp(just_info:=0) {
  If (just_info) {
    If (GetWheelFlag()) {
      Return "R: "
    }
    Return "R: WinMinimize"
  }
  If (GetWheelFlag()) {
    Return
  }
  WinMinimizeRbuttonPressWin()
}

Layer1RightDown_WheelUp(just_info:=0) {
  If (just_info) {
    Return "U: "
  }
}

Layer1RightDown_WheelDown(just_info:=0) {
  If (just_info) {
    Return "D: "
  }
}

Layer1RightDown() {
  If (RButtonIsPressed()) {
    If (GetWheelDownFlag()) {
      Layer1RightDown_WheelDown()
    } Else If (GetWheelUpFlag()) {
      Layer1RightDown_WheelUp()
    } Else {
      CheckPrint([
        Layer1RightDown_RButtonUp(1),
        Layer1RightDown_WheelUp(1),
        Layer1RightDown_WheelDown(1),
      ])
    }
  } Else {
    Layer1RightDown_RButtonUp()
  }
}

AddFunction(1, "right_down", Layer1RightDown)
