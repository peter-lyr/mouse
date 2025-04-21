#HotIf excel_en And (WinActive("ahk_exe EXCEL.EXE") Or WinActive("ahk_exe wps.exe")) && excel_mode == "insert"

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

#HotIf
