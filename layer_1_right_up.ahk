; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/19 23:55:59 星期日

Layer1RightUp_Msg := Join([
  "Press   LButton: xxx",
  "Press   MButton: xxx",
  "Release RButton: xxx",
])

Layer1RightUp_LButton(ready:=0) {
}

Layer1RightUp_MButton(ready:=0) {
}

Layer1RightUp_RButtonUp(ready:=0) {
}

Layer1RightUp() {
  If (RButtonIsPressed()) {
    If (MButtonIsPressed()) {
      Layer1RightUp_MButton()
    } Else If (LButtonIsPressed()) {
      Layer1RightUp_LButton()
    } Else {
      CheckPrint(Layer1RightUp_Msg)
    }
  } Else {
    Layer1RightUp_RButtonUp()
  }
}

AddFunction(1, "right_up", Layer1RightUp)
