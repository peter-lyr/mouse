; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/07 01:13:46 星期五

Menus := Map()

WinR() {
  Send("#r")
}

Menus.Set(
  "space", WinR,
)

ShowItems() {
  _temp := ""
  For k, v in Menus {
    _temp .= k . ": " . v.Name . "`n"
  }
  _temp := Strip(_temp)
  Send("{Escape}")
  Tooltip(_temp, A_ScreenWidth / 2, A_ScreenHeight / 4)
}

WaitKey() {
  _key := StrLower(KeyWaitAny())
  If Menus.Has(_key) {
    Menus[_key]()
    Tooltip
  } Else {
    Print("<" . _key . ">")
  }
}

MyMenu() {
  ShowItems()
  WaitKey()
}
