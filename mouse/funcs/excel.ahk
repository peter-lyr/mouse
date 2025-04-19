excel_mode := "normal"

Excel_Alt() {
  Global excel_mode
  If (WinActive("ahk_exe EXCEL.EXE")) {
    excel_mode := "alt"
  }
}

ExcelSave() {
  Send("^s")
  CoordMode("Tooltip", "Window")
  WinGetPos(&_x, &_y, &_w, &_h, "ahk_exe EXCEL.EXE")
  Tooltip("Excel Saved.", _w / 2, _h / 2)
  SetTimer(Tooltip, -1000)
  CoordMode("Tooltip", "Screen")
}

ExcelWatch() {
  Global excel_mode
  If (excel_mode != "alt") {
    excel_mode := IsExcelInsertMode()
  }
}

IsExcelInsertMode() {
  Try {
    Excel := ComObjActive("Excel.Application")
  } Catch {
      Return "normal"
  }
  If (Type(Excel) == "Application") {
    Return "normal"
  }
  Return "insert"
}

#HotIf WinActive("ahk_exe EXCEL.EXE")

~+Enter::
~+Tab::
~Enter::
~Tab::
~Esc:: {
  Global excel_mode
  If (excel_mode == "insert") {
    ExcelSave()
  }
  excel_mode := "normal"
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

^g:: {
  Send("{AppsKey}")
}

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

$^:: {
  Send("{Home}")
}

$:: {
  Send("{End}")
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
