; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/17 23:55:49 星期五

SelClick_Ks := Map()
SelClick_En := 0

DesktopAhkClass := "Program Manager"


; # python
; from distinctipy import distinctipy
;
; # 生成25个易于区分的颜色
; num_colors = 25
; colors = distinctipy.get_colors(num_colors)
;
; # 打印颜色代码
; for color in colors:
;     print('  "0X' + distinctipy.get_hex(color).strip('#') + '",')

BarColors := [
  "0X00ff00",
  "0Xff00ff",
  "0X0080ff",
  "0Xff8000",
  "0X80bf80",
  "0X5204c4",
  "0Xe10343",
  "0X01724d",
  "0Xb56ffb",
  "0X21feed",
  "0Xffff00",
  "0X7d4b22",
  "0Xf8b293",
  "0X00ff80",
  "0X85fd1e",
  "0X95caf3",
  "0X5a6baf",
  "0Xd35870",
  "0X6aa409",
  "0X0e156a",
  "0X0caa9f",
  "0Xba0cab",
  "0Xc9fd8b",
  "0X800000",
  "0X0000ff",
]

Lines := []
TextPos := []

Chars := [
  "a", "b", "c", "d", "e",
  "f", "g", "h", "i", "j",
  "k", "l", "m", "n", "o",
  "p", "q", "r", "s", "t",
  "u", "v", "w", "x", "y",
  "z",
]

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

Msg(arr) {
  MsgBox(Join(arr))
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
  ; shell := ComObject("WScript.Shell")
  ; exec := shell.Exec(A_ComSpec . " /C " . cmd)
  ; Return Strip(exec.StdOut.ReadAll())
  shell := ComObject("WScript.Shell")
  launch := "cmd.exe /c " . cmd . " > temp.txt"
  exec := shell.Run(launch, 0, true)
  ; 读取并返回命令的输出
  output := FileRead("temp.txt")
  FileDelete "temp.txt"
  return output
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
  MouseGetPos(&_x0, &_y0)
  WinGetPos(&_x, &_y, &_w, &_h, "A")
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
  CoordMode("Mouse", "Window")
  Click __x, __y
  CoordMode("Mouse", "Screen")
  MouseMove(_x0, _y0)
}

; MsgBox KeyWaitAny()
;
; ; 再来一遍, 但不阻止按键.
; MsgBox KeyWaitAny("V")

KeyWaitAny(Options:="") {
  _ih := InputHook(Options)
  if !InStr(Options, "V") {
    _ih.VisibleNonText := false
  }
  _ih.KeyOpt("{All}", "E") ; 结束
  _ih.Start()
  _ih.Wait()
  return _ih.EndKey ; 返回按键名称
}

ExplorerOpen(dir) {
  If (Not dir Or Not DirExist(dir)) {
    Return
  }
  If (WinExist("ahk_class CabinetWClass")) {
    WinActivate("ahk_class CabinetWClass")
    WinWaitActive("ahk_class CabinetWClass")
    Sleep(100)
    Send("!d")
    A_Clipboard := ""
    While 1 {
      A_Clipboard := dir
      If (A_Clipboard) {
        Break
      }
    }
    Sleep(200)
    Send("^v")
    Sleep(200)
    Send("{Enter}")
  } Else {
    Run(dir)
  }
}

SystemRun(cmd) {
  Run(cmd)
}

SystemRunSilent(cmd) {
  id := WinGetId("A")
  SetTimer(() => WinWaitActivate(id), -500)
  Run(cmd)
}

; mouse\funcs\.lowerandsort.py

DirExistArr(arr) {
  If (Not arr) {
    Return []
  }
  new_arr := []
  For _, r in arr {
    r := Strip(r)
    If (DirExist(r)) {
      new_arr.Push(r)
    }
  }
  Return new_arr
}

StripArr(arr) {
  If (Not arr) {
    Return []
  }
  new_arr := []
  For _, r in arr {
    new_arr.Push(Strip(r))
  }
  Return new_arr
}

SystemCd(file) {
  Return 
}

LowerUniqSort(arr) {
  params := ""
  For _, str in arr {
    params .= str . ","
  }
  cmd := A_ScriptDir . "\mouse\funcs\.loweruniqsort.py " . params
  result := StrSplit(Strip(CmdRunOutput(cmd)), "`n")
  Return StripArr(result)
}

LowerUniqSortFile(file) {
  cmd := A_ScriptDir . "\mouse\funcs\.loweruniqsort_file.py " . file
  Run(cmd)
}

;; py放funcs目录下
RunPyWithArgs(py, args*) {
  params := '"'
  For _, str in args {
    params .= str . '" "'
  }
  params .= '"'
  cmd := Format("{:}\mouse\funcs\{:} {:}", A_ScriptDir, py, params)
  ; Run(cmd)
  CmdRunOutput(cmd)
}

