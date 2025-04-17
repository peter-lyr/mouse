#HotIf WinActive("ahk_exe EXCEL.EXE")

!+l:: {
  Send("{Right}")
}

!+h:: {
  Send("{Left}")
}

!+k:: {
  Send("{Up}")
}

!+j:: {
  Send("{Down}")
}

^!+l:: {
  Send("+{Right}")
}

^!+h:: {
  Send("+{Left}")
}

^!+k:: {
  Send("+{Up}")
}

^!+j:: {
  Send("+{Down}")
}

#HotIf
