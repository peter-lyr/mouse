; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/19 17:22:08 星期日

circle_transparent := 50

circle_list := []

circle_nums := 3

circle_sizes := [200, 500, 800]

circle_colors := ["Red", "Blue", "Green"]

dir_index_maps := Map()

dir_index_maps.Set(
  'center', 0,
  'right_up', 1,
  'right', 2,
  'right_down', 3,
  'down', 4,
  'left_down', 5,
  'left', 6,
  'left_up', 7,
  'up', 8,
  'side_right_up', 9,
  'side_right', 10,
  'side_right_down', 11,
  'side_down', 12,
  'side_left_down', 13,
  'side_left', 14,
  'side_left_up', 15,
  'side_up', 16,
)

function_index := 0

functions := []

Loop (circle_nums + 1) * 8 {
  functions.Push(0)
}

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
  Global function_index
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
      MonitorGet(A_index, &_l, &_t, &_r, &_b)
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
  index := (layer > 0 and layer - 1 or 0) * 8 + dir_index_maps[direction]
  if (index > 0) {
    function := functions[index]
    if ("Func" == Type(function)) {
      function_index := index
      function()
    } else {
      function_index := 0
    }
  } else {
    function_index := 0
  }
}

AddFunction(layer, direction, function) {
  if (layer < 1) {
    layer := 1
  }
  if (layer > circle_nums) {
    layer := circle_nums
  }
  index := (layer - 1) * 8 + dir_index_maps[direction]
  functions[index] := function
}

Test() {
  if (RButtonIsPressed()) {
    if (MButtonIsPressed()) {
      Print("MButtonIsPressed")
    } else if (LButtonIsPressed()) {
      Print("LButtonIsPressed")
    } else {
      Print("1111111111111111111")
    }
  } else {
    Print("not RButtonIsPressed")
  }
}

AddFunction(1, "right_up", Test)

CallFunction() {
  if (function_index > 0) {
    functions[function_index]()
  } else {
    Click "Right"
  }
}
