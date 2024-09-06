; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/07 01:13:46 星期五

MyDirsTxt := A_ScriptDir . "\mydirs.txt"

MenuGoing := 0

LastMsg := ""
LastShowMenuPos := ""

NormalWaitSecondsDefalt := 3
NormalWaitSeconds := NormalWaitSecondsDefalt
NormalWaitSecondsMax := 20

IncNormalWaitSeconds() {
  Global NormalWaitSeconds
  Global KeyWaitSecond
  NormalWaitSeconds := Mod(NormalWaitSeconds, NormalWaitSecondsMax) + 1
  KeyWaitSecond := NormalWaitSeconds
  If (KeyWaitSecond < NormalWaitSecondsDefalt) {
    KeyWaitSecond := NormalWaitSecondsDefalt
  }
}

DecNormalWaitSeconds() {
  Global NormalWaitSeconds
  Global KeyWaitSecond
  NormalWaitSeconds--
  If (NormalWaitSeconds < 1) {
    NormalWaitSeconds := NormalWaitSecondsMax
  }
  KeyWaitSecond := NormalWaitSeconds
  If (KeyWaitSecond < NormalWaitSecondsDefalt) {
    KeyWaitSecond := NormalWaitSecondsDefalt
  }
}

ShowMenu(msg) {
  Global LastShowMenuPos
  Global ShowMenuPos
  Global LastMsg
  CoordMode("Tooltip", "Screen")
  SetTimer(Tooltip, 0)
  tid := 0
  Try {
    tid := WinGetId("ahk_class tooltips_class32")
  }
  If (tid And msg == LastMsg And LastShowMenuPos == ShowMenuPos) {
    Return
  }
  LastMsg := msg
  LastShowMenuPos := ShowMenuPos
  Tooltip(msg, 0, 0)
  tid := WinGetId("ahk_class tooltips_class32")
  If (tid) {
    WinGetPos(&_x, &_y, &_w, &_h, tid)
    If (ShowMenuPos == "center") {
      WinMove((A_ScreenWidth - _w) / 2, (A_ScreenHeight - _h) / 2, _w, _h, tid)
    } Else If (ShowMenuPos == "lefttop") {
      WinMove(-38, 0, _w, _h, tid)
    }
  }
}

GetList(items, text) {
  list := []
  key := ""
  For _, v in items {
    If (type(v) == "Array") {
      If (v.Length >= 3 And v[3] == text) {
        list.Push(key)
        list.Push(v)
      }
    } Else {
      key := v
    }
  }
  Return list
}

G(items*) {
  Global MenuGoing
  Global G_continuing
  Global ShowMenuPos
  Global KeyWaitSecond
  Global NormalWaitSeconds
  MenuGoing := 1
  menus := Map()
  menus.Set(items*)
  msg := ""
  sep := "`t"
  prefix := ""
  If (ShowMenuPos == "lefttop") {
    prefix := "            "
  }
  For key, val in menus {
    msg .= Format("{:}{:}{:}{:}`n", prefix, key, sep, val[1])
  }
  temp_wait := KeyWaitSecond
  If (temp_wait <= 0) {
    If (G_continuing == 1) {
      temp_wait := 0.5
    } Else {
      temp_wait := NormalWaitSeconds
    }
  }
  temp_set := ""
  If (NormalWaitSeconds == NormalWaitSecondsDefalt And temp_wait == NormalWaitSecondsDefalt) {
    temp_set .= "(Default)"
  }
  If (temp_wait != NormalWaitSeconds) {
    temp_set .= Format("({:}S)", NormalWaitSeconds)
  }
  msg := "`t" . temp_wait . "S" . temp_set . "`n" . msg
  SetTimer(() => ShowMenu(msg), -10)
  key := StrLower(KeyWaitAny(Format("T{:}", temp_wait)))
  MenuGoing := 0
  If (ShowMenuPos == "center") {
    Tooltip
  }
  ShowMenuPos := "center"
  If menus.Has(key) {
    v := menus[key][1]
    f := menus[key][2]
    If (Type(f) == "Func") {
      If (menus[key].Length >= 4) {
        KeyWaitSecond := menus[key][4]
      }
      flag := ""
      If (menus[key].Length >= 3) {
        If (menus[key][3] == "Continue") {
          flag := "Continue"
        } Else If (menus[key][3] == "lefttop") {
          flag := "lefttop"
          ShowMenuPos := "lefttop"
        }
      }
      f()
      If (v == "MyMenu") {
        Return
      }
      If (flag == "Continue") {
        G_continuing := 1
        If (key == "enter") {
          KeyWaitSecond := 0
          Return
        }
        continue_list := GetList(items, "Continue")
        G(continue_list*)
      } Else If (flag == "lefttop") {
        G_continuing := 1
        lefttop_list := GetList(items, "lefttop")
        G(lefttop_list*)
      }
    } Else If (DirExist(v)) {
      ExplorerOpen(v)
    } Else If (FileExist(v)) {
      Run(v)
    }
  } Else {
    If (key) {
      If (InStr(key, "alt")) {
        MyMenu()
      } Else {
        SetTimer(() => Send("{" . key . "}"), -10)
        CoordMode("Tooltip", "Screen")
        Tooltip("<" . key . ">", 0, 0)
        SetTimer(Tooltip, -1000)
      }
    } Else {
      Tooltip
    }
    G_continuing := 0
    KeyWaitSecond := 0
  }
}

