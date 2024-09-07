HJKL() {
  extra := []
  If WinActive("ahk_exe msedge.exe") {
    ControlClick(ControlGetClassNN("Chrome Legacy Window"))
    extra := [
      "x", ["Up", () => Send("^w")],
    ]
  } Else {
    extra := [
      "j", ["Down", () => Send("{Down}")],
      "k", ["Up", () => Send("{Up}")],
    ]
  }
  K(
    "h", ["Left", () => Send("{Left}")],
    "l", ["Right", () => Send("{Right}")],
    "w", ["PgUp", () => Send("{PgUp}")],
    "s", ["PgDn", () => Send("{PgDn}")],
    "a", ["Home", () => Send("{Home}")],
    "d", ["End", () => Send("{End}")],
    "z", ["Ctrl-Home", () => Send("^{Home}")],
    "c", ["Ctrl-End", () => Send("^{End}")],
    "q", ["Shift-WheelUp", () => Send("+{WheelUp}")],
    "e", ["Shift-WheelDown", () => Send("+{WheelDown}")],
    "v", ["Alt-Left", () => Send("!{Left}")],
    "b", ["Alt-Right", () => Send("!{Right}")],
    ";", ["WheelUp", () => Send("{WheelUp}")],
    "'", ["WheelDown", () => Send("{WheelDown}")],
    extra*
  )
}
