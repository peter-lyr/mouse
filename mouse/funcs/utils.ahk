; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/17 23:55:49 星期五

remote_desktop_exes := [
  "ahk_exe mstsc.exe",
  "ahk_exe SunloginClient.exe",
  "ahk_exe WindowsSandboxClient.exe",
]

remote_desktop_classes := [
  "ahk_class TscShellContainerClass", ; mstsc.exe
]

remote_desktop_titles := [
  "Windows 沙盒",
  "Windows Sandbox",
]

PrintList := []

Strip(text) {
  Return Trim(text, " `r`t`n")
}

Join(string_array, sep:="`n") {
  res := ""
  for index, value In string_array {
    res .= value . sep
  }
  Return Strip(res)
}

StrInArray(string, string_array) {
  for index, value In string_array {
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
  SetTimer(Tooltip, -timeout)
}

PrintLater(text:="", timeout:=4000) {
  SetTimer(() => Print(text, -timeout), -30)
}

PrintAppend(text:="", timeout:=4000) {
  Global PrintList
  PrintList.Push(text)
  Tooltip(Join(PrintList))
  SetTimer(Tooltip, -timeout)
}

PrintAppendUniq(text:="", timeout:=4000) {
  Global PrintList
  If (Not StrInArray(text, PrintList)) {
    PrintList.Push(text)
  }
  Tooltip(Join(PrintList))
  SetTimer(Tooltip, -timeout)
}

PrintAppendEnd(text:="", timeout:=4000) {
  Global PrintList
  Tooltip(Strip(Join(PrintList) . "`n" . text))
  SetTimer(Tooltip, -timeout)
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
  Return CmdRunOutput("cd " . A_ScriptDir . "\mouse\funcs" . " && .getwinver.bat")
}

Array2Map(arr) {
  _map := Map()
  Return _map.Set(arr*)
}

TryCallFunction(function) {
  If ("Func" == Type(function) Or "Closure" == Type(function)) {
    Try {
      Return function()
    }
  }
}

TryCallFunctionReturn(function, just_info) {
  If ("Func" == Type(function) Or "Closure" == Type(function)) {
    Try {
      Return function(just_info)
    }
  }
  Return ""
}

FunctionWrap(param_maps) {
  LayerxxxRButtonUp(just_info:=0) {
    If (just_info) {
      If (GetWheelFlag()) {
        Return
      }
      info := TryCallFunctionReturn(param_maps.Get("R", ""), 1)
      Return info And "R: " . info Or ""
    }
    If (GetWheelFlag()) {
      Return
    }
    TryCallFunctionReturn(param_maps.Get("R", ""), 0)
  }
  LayerxxxWheelUp(just_info:=0) {
    If (just_info) {
      info := TryCallFunctionReturn(param_maps.Get("U", ""), 1)
      Return info And "U: " . info Or ""
    }
    TryCallFunctionReturn(param_maps.Get("U", ""), 0)
  }
  LayerxxxWheelDown(just_info:=0) {
    If (just_info) {
      info := TryCallFunctionReturn(param_maps.Get("D", ""), 1)
      Return info And "D: " . info Or ""
    }
    TryCallFunctionReturn(param_maps.Get("D", ""), 0)
  }
  Layerxxx() {
    If (RButtonIsPressed()) {
      If (GetWheelDownFlag()) {
        LayerxxxWheelDown()
      } Else If (GetWheelUpFlag()) {
        LayerxxxWheelUp()
      } Else {
        If (GetMouseActionFlag() != 1) {
          Return
        }
        CheckPrint([
          LayerxxxRButtonUp(1),
          LayerxxxWheelUp(1),
          LayerxxxWheelDown(1),
        ])
      }
    } Else If (GetMouseActionFlag() == 2) {
      _ld := GetLayer() . "-" . GetDirection()
      ShowFuncs(_ld)
    } Else {
      LayerxxxRButtonUp()
    }
  }
  Return Layerxxx
}

IsCurWinAndMax(exes:=[], titles:=[], classes:=[]) {
  MouseGetPos , , &_win
  _cid := WinGetId(_win)
  for index, exe In exes {
    If (WinExist(exe) And WinGetId(exe) == _cid And WinGetMinMax(exe) == 1) {
      Return 1
    }
  }
  for index, class In classes {
    If (WinExist(class) And WinGetId(class) == _cid And WinGetMinMax(class) == 1) {
      Return 1
    }
  }
  for index, title In titles {
    If (WinExist(title) And WinGetId(title) == _cid And WinGetMinMax(title) == 1) {
      Return 1
    }
  }
  Return 0
}

ActivateWaitSend(win, send_what) {
  If (WinExist(win)) {
    WinActivate(win)
    WinWait(win)
    Send(send_what)
  }
}

ActivateWaitMaximizeSend(win, send_what) {
  If (WinExist(win)) {
    WinActivate(win)
    WinWait(win)
    WinMaximize(win)
    Send(send_what)
  }
}

RemoteDesktopActiveOrRButtonPressed() {
  Return IsCurWinAndMax(remote_desktop_exes, remote_desktop_titles, remote_desktop_classes)
}

ClickActiveWindow(x, y) {
  WinGetPos(&_x, &_y, &_w, &_h, "A")
  CoordMode("Mouse", "Screen")
  __x := x
  __y := y
  If (x < 0) {
    __x := _w + x
  }
  If (y < 0) {
    __y := _h + y
  }
  If (__x < 0) {
    __x := 0
  } Else If (__x >= _w) {
    __x := _w - 1
  }
  If (__y < 0) {
    __y := 0
  } Else If (__y >= _h) {
    __y := _h - 1
  }
  Click __x, __y
  CoordMode("Mouse", "Window")
}
