; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/19 17:22:08 星期日

circle_transparent := 50

circle_list := []

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

DrawCircleAtRbuttonPressPos1() {
  For _index, value In circle_list {
    WinSetRegion("0-0 W" . circle_sizes[_index] . " H" . circle_sizes[_index] . " E", "Ahk_id " . value.Hwnd)
    x := (rbutton_press_x1-circle_sizes[_index]/2)/2
    y := (rbutton_press_y1-circle_sizes[_index]/2)/2
    value.Move(x, y, circle_sizes[_index]/2, circle_sizes[_index]/2)
    WinSetTransparent(circle_transparent, "Ahk_id " . value.Hwnd)
  }
}

HideCircle() {
  For _index, value In circle_list {
    WinSetTransparent(0, "Ahk_id " . value.Hwnd)
  }
}

InitCircle() {
  Loop circle_nums {
    MyGui := Gui("+LastFound +ToolWindow +AlwaysOnTop -Caption")
    MyGui.BackColor := circle_colors[A_index]
    MyGui.Show("NA")
    WinSetRegion("0-0 W0 H0 E", "Ahk_id " . MyGui.Hwnd)
    WinSetTransparent(circle_transparent, "Ahk_id " . MyGui.Hwnd)
    circle_list.Push(MyGui)
  }
}

GetPos1StateFromPos2() {
  layer := 0
  direction := "center"
  _x2 := rbutton_press_x2
  _y2 := rbutton_press_y2
  _dx := _x2 - rbutton_press_x1
  _dy := _y2 - rbutton_press_y1
  _c  := Sqrt(_dx ** 2 + _dy ** 2)
  Loop circle_nums {
    _index := circle_nums - A_index + 1
    _gap := circle_sizes[_index] / 2
    If (_c > _gap) {
      layer := _index
      Break
    }
  }
  _min := _gap * 0.3826834324 ;sin(22.5°) == 0.3826834324
  _max := _gap * 0.9238795325 ;sin(67.5°) == 0.9238795325
  If (_c > _gap) {
    loop MonitorGetCount() {
      MonitorGetWorkArea(A_index, &_l, &_t, &_r, &_b)
      If (_x2 >= _l and _x2 <= _r and _y2 >= _t and _y2 <= _b) {
        _r := _r - 1
        _b := _b - 1
        Break
      }
    }
    If (_x2 == _l || _x2 == _r || _y2 == _t || _y2 == _b) {
      If (_x2 == _l && _y2 == _t) {
        direction := "side_left_up"
      } Else If (_x2 == _r && _y2 == _t) {
        direction := "side_right_up"
      } Else If (_x2 == _r && _y2 == _b) {
        direction := "side_right_down"
      } Else If (_x2 == _l && _y2 == _b) {
        direction := "side_left_down"
      } Else If (_y2 == _t) {
        direction := "side_up"
      } Else If (_x2 == _r) {
        direction := "side_right"
      } Else If (_y2 == _b) {
        direction := "side_down"
      } Else If (_x2 == _l) {
        direction := "side_left"
      }
    } Else {
      _dx := _dx * _gap / _c
      _dy := _dy * _gap / _c
      If (Abs(_dx) >= _min and Abs(_dx) <= _max and Abs(_dy) >= _min and Abs(_dy) <= _max) {
        If (_dx >= 0 and _dy <= 0) {
          direction := "right_up"
        } Else If (_dx >= 0 and _dy >= 0) {
          direction := "right_down"
        } Else If (_dx <= 0 and _dy >= 0) {
          direction := "left_down"
        } Else {
          direction := "left_up"
        }
      } Else {
        If (Abs(_dx) <= _min and _dy <= 0) {
          direction := "up"
        } Else If (Abs(_dy) <= _min and _dx >= 0) {
          direction := "right"
        } Else If (Abs(_dx) <= _min and _dy >= 0) {
          direction := "down"
        } Else {
          direction := "left"
        }
      }
    }
  }
  PrintAppendEnd("" . layer . " ," . direction)
}
