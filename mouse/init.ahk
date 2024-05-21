; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/19 17:22:08 星期日

winver := 11

If (GetWinVer() == "Windows 10") {
  winver := 10
}

; TODO: 当颜色太暗时设高一点
circle_transparent := 8

circle_list := []

circle_nums := 6

wheel_count_max := 6

If (winver == 10) {
  circle_sizes := [100, 300, 500, 700, 900, 1100]
} Else {
  circle_sizes := [200, 500, 800, 1100, 1400, 1700]
}

circle_colors := ["Red", "Blue", "Green", "Red", "Blue", "Green"]

GuiOpt := "+LastFound +ToolWindow +AlwaysOnTop -Caption"

dir_index_maps := Map()

dir_index_maps.Set(
  "center", 0,
  "right_up", 1,
  "right", 2,
  "right_down", 3,
  "down", 4,
  "left_down", 5,
  "left", 6,
  "left_up", 7,
  "up", 8,
  "side_right_up", 9,
  "side_right", 10,
  "side_right_down", 11,
  "side_down", 12,
  "side_left_down", 13,
  "side_left", 14,
  "side_left_up", 15,
  "side_up", 16,
)

function_index := 0

functions := []

Loop (circle_nums + 1) * 8 {
  functions.Push(0)
}

UpdateRbuttonPressPos1() {
  Global rbutton_press_x1
  Global rbutton_press_y1
  Global rbutton_press_win
  CoordMode "Mouse", "Screen"
  MouseGetPos &rbutton_press_x1, &rbutton_press_y1, &rbutton_press_win
}

GetRbuttonPressWin() {
  Global rbutton_press_win
  If (Not IsSet(rbutton_press_win)) {
    rbutton_press_win := 0
  }
  Return rbutton_press_win
}

UpdateRbuttonPressPos2() {
  Global rbutton_press_x2
  Global rbutton_press_y2
  Global mouse_moved := 0
  rbutton_press_x2_back := IsSet(rbutton_press_x2) And rbutton_press_x2 Or 0
  rbutton_press_y2_back := IsSet(rbutton_press_y2) And rbutton_press_y2 Or 0
  CoordMode "Mouse", "Screen"
  MouseGetPos &rbutton_press_x2, &rbutton_press_y2
  If (rbutton_press_x2_back != rbutton_press_x2 Or rbutton_press_y2_back != rbutton_press_y2) {
    mouse_moved := 1
  }
}

DrawCircleAtRbuttonPressPos1() {
  For _index, _gui In circle_list {
    _gui.Opt(GuiOpt)
    WinSetRegion("0-0 W" . circle_sizes[_index] . " H" . circle_sizes[_index] . " E", "Ahk_id " . _gui.Hwnd)
    If (winver == 10) {
      x := (rbutton_press_x1-circle_sizes[_index]/2)
      y := (rbutton_press_y1-circle_sizes[_index]/2)
      _gui.Move(x, y, circle_sizes[_index], circle_sizes[_index])
    } Else {
      x := (rbutton_press_x1-circle_sizes[_index]/2)/2
      y := (rbutton_press_y1-circle_sizes[_index]/2)/2
      _gui.Move(x, y, circle_sizes[_index]/2, circle_sizes[_index]/2)
    }
    WinSetTransparent(circle_transparent, "Ahk_id " . _gui.Hwnd)
  }
}

HideCircle() {
  For _index, _gui In circle_list {
    WinSetTransparent(0, "Ahk_id " . _gui.Hwnd)
  }
}

InitCircle() {
  Loop circle_nums {
    MyGui := Gui()
    MyGui.Opt(GuiOpt)
    MyGui.BackColor := circle_colors[A_index]
    MyGui.Show("NA")
    WinSetRegion("0-0 W0 H0 E", "Ahk_id " . MyGui.Hwnd)
    WinSetTransparent(circle_transparent, "Ahk_id " . MyGui.Hwnd)
    circle_list.Push(MyGui)
  }
}

GetDirection() {
  Global direction
  Return direction
}

GetPos1StateFromPos2() {
  Global function_index
  Global direction
  layer := 0
  _dir := "center"
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
      If (_x2 >= _l And _x2 <= _r And _y2 >= _t And _y2 <= _b) {
        _r := _r - 1
        _b := _b - 1
        Break
      }
    }
    If (_x2 == _l || _x2 == _r || _y2 == _t || _y2 == _b) {
      If (_x2 == _l && _y2 == _t) {
        _dir := "side_left_up"
      } Else If (_x2 == _r && _y2 == _t) {
        _dir := "side_right_up"
      } Else If (_x2 == _r && _y2 == _b) {
        _dir := "side_right_down"
      } Else If (_x2 == _l && _y2 == _b) {
        _dir := "side_left_down"
      } Else If (_y2 == _t) {
        _dir := "side_up"
      } Else If (_x2 == _r) {
        _dir := "side_right"
      } Else If (_y2 == _b) {
        _dir := "side_down"
      } Else If (_x2 == _l) {
        _dir := "side_left"
      }
      layer := circle_nums
    } Else {
      _dx := _dx * _gap / _c
      _dy := _dy * _gap / _c
      If (Abs(_dx) >= _min And Abs(_dx) <= _max And Abs(_dy) >= _min And Abs(_dy) <= _max) {
        If (_dx >= 0 And _dy <= 0) {
          _dir := "right_up"
        } Else If (_dx >= 0 And _dy >= 0) {
          _dir := "right_down"
        } Else If (_dx <= 0 And _dy >= 0) {
          _dir := "left_down"
        } Else {
          _dir := "left_up"
        }
      } Else {
        If (Abs(_dx) <= _min And _dy <= 0) {
          _dir := "up"
        } Else If (Abs(_dy) <= _min And _dx >= 0) {
          _dir := "right"
        } Else If (Abs(_dx) <= _min And _dy >= 0) {
          _dir := "down"
        } Else {
          _dir := "left"
        }
      }
    }
  }
  index := (layer > 0 And layer - 1 Or 0) * 8 + dir_index_maps[_dir]
  If (index > 0) {
    function := functions[index]
    If ("Func" == Type(function) Or "Closure" == Type(function)) {
      function_index := index
      Try {
        function()
      }
    } Else {
      function_index := 0
    }
  } Else {
    function_index := 0
  }
  direction := _dir
  If (Not function_index) {
    Print(Format("{:}C {:T}L {:T}:{:d}", GetWheelCount(), layer, direction, index))
  }
}

