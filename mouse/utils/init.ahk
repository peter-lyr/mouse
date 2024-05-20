; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/17 23:55:49 星期五

PrintList := []

Strip(text) {
  Return Trim(text, " `r`t`n")
}

Join(string_array, sep:="`n") {
  res := ""
  for index, value in string_array {
    res .= value . sep
  }
  Return Strip(res)
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
  Tooltip(Strip(Join(PrintList) . "`n" . text))
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

CmdRunOutput(cmd) {
  shell := ComObject("WScript.Shell")
  exec := shell.Exec(A_ComSpec . " /C " . cmd)
  Return Strip(exec.StdOut.ReadAll())
}

Array2Map(arr) {
  _map := Map()
  Return _map.Set(arr*)
}

TryCallFunction(function) {
  if (Type(function) == "Func") {
    Try {
      function()
    }
  }
}

FunctionWrap(param_maps) {
  LayerxxxRButtonUp(just_info:=0) {
    If (just_info) {
      If (GetWheelFlag()) {
        Return "R: "
      }
      Return "R: " . param_maps.Get("ri", "") ; release info
    }
    If (GetWheelFlag()) {
      Return
    }
    TryCallFunction(param_maps.Get("rf", ""))
  }
  LayerxxxWheelUp(just_info:=0) {
    If (just_info) {
      Return "U: " . param_maps.Get("ui", "") ; wheelup info
    }
    TryCallFunction(param_maps.Get("uf", ""))
  }
  LayerxxxWheelDown(just_info:=0) {
    If (just_info) {
      Return "D: " . param_maps.Get("di", "") ; wheeldown info
    }
    TryCallFunction(param_maps.Get("df", ""))
  }
  Layerxxx() {
    If (RButtonIsPressed()) {
      If (GetWheelDownFlag()) {
        LayerxxxWheelDown()
      } Else If (GetWheelUpFlag()) {
        LayerxxxWheelUp()
      } Else {
        CheckPrint([
          LayerxxxRButtonUp(1),
          LayerxxxWheelUp(1),
          LayerxxxWheelDown(1),
        ])
      }
    } Else {
      LayerxxxRButtonUp()
    }
  }
  Return Layerxxx
}
