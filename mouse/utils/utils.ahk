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
    If (string == value) {
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
  If (Not StrInArray(text, PrintList)) {
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

GetWinVer() {
  Return CmdRunOutput("cd " . A_ScriptDir . "\mouse\utils" . " && getwinver.bat")
}

Array2Map(arr) {
  _map := Map()
  Return _map.Set(arr*)
}

TryCallFunction(function) {
  If ("Func" == Type(function) Or "Closure" == Type(function)) {
    Try {
      function()
    }
  }
}

FunctionWrap(param_maps) {
  LayerxxxRButtonUp(just_info:=0) {
    If (just_info) {
      If (GetWheelFlag()) {
        Return
      }
      info := param_maps.Get("ri", "") ; release info
      Return info And "R: " . info Or ""
    }
    If (GetWheelFlag()) {
      Return
    }
    TryCallFunction(param_maps.Get("rf", ""))
  }
  LayerxxxWheelUp(just_info:=0) {
    If (just_info) {
      info := param_maps.Get("ui", "") ; wheelup info
      Return info And "U: " . info Or ""
    }
    TryCallFunction(param_maps.Get("uf", ""))
  }
  LayerxxxWheelDown(just_info:=0) {
    If (just_info) {
      info := param_maps.Get("di", "") ; wheeldown info
      Return info And "D: " . info Or ""
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

IsWinActiveAndMax(title) {
  Return WinActive("ahk_exe mstsc.exe") And WinGetMinMax("ahk_exe mstsc.exe") == 1
}

RemoteDesktopActive() {
  Return IsWinActiveAndMax("ahk_exe mstsc.exe") Or IsWinActiveAndMax("ahk_exe SunloginClient.exe")
}
