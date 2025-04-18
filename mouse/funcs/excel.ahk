excel_mode := "normal"
excel_saved := 0

Excel_Alt() {
  Global excel_mode
  If (WinActive("ahk_exe EXCEL.EXE")) {
    excel_mode := "alt"
  }
}

Excel_II(char) {
  Global excel_mode
  If (excel_mode == "insert") {
    Send(char)
  }
  excel_mode := "insert"
}

Excel_Save() {
  Global excel_mode
  Global excel_saved
  If (excel_saved == 0 And WinActive("ahk_exe EXCEL.EXE") And excel_mode == "normal") {
    excel_saved := 1
    Send("^s")
    CoordMode("Tooltip", "Window")
    WinGetPos(&_x, &_y, &_w, &_h, "ahk_exe EXCEL.EXE")
    Tooltip("Excel Saved.", _w / 2, _h / 2)
    SetTimer(Tooltip, -1000)
    CoordMode("Tooltip", "Screen")
  }
}

#HotIf WinActive("ahk_exe EXCEL.EXE")

~+Enter::
~+Tab::
~Enter::
~Tab::
~Esc:: {
  Global excel_mode
  Global excel_saved
  excel_mode := "normal"
  excel_saved := 0
}

#HotIf WinActive("ahk_exe EXCEL.EXE") && excel_mode == "alt"

^l:: {
  Send("{Right}")
}

^h:: {
  Send("{Left}")
}

^k:: {
  Send("{Up}")
}

^j:: {
  Send("{Down}")
}

#HotIf WinActive("ahk_exe EXCEL.EXE") && excel_mode == "insert"

^l:: {
  Send("{Right}")
}

^h:: {
  Send("{Left}")
}

^k:: {
  Send("{Up}")
}

^j:: {
  Send("{Down}")
}

^+l:: {
  Send("+{Right}")
}

^+h:: {
  Send("+{Left}")
}

^+k:: {
  Send("+{Up}")
}

^+j:: {
  Send("+{Down}")
}

#HotIf WinActive("ahk_exe EXCEL.EXE") && excel_mode == "normal"

SetTimer(Excel_Save, 2000)

g:: {
  Send("{AppsKey}")
}

e:: {
  Global excel_mode
  If (excel_mode == "insert") {
    Send("e")
  } Else If (excel_mode == "normal") {
    Send("{F2}")
  }
  excel_mode := "insert"
}

i:: {
  Excel_II("i")
}

a:: {
  Excel_II("a")
}

d:: {
  Send("{WheelDown}")
}

u:: {
  Send("{WheelUp}")
}

w:: {
  Send("{Right}")
}

b:: {
  Send("{Left}")
}

l:: {
  Send("{Right}")
}

h:: {
  Send("{Left}")
}

k:: {
  Send("{Up}")
}

j:: {
  Send("{Down}")
}

+l:: {
  Send("+{Right}")
}

+h:: {
  Send("+{Left}")
}

+k:: {
  Send("+{Up}")
}

+j:: {
  Send("+{Down}")
}

#HotIf
