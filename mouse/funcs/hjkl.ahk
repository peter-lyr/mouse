HJKL_sta := false

GO_K_MoveCursor() {
  K_Escape()
  K_MoveCursor()
}

Get_HJKL_extra() {
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
  Return extra
}

HJKL_List := [
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
  "tab", ["K_MoveCursor", GO_K_MoveCursor],
]

K_HJKL() {
  extra := Get_HJKL_extra()
  temp := MergeArrs(HJKL_List, extra)
  K(temp*)
}

KT_HJKL() {
  extra := Get_HJKL_extra()
  temp := MergeArrs(HJKL_List, extra)
  KT(temp*)
}

ToggleHJKL() {
  Global HJKL_sta
  If (HJKL_sta == 0) {
    HJKL_sta := 1
  } Else If (HJKL_sta == 1) {
    HJKL_sta := 2
  } Else If (HJKL_sta == 2) {
    HJKL_sta := 3
  } Else If (HJKL_sta == 3) {
    HJKL_sta := 0
  }
  Print(HJKL_sta)
}

#HotIf HJKL_sta == 3 And Not WinActive("ahk_exe nvim-qt.exe") And Not WinActive("ahk_exe WindowsTerminal.exe")

j:: {
  Print("^+{Down}")
  Send("^+{Down}")
}

k:: {
  Print("^+{Up}")
  Send("^+{Up}")
}

h:: {
  Print("^+{Left}")
  Send("^+{Left}")
}

l:: {
  Print("^+{Right}")
  Send("^+{Right}")
}

#HotIf HJKL_sta == 2 And Not WinActive("ahk_exe nvim-qt.exe") And Not WinActive("ahk_exe WindowsTerminal.exe")

j:: {
  Print("^{Down}")
  Send("^{Down}")
}

k:: {
  Print("^{Up}")
  Send("^{Up}")
}

h:: {
  Print("^{Left}")
  Send("^{Left}")
}

l:: {
  Print("^{Right}")
  Send("^{Right}")
}

#HotIf HJKL_sta And Not WinActive("ahk_exe nvim-qt.exe") And Not WinActive("ahk_exe WindowsTerminal.exe")

j:: {
  Print("{Down}")
  Send("{Down}")
}

k:: {
  Print("{Up}")
  Send("{Up}")
}

h:: {
  Print("{Left}")
  Send("{Left}")
}

l:: {
  Print("{Right}")
  Send("{Right}")
}

g:: {
  Print("{AppsKey}")
  Send("{AppsKey}")
}

d:: {
  Send("{Del}")
}

b:: {
  Send("{Bs}")
}

a:: {
  Send("{Home}")
}

e:: {
  Send("{End}")
}

p:: {
  Send("{PgUp}")
}

n:: {
  Send("{PgDn}")
}

#HotIf