ReadLines(file) {
  result := StrSplit(Strip(FileRead(file)), "`n")
  Return StripArr(result)
}

ReadLinesLowerUniqSort(file) {
  Return LowerUniqSort(ReadLines(file))
}

ActivateWins(win) {
  If (WinExist(win) And Not WinActive(win)) {
    For id in WinGetList(win) {
      WinActivate(id)
    }
  }
}

CycleActivateAllExistWin(arr) {
  Global CycleWinIndex
  win := arr[CycleWinIndex]
  ActivateWins(win)
  CycleWinIndex += 1
  If (CycleWinIndex > arr.Length) {
    CycleWinIndex := 1
  }
}

MinimizeAllExistWin(arr) {
  For _, win in arr {
    If (WinExist(win)) {
      For id in WinGetList(win) {
        WinMinimize(id)
      }
    }
  }
}

WinWaitActivate(win) {
  Loop 1000 {
    If WinExist(win) {
      WinActivate(win)
      If WinActive(win) {
        Break
      }
    }
  }
}

ActivateDesktop() {
  Loop 10 {
    If Not WinActive(DesktopAhkClass) {
      WinActivate(DesktopAhkClass)
    }
    If (WinActive(DesktopAhkClass)) {
      Break
    }
  }
}

ActivateOrOpen(wid, exe) {
  Try {
    If Not WinExist(wid) {
      Run(exe)
    }
    WinWaitActivate(wid)
  }
}

MergeArrs(arrays*) {
  new_arr := []
  for arr in arrays {
    for , value in arr {
      new_arr.Push(value)
    }
  }
  Return new_arr
}

DrawRectangle(x, y, w, h, index) {
  Global TextPos
  GuiOpt := "+LastFound +ToolWindow +AlwaysOnTop -Caption +Disabled"
  bar := 4
  ; 先上下再左右
  X := [x, x, x, x + w - bar]
  Y := [y, y + h - bar, y, y]
  bar := bar * 96 / A_ScreenDPI
  w := w * 96 / A_ScreenDPI
  h := h * 96 / A_ScreenDPI
  W := [w, w, bar, bar]
  H := [bar, bar, h, h]
  color := BarColors[Mod(index, BarColors.Length) + 1]
  Loop 4 {
    line := Gui()
    line.Opt(GuiOpt)
    line.BackColor := color
    _show_wh := Format("X{:}Y{:}W{:}H{:}", X[A_Index], Y[A_Index], W[A_Index], H[A_Index])
    line.Show(_show_wh . " NA")
    WinSetTransparent(100, "Ahk_id " . line.Hwnd)
    Lines.Push(line)
  }
  line := Gui()
  line.MarginX := 0
  line.MarginY := 0
  line.Opt(GuiOpt)
  line.SetFont("s18 bold")
  line.Add("Text", , Chars[Mod(index, Chars.Length)] . " " . index)
  line.BackColor := color
  x := X[1]
  y := Y[1]
  TextPos.Push([x, y])
  _show_wh := Format("X{:}Y{:}", x, y)
  line.Show(_show_wh . " NA")
  WinSetTransparent(220, "Ahk_id " . line.Hwnd)
  Lines.Push(line)
}

KillRectangles() {
  Global Lines
  For line in Lines {
    line.Destroy()
  }
  Lines := []
}

DrawRectangles(X, Y, W, H, I) {
  KillRectangles()
  For i in I {
    index := A_Index
    DrawRectangle(X[index], Y[index], W[index], H[index], i)
  }
}

SelClick_Do(key) {
  Global SelClick_En
  SelClick_En := 0
  ClickWhenCursorArrowDo(SelClick_Ks[key][1], SelClick_Ks[key][2], SelClick_Ks[key][3], SelClick_Ks[key][4])
  SelClick_Hot()
  KillRectangles()
}

SelClick_Hot() {
  Global SelClick_Ks
  On := "Off"
  If SelClick_En {
    On := "On"
  }
  For k, v in SelClick_Ks {
    HotKey k, (key) => SelClick_Do(key), On
  }
}

SelClickDo(X, Y, W, H, I) {
  Global SelClick_Ks
  Global SelClick_En
  SelClick_En := 1
  KillRectangles()
  SelClick_Ks := Map()
  For i in I {
    index := A_Index
    DrawRectangle(X[index], Y[index], W[index], H[index], i)
    SelClick_Ks[Chars[Mod(i, Chars.Length)]] := [X[index], Y[index], W[index], H[index]]
  }
  SelClick_Hot()
}
