; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/07 01:13:46 星期五

Menus := Map()

Menus.Set(
  ; "k", WinMaximizeRestoreA,
  ; ";", TransparentToggleA,
  ; "l", TopMostToggleA,
)

ShowItems() {
  _temp := ""
  For k, v in Menus {
    _temp .= k . ": " . v.Name . "`n"
  }
  _temp := Strip(_temp)
  Tooltip(_temp)
}

WaitKey() {
  _key := KeyWaitAny()
  If Menus.Has(_key) {
    Menus[_key]()
  }
}

MyMenu() {
  ShowItems()
  WaitKey()
  Tooltip
}
