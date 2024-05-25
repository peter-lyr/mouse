; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/19 17:22:08 星期日

max_circles_directions := ((max_circles + 1) * max_directions) ; max_circles + 1 是因为增加了side_up...
max_wheels_circles_directions := (max_wheel_counts * max_circles_directions)
max_lefts_wheels_circles_directions := (max_left_counts * max_wheels_circles_directions)
max_middles_lefts_wheels_circles_directions := (max_middle_counts * max_lefts_wheels_circles_directions)

GuiOpt := "+LastFound +ToolWindow +AlwaysOnTop -Caption +Disabled"

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

rbutton_up_no_click := 0

rbuttonup_cancel_flag := 0

Infos := Map()

RbuttonPressFakeFlag := 0

Loop (max_middle_counts * max_left_counts * max_wheel_counts * (max_circles + 1) * max_directions) {
  functions.Push(0)
}

MouseGetPos &rbutton_press_x1, &rbutton_press_y1, &rbutton_press_win

SetRButtonUpCancelFlag(val) {
  Global rbuttonup_cancel_flag
  rbuttonup_cancel_flag := val
}

GetRButtonUpCancelFlag() {
  Global rbuttonup_cancel_flag
  Return rbuttonup_cancel_flag
}

SetRButtonUpNoClickFlag(val) {
  Global rbutton_up_no_click
  rbutton_up_no_click := val
}

GetRButtonUpNoClickFlag() {
  Global rbutton_up_no_click
  Return rbutton_up_no_click
}

GetRbuttonPressColor1() {
  Global rbutton_press_color1
  If (Not IsSet(rbutton_press_color1)) {
    rbutton_press_color1 := "0x808080"
  }
  Return rbutton_press_color1
}

GetRbuttonPressLight1() {
  _color := Integer(GetRbuttonPressColor1())
  _light := ((_color & 0xff) + ((_color >> 8) & 0xff) + ((_color >> 16) & 0xff)) / 3
  Return Integer(_light) Or 1
}

GetTransparency() {
  Return Min(Integer(255 * circle_min_transparent / GetRbuttonPressLight1()), circle_max_transparent)
}

UpdateRbuttonPressPos1() {
  Global rbutton_press_x1
  Global rbutton_press_y1
  Global rbutton_press_win
  Global rbutton_press_color1
  MouseGetPos &rbutton_press_x1, &rbutton_press_y1, &rbutton_press_win
  rbutton_press_color1 := PixelGetColor(rbutton_press_x1, rbutton_press_y1)
}

UpdateRbuttonPressPos1Fake() {
  Global rbutton_press_x1
  Global rbutton_press_y1
  Global rbutton_press_win
  Global rbutton_press_color1
  rbutton_press_x1 := A_ScreenWidth / 2
  rbutton_press_y1 := A_ScreenHeight / 2
  rbutton_press_color1 := PixelGetColor(rbutton_press_x1, rbutton_press_y1)
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
  MouseGetPos &rbutton_press_x2, &rbutton_press_y2
  If (rbutton_press_x2_back != rbutton_press_x2 Or rbutton_press_y2_back != rbutton_press_y2) {
    mouse_moved := 1
  }
}

DrawCircleAtRbuttonPressPos1() {
  Global circle
  If (Not IsSet(circle)) {
    Return
  }
  circle.Opt(GuiOpt)
  x := (rbutton_press_x1 - circle_diameter / 2) * 96 / dpi
  y := (rbutton_press_y1 - circle_diameter / 2) * 96 / dpi
  circle.Move(x, y, circle_diameter, circle_diameter)
  WinSetTransparent(GetTransparency(), "Ahk_id " . circle.Hwnd)
}

RButtonPressedWatcher() {
  If (RemoteDesktopActiveOrRButtonPressed()) {
    SetTimer , 0
    Return
  }
  _temp := GetLMButtonFlag()
  If (Not RButtonIsPressed() Or _temp) {
    If (_temp == 1) {
      IncLMButtonFlag()
      Tooltip
      HideCircle()
    }
    SetTimer , 0
    Return
  }
  UpdateRbuttonPressPos2()
  GetPos1StateFromPos2()
}

GetRbuttonPressFakeFlag() {
  Global RbuttonPressFakeFlag
  Return RbuttonPressFakeFlag
}

