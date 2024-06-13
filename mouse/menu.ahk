; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/07 01:13:46 星期五

MyDirsTxt := A_ScriptDir . "\mydirs.txt"

G(items*) {
  Global mstsc_activate
  menus := Map()
  menus.Set(items*)
  msg := ""
  For key, val in menus {
    msg .= key . ": " . val[1] . "`n"
  }
  msg := Strip(msg)
  SetTimer(() => [
    CoordMode("Tooltip", "Screen")
    Tooltip(msg, A_ScreenWidth / 8, A_ScreenHeight / 8),
  ], -10)
  key := StrLower(KeyWaitAny("T3"))
  If menus.Has(key) {
    v := menus[key][1]
    f := menus[key][2]
    If (Type(f) == "Func") {
      f()
      If (StrSplit(v, " ")[1] == "Continue") {
        G(key, [v, f])
      }
    } Else If (DirExist(v)) {
      ExplorerOpen(v)
    } Else If (FileExist(v)) {
      Run(v)
    }
    Tooltip
  } Else {
    If (mstsc_activate) {
      WinActivate("ahk_exe mstsc.exe")
    }
    Print("<" . key . ">", 300)
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

LAltCount() {
  Global menu_flag
  Global LAltUpFlag
  If (Not IsSet(LAltUpFlag)) {
    LAltUpFlag := 1
  }
  If (Not LAltUpFlag) {
    Return
  }
  LAltUpFlag := 0
  If (Not IsSet(menu_flag)) {
    menu_flag := 0
  }
  menu_flag += 1
  If (menu_flag == 2) {
    menu_flag := 0
    MyMenu()
  } Else {
    SetTimer(ResetMenuFlag, -300)
  }
}

LAltUp() {
  Global LAltUpFlag
  LAltUpFlag := 1
}

MyMenu() {
  Global mstsc_activate
  Global CycleWinIndex
  CycleWinIndex := 1
  mstsc_activate := 0
  If (WinExist("ahk_exe QuickLook.exe")) {
    WinMoveBottom("ahk_exe QuickLook.exe")
  }
  Loop 10 {
    If WinActive("ahk_exe mstsc.exe") {
      mstsc_activate := 1
      WinActivate("ahk_class Shell_TrayWnd")
      If (Not WinActive("ahk_exe mstsc.exe")) {
        Break
      }
    }
  }
  G(
    "rshift", ["ActivateNvimQtExe", ActivateNvimQtExe],
    "lshift", ["ActivateNvimQtExe", ActivateNvimQtExe],
    "enter", ["ActivateMstscExe", ActivateMstscExe],
    "lalt", ["ActivateWXWorkExe", ActivateWXWorkExe],
    "d", ["Continue ActivateCycleDownloaderFileServ", ActivateCycleDownloaderFileServ],
    "w", ["Continue ActivateCycleWeChatWXWork", ActivateCycleWeChatWXWork],
    "e", ["Continue ActivateCycleExplorerMsedge", ActivateCycleExplorerMsedge],
    "space", ["<Win-R>", () => Send("#r")],
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
  )
}
