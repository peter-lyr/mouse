HJKL_TIMEOUT := 10

HJKL() {
  extra := []
  If WinActive("ahk_exe msedge.exe") {
    ControlClick(ControlGetClassNN("Chrome Legacy Window"))
    extra := [
      "x", ["Up", () => Send("^w"), "lefttop", HJKL_TIMEOUT],
    ]
  } Else {
    extra := [
      "j", ["Down", () => Send("{Down}"), "lefttop", HJKL_TIMEOUT],
      "k", ["Up", () => Send("{Up}"), "lefttop", HJKL_TIMEOUT],
    ]
  }
  G(
    "h", ["Left", () => Send("{Left}"), "lefttop", HJKL_TIMEOUT],
    "l", ["Right", () => Send("{Right}"), "lefttop", HJKL_TIMEOUT],
    "w", ["PgUp", () => Send("{PgUp}"), "lefttop", HJKL_TIMEOUT],
    "s", ["PgDn", () => Send("{PgDn}"), "lefttop", HJKL_TIMEOUT],
    "a", ["Home", () => Send("{Home}"), "lefttop", HJKL_TIMEOUT],
    "d", ["End", () => Send("{End}"), "lefttop", HJKL_TIMEOUT],
    "z", ["Ctrl-Home", () => Send("^{Home}"), "lefttop", HJKL_TIMEOUT],
    "c", ["Ctrl-End", () => Send("^{End}"), "lefttop", HJKL_TIMEOUT],
    "q", ["Shift-WheelUp", () => Send("+{WheelUp}"), "lefttop", HJKL_TIMEOUT],
    "e", ["Shift-WheelDown", () => Send("+{WheelDown}"), "lefttop", HJKL_TIMEOUT],
    "v", ["Alt-Left", () => Send("!{Left}"), "lefttop", HJKL_TIMEOUT],
    "b", ["Alt-Right", () => Send("!{Right}"), "lefttop", HJKL_TIMEOUT],
    ";", ["WheelUp", () => Send("{WheelUp}"), "lefttop", HJKL_TIMEOUT],
    "'", ["WheelDown", () => Send("{WheelDown}"), "lefttop", HJKL_TIMEOUT],
    extra*
  )
}