DisRbuttonPressFakeFlag() {
  Global RbuttonPressFakeFlag
  RbuttonPressFakeFlag := 0
}

RButtonPressedWatcherFake() {
  Global RbuttonPressFakeFlag
  If (RbuttonPressFakeFlag) {
    If (RButtonIsPressed() Or LButtonIsPressed() Or MButtonIsPressed()) {
      EnMouseActionFlag()
      SetTimer , 0
      Tooltip
      HideCircle()
      Return
    }
  }
  UpdateRbuttonPressPos2()
  GetPos1StateFromPos2()
}

RButtonDownFake() {
  Global RbuttonPressFakeFlag
  RbuttonPressFakeFlag := 1
  SetTimer(RButtonPressedWatcherFake, 10)
  UpdateRbuttonPressPos1Fake()
  DrawCircleAtRbuttonPressPos1()
}

RButtonDown() {
  If (GetRbuttonPressFakeFlag()) {
    SetTimer(DisRbuttonPressFakeFlag, -50)
    Return
  }
  SetTimer(RButtonPressedWatcher, 10)
  UpdateRbuttonPressPos1()
  DrawCircleAtRbuttonPressPos1()
}

RButtonUp() {
  ResetMButtonFlag()
  ResetLButtonFlag()
  ResetWheelCount()
  If (GetRButtonUpCancelFlag()) {
    SetRButtonUpCancelFlag(0)
    Return
  }
  HideCircle()
  CallFunction()
  ResetWheelFlag()
  ResetLeftCount()
  ResetMiddleCount()
  LButtonWheelCntReset(1)
}

LButtonDown() {
  If (GetRbuttonPressFakeFlag()) {
    SetTimer(DisRbuttonPressFakeFlag, -50)
    Return
  }
  If (RButtonIsPressed()) {
    RButtonLButton()
    Return
  }
  SetTimer(LButtonWheelCntReset, 0)
  IncLButtonWheelCnt()
  Print(GetLButtonWheelCnt(), 500)
}

IncLButtonWheelCnt() {
  Global lbutton_wheel_cnt
  If (Not IsSet(lbutton_wheel_cnt)) {
    lbutton_wheel_cnt := 0
  }
  If (lbutton_wheel_cnt >= max_wheel_counts) {
    lbutton_wheel_cnt := 1
  } Else {
    lbutton_wheel_cnt += 1
  }
}

GetLButtonWheelCnt() {
  Global lbutton_wheel_cnt
  If (Not IsSet(lbutton_wheel_cnt)) {
    lbutton_wheel_cnt := 0
  }
  Return lbutton_wheel_cnt
}

LButtonWheelCntReset(force:=0) {
  Global lbutton_wheel_cnt
  If (Not force) {
    If (RButtonIsPressed()) {
      Return
    }
  }
  lbutton_wheel_cnt := 0
}

LButtonUp() {
  SetTimer(LButtonWheelCntReset, -300)
}

HideCircle() {
  Global circle
  If (Not IsSet(circle)) {
    Return
  }
  WinSetTransparent(0, "Ahk_id " . circle.Hwnd)
}

