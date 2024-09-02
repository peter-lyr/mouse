; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/07 01:13:46 星期五

MyDirsTxt := A_ScriptDir . "\mydirs.txt"

MenuGoing := 0

G(items*) {
  Global MenuGoing
  Global G_continuing
  Global KeyWaitSecond
  MenuGoing := 1
  continue_list := []
  continue_key := ""
  For _, v in items {
    If (type(v) == "Array") {
      If (v.Length >= 3 And v[3] == "Continue") {
        continue_list.Push(continue_key)
        continue_list.Push(v)
      }
    } Else {
      continue_key := v
    }
  }
  menus := Map()
  menus.Set(items*)
  msg := ""
  For key, val in menus {
    msg .= Format("│{:-12}│{:}`n", key, val[1])
  }
  msg := Strip(msg)
  SetTimer(() => [
    CoordMode("Tooltip", "Screen")
    SetTimer(Tooltip, 0)
    Tooltip(msg, A_ScreenWidth / 8, A_ScreenHeight / 8),
  ], -10)
  If (KeyWaitSecond > 0) {
    key := StrLower(KeyWaitAny(Format("T{:}", KeyWaitSecond)))
  } Else {
    If (G_continuing == 1) {
      key := StrLower(KeyWaitAny("T0.5"))
    } Else {
      key := StrLower(KeyWaitAny("T3"))
    }
  }
  MenuGoing := 0
  Tooltip
  If menus.Has(key) {
    v := menus[key][1]
    f := menus[key][2]
    If (Type(f) == "Func") {
      f()
      If (menus[key].Length >= 4) {
        KeyWaitSecond := menus[key][4]
      }
      If (menus[key].Length >= 3 And menus[key][3] == "Continue") {
        G_continuing := 1
        If (key == "enter") {
          KeyWaitSecond := 0
          Return
        }
        G(continue_list*)
      }
    } Else If (DirExist(v)) {
      ExplorerOpen(v)
    } Else If (FileExist(v)) {
      Run(v)
    }
  } Else {
    If (key) {
      SetTimer(() => Send("{" . key . "}"), -10)
      Print("<" . key . ">", 1000)
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
    SetTimer(() => Print("MyDirsTxt Added: " . A_Clipboard), -300)
  }
}

ExplorerSelMyOpen() {
  ExplorerSelOpen(DirExistArr(ReadLinesLowerUniqSort(MyDirsTxt)))
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
  Global CycleWinIndex
  Global G_continuing
  Global MenuGoing
  Global KeyWaitSecond
  If (MenuGoing) {
    Return
  }
  KeyWaitSecond := 0
  G_continuing := 0
  CycleWinIndex := 1
  G(
    "lalt", ["ActivateWXWorkExe", ActivateWXWorkExe],
    "ralt", ["ActivateWXWorkExe", ActivateWXWorkExe],
    "escape", ["ActivateDesktop", ActivateDesktop],
    "space", ["<Win-R>", () => Send("#r")],
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
      "m", ["MoveWindowCurScreenMax", MoveWindowCurScreenMax],
      "n", ["MoveWindowNextScreenMax", MoveWindowNextScreenMax],
    )],
    ";", ["Toggle", () => G(
      "p", ["Proxy", () => G(
        "o", ["ProxyOn", ProxyOn],
        "f", ["ProxyOff", ProxyOff],
      )],
    )],
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
      "o", ["ExplorerSelMyOpen", () => ExplorerSelMyOpen()],
    )],
    "a", ["TestTransparent", () => G(
      "j", ["TransparentDownCurWin", TransparentDownCurWin, "Continue", 5],
      "k", ["TransparentUpCurWin", TransparentUpCurWin, "Continue", 5],
    )],
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

