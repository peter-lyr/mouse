; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/19 17:22:08 星期日

rbutton_press_x1 := 0
rbutton_press_y1 := 0

circle_transparent := 50

gui_list := []

circle_nums := 3

circle_sizes := [200, 500, 800]

circle_colors := ["Red", "Blue", "Green"]

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

DrawCircleAtRbuttonPressPos1() {
  for index, value in gui_list {
    WinSetRegion("0-0 W" . circle_sizes[index] . " H" . circle_sizes[index] . " E", "ahk_id " . value.Hwnd)
    x := (rbutton_press_x1-circle_sizes[index]/2)/2
    y := (rbutton_press_y1-circle_sizes[index]/2)/2
    value.Move(x, y, circle_sizes[index]/2, circle_sizes[index]/2)
    WinSetTransparent(circle_transparent, "ahk_id " . value.Hwnd)
  }
}

HideCircle() {
  for index, value in gui_list {
    WinSetTransparent(0, "ahk_id " . value.Hwnd)
  }
}

InitCircle() {
  Loop circle_nums {
    MyGui := Gui("+LastFound +ToolWindow +AlwaysOnTop -Caption")
    MyGui.BackColor := circle_colors[A_index]
    MyGui.Show("NA")
    WinSetRegion("0-0 W0 H0 E", "ahk_id " . MyGui.Hwnd)
    WinSetTransparent(circle_transparent, "ahk_id " . MyGui.Hwnd)
    gui_list.Push(MyGui)
  }
}
