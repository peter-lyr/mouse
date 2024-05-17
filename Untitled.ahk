#Requires AutoHotkey v2.0

f8:: {
  ; send "{Enter}"
    Print()
}

#Include %A_ScriptDir%\a.ahk

Print(text:="222222222222", timeout:=4000) {
  Tooltip(text)
    SetTimer(tooltip, timeout)
}

Print()