Array2Function(arr) {
  Return FunctionWrap(Array2Map(arr))
}

AddFunction(layer, dir, arr) {
  If (layer < 1) {
    layer := 1
  }
  If (layer > circle_nums) {
    layer := circle_nums
  }
  index := (layer - 1) * 8 + dir_index_maps[dir]
  functions[index] := Array2Function(arr)
}

CallFunction() {
  If (function_index > 0) {
    functions[function_index]()
  } Else {
    Click "Right"
  }
  Tooltip
}

CheckPrint(text:="") {
  Global mouse_moved
  If (mouse_moved Or GetWheelFlag() == 1) {
    If (GetWheelFlag()) {
      SetWheelFlag()
    }
    If (Type(text) == "Array") {
      Print(Join(text, "`n"))
    } Else {
      Print(text)
    }
  }
}

GetWheelDownFlag() {
  Global wheeldown_flag
  If (Not IsSet(wheeldown_flag)) {
    wheeldown_flag := 0
  }
  temp := wheeldown_flag
  wheeldown_flag := 0
  Return temp
}

GetWheelUpFlag() {
  Global wheelup_flag
  If (Not IsSet(wheelup_flag)) {
    wheelup_flag := 0
  }
  temp := wheelup_flag
  wheelup_flag := 0
  Return temp
}

ResetWheelFlag() {
  Global wheel_flag
  wheel_flag := 0
}

SetWheelFlag(val:=2) {
  Global wheel_flag
  wheel_flag := val
}

ResetWheelCount() {
  Global wheel_count
  wheel_count := 1
}

GetWheelCount() {
  Global wheel_count
  If (Not IsSet(wheel_count)) {
    wheel_count := 1
  }
  Return wheel_count
}

GetWheelFlag() {
  Global wheel_flag
  If (Not IsSet(wheel_flag)) {
    wheel_flag := 0
  }
  Return wheel_flag
}

RButtonWheelUpDownFlagClear() {
  Global wheelup_flag
  Global wheeldown_flag
  wheelup_flag := 0
  wheeldown_flag := 0
}

RButtonWheelUp() {
  Global wheelup_flag
  Global wheel_flag
  Global wheel_count
  If (Not IsSet(wheel_count)) {
    wheel_count := 1
  }
  If (GetDirection() == "center") {
    If (wheel_count >= wheel_count_max) {
      wheel_count := 1
    } Else {
      wheel_count += 1
    }
  }
  wheel_flag := 1
  wheelup_flag := 1
  SetTimer RButtonWheelUpDownFlagClear, -10
}

RButtonWheelDown() {
  Global wheeldown_flag
  Global wheel_flag
  Global wheel_count
  If (Not IsSet(wheel_count)) {
    wheel_count := 1
  }
  If (GetDirection() == "center") {
    If (wheel_count <= 1) {
      wheel_count := wheel_count_max
    } Else {
      wheel_count -= 1
    }
  }
  wheel_flag := 1
  wheeldown_flag := 1
  SetTimer RButtonWheelUpDownFlagClear, -10
}

ResetLButtonFlag() {
  Global lbutton_flag
  lbutton_flag := 0
}

GetLMButtonFlag() {
  Return GetLButtonFlag() Or GetMButtonFlag()
}

IncLMButtonFlag() {
  Global lbutton_flag
  Global mbutton_flag
  lbutton_flag += 1
  mbutton_flag += 1
}

GetLButtonFlag() {
  Global lbutton_flag
  If (Not IsSet(lbutton_flag)) {
    lbutton_flag := 0
  }
  Return lbutton_flag
}

RButtonLButton() {
  Global lbutton_flag
  lbutton_flag := 1
}

ResetMButtonFlag() {
  Global mbutton_flag
  mbutton_flag := 0
}

GetMButtonFlag() {
  Global mbutton_flag
  If (Not IsSet(mbutton_flag)) {
    mbutton_flag := 0
  }
  Return mbutton_flag
}

RButtonMButton() {
  Global mbutton_flag
  mbutton_flag := 1
}
