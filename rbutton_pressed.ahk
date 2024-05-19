; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/19 17:22:08 星期日

rbutton_press_x1 := 0
rbutton_press_y1 := 0

UpdateRbuttonPressPos1() {
  Global rbutton_press_x1
  Global rbutton_press_y1
  CoordMode "Mouse", "Screen"
  MouseGetPos &rbutton_press_x1, &rbutton_press_y1
}

UpdateRbuttonPressPos2() {
  Global rbutton_press_x2
  Global rbutton_press_y2
  CoordMode "Mouse", "Screen"
  MouseGetPos &rbutton_press_x2, &rbutton_press_y2
}

PrintRButtonPos1() {
  Global rbutton_press_x1
  Global rbutton_press_y1
  Print(rbutton_press_x1 . ', ' . rbutton_press_y1)
}

PrintRButtonPos2() {
  Global rbutton_press_x2
  Global rbutton_press_y2
  PrintAppendEnd(rbutton_press_x2-rbutton_press_x1 . ', ' . rbutton_press_y2-rbutton_press_y1)
}
