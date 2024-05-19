; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/19 17:22:08 星期日

rbutton_press_x1 := 0
rbutton_press_y1 := 0

circle_transparent := 50

circle_size_1 := 200
circle_size_2 := 500
circle_size_3 := 800

circle_color_1 := "Red"
circle_color_2 := "Blue"
circle_color_3 := "Green"

GuiList := []

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
  for index, value in GuiList {
    WinSetRegion("0-0 W" . circle_sizes[index] . " H" . circle_sizes[index] . " E", "ahk_id " . value.Hwnd)
    x := (rbutton_press_x1-circle_sizes[index]/2)/2
    y := (rbutton_press_y1-circle_sizes[index]/2)/2
    value.Move(x, y, circle_sizes[index]/2, circle_sizes[index]/2)
    WinSetTransparent(circle_transparent, "ahk_id " . value.Hwnd)
  }
  ; global MyGui1
  ; WinSetRegion("0-0 W" . circle_size_1 . " H" . circle_size_1 . " E", "ahk_id " . MyGui1.Hwnd)
  ; x := (rbutton_press_x1-circle_size_1/2)/2
  ; y := (rbutton_press_y1-circle_size_1/2)/2
  ; MyGui1.Move(x, y, circle_size_1/2, circle_size_1/2)
  ; WinSetTransparent(circle_transparent, "ahk_id " . MyGui1.Hwnd)
  ; global MyGui2
  ; WinSetRegion("0-0 W" . circle_size_2 . " H" . circle_size_2 . " E", "ahk_id " . MyGui2.Hwnd)
  ; x := (rbutton_press_x1-circle_size_2/2)/2
  ; y := (rbutton_press_y1-circle_size_2/2)/2
  ; MyGui2.Move(x, y, circle_size_2/2, circle_size_2/2)
  ; WinSetTransparent(circle_transparent, "ahk_id " . MyGui2.Hwnd)
  ; global MyGui3
  ; WinSetRegion("0-0 W" . circle_size_3 . " H" . circle_size_3 . " E", "ahk_id " . MyGui3.Hwnd)
  ; x := (rbutton_press_x1-circle_size_3/2)/2
  ; y := (rbutton_press_y1-circle_size_3/2)/2
  ; MyGui3.Move(x, y, circle_size_3/2, circle_size_3/2)
  ; WinSetTransparent(circle_transparent, "ahk_id " . MyGui3.Hwnd)
}

HideCircle() {
  for index, value in GuiList {
    WinSetTransparent(0, "ahk_id " . value.Hwnd)
  }
  ; global MyGui1
  ; WinSetTransparent(0, "ahk_id " . MyGui1.Hwnd)
  ; global MyGui2
  ; WinSetTransparent(0, "ahk_id " . MyGui2.Hwnd)
  ; global MyGui3
  ; WinSetTransparent(0, "ahk_id " . MyGui3.Hwnd)
}

InitCircle() {
  Loop circle_nums {
    MyGui := Gui("+LastFound +ToolWindow +AlwaysOnTop -Caption")
    MyGui.BackColor := circle_colors[A_index]
    MyGui.Show("NA")
    WinSetRegion("0-0 W0 H0 E", "ahk_id " . MyGui.Hwnd)
    WinSetTransparent(circle_transparent, "ahk_id " . MyGui.Hwnd)
    GuiList.Push(MyGui)
  }
  ; global MyGui1
  ; MyGui1 := Gui("+LastFound +ToolWindow +AlwaysOnTop -Caption")
  ; MyGui1.BackColor := circle_color_1
  ; MyGui1.Show("NA")
  ; WinSetRegion("0-0 W0 H0 E", "ahk_id " . MyGui1.Hwnd)
  ; WinSetTransparent(circle_transparent, "ahk_id " . MyGui1.Hwnd)
  ; global MyGui2
  ; MyGui2 := Gui("+LastFound +ToolWindow +AlwaysOnTop -Caption")
  ; MyGui2.BackColor := circle_color_2
  ; MyGui2.Show("NA")
  ; WinSetRegion("0-0 W0 H0 E", "ahk_id " . MyGui2.Hwnd)
  ; WinSetTransparent(circle_transparent, "ahk_id " . MyGui2.Hwnd)
  ; global MyGui3
  ; MyGui3 := Gui("+LastFound +ToolWindow +AlwaysOnTop -Caption")
  ; MyGui3.BackColor := circle_color_3
  ; MyGui3.Show("NA")
  ; WinSetRegion("0-0 W0 H0 E", "ahk_id " . MyGui3.Hwnd)
  ; WinSetTransparent(circle_transparent, "ahk_id " . MyGui3.Hwnd)
}
