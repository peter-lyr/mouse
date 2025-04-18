excel_mode := "normal"
excel_saved := 0

#HotIf WinActive("ahk_exe EXCEL.EXE")

~Esc:: {
  Global excel_mode
  excel_mode := "normal"
}

#HotIf WinActive("ahk_exe EXCEL.EXE") && excel_mode == "insert"

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

Excel_II(char) {
  Global excel_mode
  Global excel_saved
  If (excel_mode == "insert") {
    Send(char)
  }
  excel_mode := "insert"
  excel_saved := 0
}

Excel_Save() {
  Global excel_mode
  Global excel_saved
  If (excel_saved == 0 And WinActive("ahk_exe EXCEL.EXE") And excel_mode == "normal") {
    excel_saved := 1
    Send("^s")
  }
}

SetTimer(Excel_Save, 5000)

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