InitCircle() {
  Global circle
  circle := Gui()
  circle.Opt(GuiOpt)
  _show_wh := "W" . circle_diameter . " H" . circle_diameter
  circle.Show(_show_wh . " NA")
  WinSetRegion("0-0 " . _show_wh . " E", circle.Hwnd)
  WinSetTransparent(0, "Ahk_id " . circle.Hwnd)
  hdc := DllCall("GetDC", "Ptr", circle.Hwnd)
  DllCall("SetBkMode", "Ptr", hdc, "Int", 1)
  Loop circle_colors.Length {
    brush := DllCall("CreateSolidBrush", "UInt", circle_colors[max_circles-A_Index+1])
    DllCall("SelectObject", "Ptr", hdc, "Ptr", brush)
    _radius := (A_Index - 1) * circle_radius
    DllCall("Ellipse", "Ptr", hdc, "Int", _radius, "Int", _radius, "Int", circle_diameter - _radius, "Int", circle_diameter - _radius)
    DllCall("DeleteObject", "Ptr", brush)
  }
  _circle_radius := circle_diameter / 2
  _diff := circle_diameter*Tan(0.017453292519943295*22.5)/2
  _diff_short := _circle_radius - _diff
  _diff_long := _circle_radius + _diff
  pen := DllCall("CreatePen", "Int", 0, "Int", 3, "UInt", 0xFFFFFF)
  DllCall("SelectObject", "Ptr", hdc, "Ptr", pen)
  DllCall("MoveToEx", "Ptr", hdc, "Int", _diff_short, "Int", 0, "Ptr", 0)
  DllCall("LineTo", "Ptr", hdc, "Int", _diff_long, "Int", circle_diameter)
  DllCall("MoveToEx", "Ptr", hdc, "Int", _diff_long, "Int", 0, "Ptr", 0)
  DllCall("LineTo", "Ptr", hdc, "Int", _diff_short, "Int", circle_diameter)
  DllCall("MoveToEx", "Ptr", hdc, "Int", 0, "Int", _diff_short, "Ptr", 0)
  DllCall("LineTo", "Ptr", hdc, "Int", circle_diameter, "Int", _diff_long)
  DllCall("MoveToEx", "Ptr", hdc, "Int", 0, "Int", _diff_long, "Ptr", 0)
  DllCall("LineTo", "Ptr", hdc, "Int", circle_diameter, "Int", _diff_short)
  DllCall("ReleaseDC", "Ptr", circle.Hwnd, "Ptr", hdc)
}

GetDirection() {
  Global direction
  If (Not IsSet(direction)) {
    direction := "center"
  }
  Return direction
}

GetLayer() {
  Global layer
  Return layer
}

