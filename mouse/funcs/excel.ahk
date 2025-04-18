excel_mode := "normal"
excel_saved := 0

#HotIf WinActive("ahk_exe EXCEL.EXE")

~Esc:: {
  Global excel_mode
  Global excel_saved
  excel_mode := "normal"
  excel_saved := 0
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
    Print("Excel Saved.")
  }
}

SetTimer(Excel_Save, 2000)

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
