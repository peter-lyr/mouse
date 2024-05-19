; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/17 23:55:49 星期五

PrintList := []

Join(string_array, sep:="`n") {
  res := ""
  for index, value in string_array {
    res .= value . sep
  }
  Return Trim(res, ' `r`t`n')
}

StrInArray(string, string_array) {
  for index, value in string_array {
    if (string == value) {
      Return 1
    }
  }
  Return 0
}

Print(text:="", timeout:=4000) {
  Global PrintList
  PrintList := [text]
  Tooltip(text)
  SetTimer(Tooltip, timeout)
}

PrintAppend(text:="", timeout:=4000) {
  Global PrintList
  PrintList.Push(text)
  Tooltip(Join(PrintList))
  SetTimer(Tooltip, timeout)
}

PrintAppendUniq(text:="", timeout:=4000) {
  Global PrintList
  if (Not StrInArray(text, PrintList)) {
    PrintList.Push(text)
  }
  Tooltip(Join(PrintList))
  SetTimer(Tooltip, timeout)
}

PrintAppendEnd(text:="", timeout:=4000) {
  Global PrintList
  Tooltip(Trim(Join(PrintList) . '`n' . text, ' `r`t`n'))
  SetTimer(Tooltip, timeout)
}

; 见https://wyagd001.github.io/v2/docs/lib/_HotIf.htm#ExVolume
MouseIsOver(wintitle) {
  MouseGetPos ,, &win
  Return WinExist(wintitle " Ahk_id " win)
}

RButtonIsPressed() {
  Return GetKeyState("RButton", "P")
}

LButtonIsPressed() {
  Return GetKeyState("LButton", "P")
}

MButtonIsPressed() {
  Return GetKeyState("MButton", "P")
}
