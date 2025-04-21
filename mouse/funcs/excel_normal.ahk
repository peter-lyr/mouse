
#HotIf excel_en And (WinActive("ahk_exe EXCEL.EXE") Or WinActive("ahk_exe wps.exe")) && excel_mode == "normal"

SetTimer(ExcelWatch, 1000)

g:: {
  Send("{AppsKey}")
}

i::
a::
e:: {
  Global excel_mode
  If (excel_mode == "insert") {
    Send("e")
  } Else If (excel_mode == "normal") {
    Send("{F2}")
  }
  excel_mode := "insert"
}

+u:: {
  Send("^y")
}

u:: {
  Send("^z")
}

y:: {
  Send("^c")
}

x:: {
  Send("^x")
}

p:: {
  Send("^v")
}

$^:: {
  Send("{Home}")
}

$:: {
  Send("{End}")
}

d:: {
  Send("{Del}")
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