ExplorerSelOpen(dirs) {
  Global menu_remains
  temp := []
  flag := 0
  For index, dir in dirs {
    key := Chr(96+index)
    temp.Push(key)
    If (Mod(index, 26) == 0 && dirs.Length > 26) {
      menu_remains := []
      Loop dirs.Length - 25 {
        menu_remains.Push(dirs[25+A_Index])
      }
      temp.Push(["More", () => ExplorerSelOpen(menu_remains)])
      Break
    } Else {
      arr := [dir, 0]
      temp.Push(arr)
    }
  }
  G(temp*)
}

ExplorerSelMyAdd() {
  If (DirExist(A_Clipboard)) {
    FileAppend(A_Clipboard . "`n", MyDirsTxt)
    LowerUniqSortFile(MyDirsTxt)
    SetTimer(() => Print("MyDirsTxt Added: " . A_Clipboard), -300)
  }
}

ExplorerSelMyOpen() {
  ; ExplorerSelOpen(DirExistArr(ReadLinesLowerUniqSort(MyDirsTxt)))
  ExplorerSelOpen(StrSplit(Strip(FileRead(MyDirsTxt)), "`n"))
}

ResetMenuFlag() {
  Global menu_flag
  menu_flag := 0
}

MenuKeyCount() {
  Global menu_flag
  Global MenuKeyUpFlag
  If (Not IsSet(MenuKeyUpFlag)) {
    MenuKeyUpFlag := 1
  }
  If (Not MenuKeyUpFlag) {
    Return
  }
  MenuKeyUpFlag := 0
  If (Not IsSet(menu_flag)) {
    menu_flag := 0
  }
  menu_flag += 1
  If (menu_flag == 2) {
    menu_flag := 0
    JumpOutSideOffMsTsc()
    MyMenu()
  } Else {
    SetTimer(ResetMenuFlag, -300)
  }
}

JumpOutSideOffMsTsc() {
  Loop 10 {
    If WinActive("ahk_exe mstsc.exe") {
      WinActivate("ahk_class Shell_TrayWnd")
      If (Not WinActive("ahk_exe mstsc.exe")) {
        Break
      }
    }
  }
  Loop 10 {
    If WinActive("ahk_class Windows.UI.Core.CoreWindow") {
      Send("{Esc}")
    }
    If (Not WinActive("ahk_class Windows.UI.Core.CoreWindow")) {
      Break
    }
  }
}

MenuKeyUp() {
  Global MenuKeyUpFlag
  MenuKeyUpFlag := 1
}

