; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/07 01:13:46 星期五

G(items*) {
  menus := Map()
  menus.Set(items*)
  msg := ""
  For key, val in menus {
    msg .= key . ": " . val[1] . "`n"
  }
  msg := Strip(msg)
  Tooltip(msg, A_ScreenWidth / 2, A_ScreenHeight / 4)
  key := StrLower(KeyWaitAny())
  If menus.Has(key) {
    menus[key][2]()
    Tooltip
  } Else {
    Print("<" . key . ">")
  }
}

MyMenu() {
  G(
    "space", ["<Win-R>", () => Send("#r")],
    "m", ["More", () => G(
      "space", ["<win-r>", () => Send("#r")],
    )],
  )
}
