excel_mode := "normal"

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

II(char) {
  Global excel_mode
  If (excel_mode == "insert") {
    Send(char)
  }
  excel_mode := "insert"
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
  II("i")
}

a:: {
  II("a")
}

d:: { Send("{WheelDown}") }

u:: { Send("{WheelUp}") }

w:: { Send("{Right}") }

b:: { Send("{Left}") }

l:: { Send("{Right}") }

h:: { Send("{Left}") }

k:: { Send("{Up}") }

j:: { Send("{Down}") }

+l:: { Send("+{Right}") }

+h:: { Send("+{Left}") }

+k:: { Send("+{Up}") }

+j:: { Send("+{Down}") }

#HotIf