MyMenu() {
  Global ShowMenuPos
  Global CycleWinIndex
  Global G_continuing
  Global MenuGoing
  Global KeyWaitSecond
  If (MenuGoing) {
    Return
  }
  ShowMenuPos := "center"
  KeyWaitSecond := 0
  G_continuing := 0
  CycleWinIndex := 1
  G(
    "lalt", ["MyMenu", MyMenu, "Continue"],
    "ralt", ["MyMenu", MyMenu, "Continue"],
    "escape", ["ActivateDesktop", ActivateDesktop],
    "space", ["<Win-R>", () => Send("#r")],
    ; "u", ["upclip", () => SystemRunSilent("C:\Users\depei_liu\Desktop\Fileserv\upclip.bat")],
    ; "i", ["downclip", () => SystemRunSilent("C:\Users\depei_liu\Desktop\Fileserv\downclip.bat")],
    "q", ["ActivateWXWorkExe", ActivateWXWorkExe],
    "f", ["Fileserv", () => G(
      "c", ["FileServLibChangeDir", FileServLibChangeDir],
      "d", ["FileServLibShowDir", FileServLibShowDir],
      "f", ["ActivateFileserv", ActivateFileserv],
      "k", ["CloseFileserv", CloseFileserv],
      "l", ["FileServShowLog", FileServShowLog],
      "o", ["FileServLibToggleDir", FileServLibToggleDir],
      "r", ["RestartFileserv", RestartFileserv],
      "u", ["FileServUpClip", FileServUpClip],
    )],
    "g", ["Move Window", () => G(
      "m", ["MoveWindowCurScreenMax", MoveWindowCurScreenMax, "Continue", NormalWaitSeconds],
      "n", ["MoveWindowNextScreenMax", MoveWindowNextScreenMax, "Continue", NormalWaitSeconds],
      "l", ["MoveWindowCurScreenRight", MoveWindowCurScreenRight, "Continue", NormalWaitSeconds],
      "h", ["MoveWindowCurScreenLeft", MoveWindowCurScreenLeft, "Continue", NormalWaitSeconds],
      "k", ["MoveWindowCurScreenUp", MoveWindowCurScreenUp, "Continue", NormalWaitSeconds],
      "j", ["MoveWindowCurScreenDown", MoveWindowCurScreenDown, "Continue", NormalWaitSeconds],
      "w", ["MoveWindowCurScreenLeftUp", MoveWindowCurScreenLeftUp, "Continue", NormalWaitSeconds],
      "e", ["MoveWindowCurScreenRightUp", MoveWindowCurScreenRightUp, "Continue", NormalWaitSeconds],
      "s", ["MoveWindowCurScreenLeftDown", MoveWindowCurScreenLeftDown, "Continue", NormalWaitSeconds],
      "d", ["MoveWindowCurScreenRightDown", MoveWindowCurScreenRightDown, "Continue", NormalWaitSeconds],
    )],
    "tab", ["Toggle", () => G(
      "p", ["Proxy", () => G(
        "space", ["ProxyOn", ProxyOn],
        "f", ["ProxyOff", ProxyOff],
      )],
    )],
    "p", ["Panel/Properties", () => G(
      "s", ["Sound", () => Run("mmsys.cpl")],
      "k", ["NormalWaitSeconds++", IncNormalWaitSeconds, "Continue"],
      "j", ["NormalWaitSeconds--", DecNormalWaitSeconds, "Continue"],
    )],
    ";", ["HJKL", HJKL],
    "o", ["Open", () => G(
      "s", ["Startup", () => G(
        "space", ["A_Startup", () => ExplorerOpen(A_Startup)],
        "c", ["A_StartupCommon", () => ExplorerOpen(A_StartupCommon)],
        "m", ["A_StartMenu", () => ExplorerOpen(A_StartMenu)],
        "o", ["A_StartMenuCommon", () => ExplorerOpen(A_StartMenuCommon)],
      )],
      "c", ["cmd", () => G(
        "b", ["bash", () => Run("bash.exe")],
        "c", ["A_ComSpec", () => Run(A_ComSpec)],
        "i", ["ipython", () => Run("ipython.exe")],
        "p", ["powershell", () => Run("powershell.exe")],
      )],
      "d", ["desktop/document", () => G(
        "c", ["A_DesktopCommon", () => ExplorerOpen(A_DesktopCommon)],
        "d", ["A_Desktop", () => ExplorerOpen(A_Desktop)],
        "m", ["A_MyDocuments", () => ExplorerOpen(A_MyDocuments)],
      )],
      "p", ["program", () => G(
        "e", ["Program Files (x86)", () => ExplorerOpen(A_ProgramFiles)],
        "f", ["Program Files (x64)", () => ExplorerOpen("C:\Program Files")],
        "s", ["A_Programs", () => ExplorerOpen(A_Programs)],
        "c", ["A_ProgramsCommon", () => ExplorerOpen(A_ProgramsCommon)],
      )],
      "t", ["A_Temp", () => ExplorerOpen(A_Temp)],
      "u", ["A_UserName", () => ExplorerOpen("C:\Users\" . A_UserName)],
      "a", ["ExplorerSelMyAdd", () => ExplorerSelMyAdd()],
      "o", ["ExplorerSelMyOpen", () => ExplorerSelMyOpen(), "", 8],
    )],
    "a", ["TestTransparent", () => G(
      "j", ["TransparentDownCurWin", TransparentDownCurWin, "Continue"],
      "k", ["TransparentUpCurWin", TransparentUpCurWin, "Continue"],
    ), "Continue", 5],
    "d", ["ActivateCycleDownloaderCodeBlocks", ActivateCycleDownloaderCodeBlocks, "Continue"],
    "w", ["ActivateCycleWeChatWXWork", ActivateCycleWeChatWXWork, "Continue"],
    "e", ["ActivateCycleExplorerMsedge", ActivateCycleExplorerMsedge, "Continue"],
    "s", ["MinimizeOrActivateMsedge", MinimizeOrActivateMsedge, "Continue"],
    "m", ["ActivateEmacs", ActivateEmacs, "Continue"],
    "rshift", ["ActivateNvimQtExe", ActivateNvimQtExe, "Continue"],
    "lshift", ["ActivateNvimQtExe", ActivateNvimQtExe, "Continue"],
    "enter", ["ActivateMstscExe", ActivateMstscExe, "Continue"],
    "t", ["Test", () => G(
      "a", ["TestA", TestA],
      "b", ["TestB", TestB],
    )],
  )
}
