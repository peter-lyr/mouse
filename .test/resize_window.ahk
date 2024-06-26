; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/22 12:38:40 Wednesday

setwindelay(0)

RButtonIsPressed() {
  Return GetKeyState("RButton", "P")
}

MButtonIsPressed() {
  Return GetKeyState("MButton", "P")
}

CoordMode("Mouse", "Screen")

resize_window_do1() {
  MouseGetPos &resize_window_x1, &resize_window_y1, &resize_window_id
  _minmax_status := WinGetMinMax(resize_window_id)
  if (_minmax_status == 0) {
    Tooltip(">>>")
    return
  }
  WinGetPos(&resize_window_current_x, &resize_window_current_y, &resize_window_current_w, &resize_window_current_h, resize_window_id)
  WinGetPos(&resize_window_ori_x, &resize_window_ori_y, &resize_window_ori_w, &resize_window_ori_h, resize_window_id)
  _y1 := resize_window_current_h * (resize_window_x1 - resize_window_current_x) / resize_window_current_w + resize_window_current_y
  _y2 := resize_window_current_h * (resize_window_current_x - resize_window_x1) / resize_window_current_w + resize_window_current_y + resize_window_current_h
  if (resize_window_x1 < resize_window_current_x + resize_window_current_w / 3 or ((resize_window_y1 > _y1) and (resize_window_y1 < _y2))) {
    _winleft := 1
    _winwidth := 1
    resize_window_dx := 1
  } else if (resize_window_x1 > resize_window_current_x + resize_window_current_w * 2 / 3 or ((resize_window_y1 < _y1) and (resize_window_y1 > _y2))) {
    _winleft := -1
    _winwidth := 1
    resize_window_dx := 0
  } else {
    _winleft := 0
    _winwidth := 0
    resize_window_dx := 0
  }
  if (resize_window_y1 < resize_window_current_y + resize_window_current_h / 3 or ((resize_window_y1 < _y1) and (resize_window_y1 < _y2))) {
    _winup := 1
    _winheight := 1
    resize_window_dy := 1
  } else if (resize_window_y1 > resize_window_current_y + resize_window_current_h * 2 / 3 or ((resize_window_y1 > _y1) and (resize_window_y1 > _y2))) {
    _winup := -1
    _winheight := 1
    resize_window_dy := 0
  } else {
    _winup := 0
    _winheight := 0
    resize_window_dy := 0
  }
  loop {
    if (RButtonIsPressed() == 0) {
      WinMove(resize_window_ori_x, resize_window_ori_y, resize_window_ori_w, resize_window_ori_h, resize_window_id)
      break
    }
    if (MButtonIsPressed() == 0) {
      break
    }
    MouseGetPos &resize_window_x2, &resize_window_y2
    WinGetPos(&resize_window_current_x, &resize_window_current_y, &resize_window_current_w, &resize_window_current_h, resize_window_id)
    resize_window_x2 -= resize_window_x1
    resize_window_y2 -= resize_window_y1
    resize_window_new_x := resize_window_current_x + resize_window_x2 * resize_window_dx
    resize_window_new_y := resize_window_current_y + resize_window_y2 * resize_window_dy
    resize_window_new_w := resize_window_current_w  - resize_window_x2 * _winleft * _winwidth
    resize_window_new_h := resize_window_current_h  - resize_window_y2 * _winup  * _winheight
    WinMove(resize_window_new_x, resize_window_new_y, resize_window_new_w, resize_window_new_h, resize_window_id)
    resize_window_x1 := (resize_window_x2 + resize_window_x1)
    resize_window_y1 := (resize_window_y2 + resize_window_y1)
  }
}

RButtonMButton() {
  MouseGetPos , , &resize_window_id
  resize_window_do1()
}

RButton & MButton:: {
  RButtonMButton()
}