GetPos1StateFromPos2() {
  Global function_index
  Global direction
  Global layer
  layer := 0
  _dir := "center"
  _x2 := rbutton_press_x2
  _y2 := rbutton_press_y2
  _dx := _x2 - rbutton_press_x1
  _dy := _y2 - rbutton_press_y1
  _c  := Sqrt(_dx ** 2 + _dy ** 2)
  Loop max_circles {
    _index := max_circles - A_index + 1
    _gap := circle_radius * _index
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
      layer := max_circles
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
  index := 0
  If (layer > 0) {
    index := max_lefts_wheels_circles_directions * (GetMiddleCount() - 1) +
             max_wheels_circles_directions * (GetLeftCount() - 1) +
             max_circles_directions * (GetWheelCount() - 1) +
             max_directions * (layer - 1) +
             dir_index_maps[_dir]
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
  If (Not function_index And GetMouseActionFlag() == 1) {
    info := Format(
      "[{:}][{:}][{:}][{:}][{:d}]: [{:d}] (B{:2} T{:2} {:8}) {:U}",
      GetMiddleCount(), GetLeftCount(), GetWheelCount(), layer, dir_index_maps[_dir], index,
      GetRbuttonPressLight1(), GetTransparency(), GetRbuttonPressColor1(), _dir
    )
    CheckPrint(info
        ; . "`n" .
        ; Format("{:}", 0)
        )
  }
}

Array2Function(middle_count, left_count, wheel_count, layer, dir, arr) {
  _temp := Format("M{:}L{:} W{:}: ", middle_count, left_count, wheel_count)
  For _index, val In arr {
    If (Mod(_index, 2)) {
      If (_index > 2) {
        _temp .= "                 "
      }
      _temp .= val . ": "
    } Else {
      _temp .= val(1) . "`n"
    }
  }
  _ld := layer . "-" . dir
  If (Not Infos.Has(_ld)) {
    Infos[_ld] := []
  }
  Infos[_ld].Push(Strip(_temp))
  Return FunctionWrap(Array2Map(arr))
}

ShowFuncs(t) {
  Global Infos
  If (Infos.Has(t)) {
    CheckPrint(Join(Infos[t]))
  }
}

GetBetween(&val, min, max) {
  If (val < min) {
    val := min
  }
  If (val > max) {
    val := max
  }
}

; Wrap Info Function
W(i, f) {
  _func(j) {
    If (j) {
      Return i
    }
    TryCallFunction(f)
  }
  Return _func
}

S(t) {
  _T() {
    Send(t)
  }
  Return _T
}

A(middle_count, left_count, wheel_count, layer, dir, arr) {
  GetBetween(&middle_count, 1, max_middle_counts)
  GetBetween(&left_count, 1, max_left_counts)
  GetBetween(&wheel_count, 1, max_wheel_counts)
  GetBetween(&layer, 1, max_circles)
  If (InStr(dir, "side_")) {
    layer := max_circles
  }
  index := max_lefts_wheels_circles_directions * (middle_count - 1) +
           max_wheels_circles_directions * (left_count - 1) +
           max_circles_directions * (wheel_count - 1) +
           max_directions * (layer - 1) +
           dir_index_maps[dir]
  functions[index] := Array2Function(middle_count, left_count, wheel_count, layer, dir, arr)
}

CallFunction() {
  If (GetMouseActionFlag() == 2) {
  } Else If (function_index > 0) {
    functions[function_index]()
  } Else {
    If (Not LButtonIsPressed() And Not MButtonIsPressed()) {
      If (Not GetRButtonUpNoClickFlag()) {
        Click "Right"
      }
      SetRButtonUpNoClickFlag(0)
    }
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

IncWheelCount() {
  Global wheel_count
  If (Not IsSet(wheel_count)) {
    wheel_count := 1
  }
  If (wheel_count >= max_wheel_counts) {
    wheel_count := 1
  } Else {
    wheel_count += 1
  }
}

RButtonWheelUp() {
  If (GetDirection() == "center") {
    IncWheelCount()
  } Else {
    Global wheelup_flag
    Global wheel_flag
    wheel_flag := 1
    wheelup_flag := 1
    SetTimer RButtonWheelUpDownFlagClear, -10
  }
}

DecWheelCount() {
  Global wheel_count
  If (Not IsSet(wheel_count)) {
    wheel_count := 1
  }
  If (wheel_count <= 1) {
    wheel_count := max_wheel_counts
  } Else {
    wheel_count -= 1
  }
}

RButtonWheelDown() {
  If (GetDirection() == "center") {
    DecWheelCount()
  } Else {
    Global wheeldown_flag
    Global wheel_flag
    wheel_flag := 1
    wheeldown_flag := 1
    SetTimer RButtonWheelUpDownFlagClear, -10
  }
}

WheelUpDo() {
  If (RButtonIsPressed()) {
    RButtonWheelUp()
  }
}

MButtonDown() {
  If (RButtonIsPressed()) {
    RButtonMButton()
  }
}

WheelDownDo() {
  If (RButtonIsPressed()) {
    RButtonWheelDown()
  }
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
  If (GetDirection() == "center") {
    IncLeftCount()
  } Else {
    Global lbutton_flag
    lbutton_flag := 1
    If (GetLayer() == 1) {
      SetTimer(MoveWindow, -20)
    }
    SetRButtonUpNoClickFlag(1)
    SetRButtonUpCancelFlag(1)
  }
}

LButtonRButton() {
  Global wheel_count
  If (Not IsSet(wheel_count)) {
    wheel_count := 1
  }
  wheel_count += GetLButtonWheelCnt()
  If (wheel_count > max_wheel_counts) {
    wheel_count := 1
  }
  RButtonDown()
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
  If (GetDirection() == "center") {
    IncMiddleCount()
  } Else {
    Global mbutton_flag
    mbutton_flag := 1
    If (GetLayer() == 1) {
      SetTimer(ResizeWindow, -20)
    }
    SetRButtonUpNoClickFlag(1)
    SetRButtonUpCancelFlag(1)
  }
}

ResetLeftCount() {
  Global left_count
  left_count := 1
}

GetLeftCount() {
  Global left_count
  If (Not IsSet(left_count)) {
    left_count := 1
  }
  Return left_count
}

IncLeftCount() {
  Global left_count
  If (Not IsSet(left_count)) {
    left_count := 1
  }
  If (left_count >= max_left_counts) {
    left_count := 1
  } Else {
    left_count += 1
  }
}

ResetMiddleCount() {
  Global middle_count
  middle_count := 1
}

GetMiddleCount() {
  Global middle_count
  If (Not IsSet(middle_count)) {
    middle_count := 1
  }
  Return middle_count
}

IncMiddleCount() {
  Global middle_count
  If (Not IsSet(middle_count)) {
    middle_count := 1
  }
  If (middle_count >= max_middle_counts) {
    middle_count := 1
  } Else {
    middle_count += 1
  }
}
