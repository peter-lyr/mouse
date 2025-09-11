; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/07 01:13:46 星期五

MyDirsTxt := A_ScriptDir . "\mydirs.txt"

MenuGoing := 0

LastKey := ""

LastMsg := ""
LastShowMenuPos := ""

NormalWaitSecondsDefalt := 8
NormalWaitSeconds := NormalWaitSecondsDefalt
NormalWaitSecondsMax := 20

K_menus := ""
K_En := 0

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

GetMenus(items) {
  menus := Map()
  menus.Set(items*)
  return menus
}

GetMsg(items) {
  msg := ""
  sep := "`t"
  key := ""
  For _, v in items {
    If (type(v) == "Array") {
      msg .= Format("{:}{:}{:}`n", key, sep, v[1])
    } Else {
      key := v
    }
  }
  Return msg
}

Get_G_msg(msg, &G_wait) {
  G_wait := KeyWaitSecond
  If (G_wait <= 0) {
    G_wait := NormalWaitSeconds
  }
  temp_set := ""
  If (NormalWaitSeconds == NormalWaitSecondsDefalt And G_wait == NormalWaitSecondsDefalt) {
    temp_set .= "(Default)"
  }
  If (G_wait != NormalWaitSeconds) {
    temp_set .= Format("({:}S)", NormalWaitSeconds)
  }
  msg := "`t" . G_wait . "S" . temp_set . "`n" . msg
  Return msg
}

G(items*) {
  Global LastKey
  Global MenuGoing
  Global ShowMenuPos
  Global KeyWaitSecond
  Global NormalWaitSeconds
  MenuGoing := 1
  menus := GetMenus(items)
  msg := GetMsg(items)
  msg := Get_G_msg(msg, &G_wait)
  SetTimer(() => ShowMenu(msg), -10)
  key := StrLower(KeyWaitAny(Format("T{:}", G_wait)))
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
      f()
      If (menus[key].Length >= 3) {
        temp_o := menus[key][3]
        If (StrInArray(temp_o, ["Continue", "ActivateWindow"])) {
          If (key == "enter") {
            KeyWaitSecond := 0
            Return
          }
          continue_list := GetList(items, menus[key][3])
          sure := false
          If temp_o == "ActivateWindow" {
            continue_list := MergeGArrs(continue_list, SwitchWindow_List)
            If LastKey == key {
              sure := true
            }
          }
          If (Not sure) {
            LastKey := key
            G(continue_list*)
          }
        }
      }
    } Else If (DirExist(v)) {
      ExplorerOpen(v)
    } Else If (FileExist(v)) {
      Run(v)
    }
  } Else {
    If (key) {
      If (InStr(key, "alt")) {
        MenuKeyCount()
      } Else {
        SetTimer(() => Send("{" . key . "}"), -10)
        CoordMode("Tooltip", "Screen")
        Tooltip("<" . key . ">", 0, 0)
        SetTimer(Tooltip, -1000)
      }
    } Else {
      Tooltip
    }
    KeyWaitSecond := 0
  }
}

K_Escape() {
  Global K_En
  K_En := 0
  K_Hot()
}

K_Hot_Spec(key) {
  key := Trim(key, "~")
  key := StrLower(key)
  K_menus[key][2]()
}

K_Hot() {
  Global K_menus
  On := "On"
  If K_En == 0 {
    On := "Off"
    Tooltip
  }
  For k, v in K_menus {
    HotKey k, K_Hot_Spec, On
  }
}

K(items*) {
  Global K_menus
  Global K_En
  K_En := 1
  items.Push("escape")
  items.Push(["Exit", K_Escape])
  K_menus := GetMenus(items)
  msg := GetMsg(items)
  CoordMode("Tooltip", "Screen")
  Tooltip(msg, 0, 0)
  K_Hot()
}

KT_Escape() {
  Global K_En
  K_En := 0
  KT_Hot()
}

KT_Do(key) {
  SetTimer(K_Escape, NormalWaitSeconds*1000)
  K_menus[key][2]()
}

KT_Hot() {
  Global K_menus
  On := "On"
  If K_En == 0 {
    On := "Off"
    Tooltip
  }
  For k, v in K_menus {
    HotKey k, KT_Do, On
  }
}

KT(items*) {
  Global K_menus
  Global K_En
  K_En := 1
  items.Push("escape")
  items.Push(["Exit", K_Escape])
  K_menus := GetMenus(items)
  msg := GetMsg(items)
  msg := "`t" . NormalWaitSeconds . "S`n" . msg
  CoordMode("Tooltip", "Screen")
  Tooltip(msg, 0, 0)
  KT_Hot()
  SetTimer(K_Escape, NormalWaitSeconds*1000)
}

ExplorerSelOpen(dirs) {
  Global menu_remains
  temp := []
  flag := 0
  index := 1
  For , dir in dirs {
    If (Not DirExist(dir)) {
      Continue
    }
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
    index += 1
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
      Try {
        WinActivate("ahk_class Shell_TrayWnd")
      }
      If (Not WinActive("ahk_exe mstsc.exe")) {
        If (MonitorGetCount() <= 1) {
          WinMinimize("ahk_exe mstsc.exe")
        }
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
  Global LastKey
  Global ShowMenuPos
  Global CycleWinIndex
  Global MenuGoing
  Global KeyWaitSecond
  If (MenuGoing) {
    Return
  }
  LastKey := ""
  ShowMenuPos := "center"
  KeyWaitSecond := 0
  CycleWinIndex := 1
  G(
    "escape", ["ActivateDesktop", ActivateDesktop],
    "space", ["<Win-R>", () => Send("#r")],
    ; "u", ["upclip", () => SystemRunSilent("C:\Users\depei_liu\Desktop\Fileserv\upclip.bat")],
    ; "i", ["downclip", () => SystemRunSilent("C:\Users\depei_liu\Desktop\Fileserv\downclip.bat")],
    "f", ["Fileserv", () => G(
      "c", ["FileServLibChangeDir", FileServLibChangeDir],
      "d", ["FileServLibShowDir", FileServLibShowDir],
      "f", ["ActivateFileserv", ActivateFileserv],
      "k", ["CloseFileserv", CloseFileserv],
      "l", ["FileServShowLog", FileServShowLog],
      "o", ["FileServLibToggleDir", FileServLibToggleDir],
      "r", ["RestartFileserv", RestartFileserv],
      "u", ["FileServUpClip", FileServUpClip],
      "i", ["YankNvimQtLineFileServUpClip", YankNvimQtLineFileServUpClip],
    )],
    "g", ["K_MoveWindow", K_MoveWindow],
    "c", ["K_MoveCursor", K_MoveCursor],
    ";", ["K_HJKL", K_HJKL],
    "j", ["SelClick", SelClick],
    "tab", ["Toggle/Switch", () => G(
      "b", ["Browser", Browser],
      "space", ["Transparent", () => KT(
        "j", ["TransparentDownCurWin", TransparentDownCurWin],
        "k", ["TransparentUpCurWin", TransparentUpCurWin],
      )],
      "tab", ["K_SwitchWindow", K_SwitchWindow],
    )],
    "lalt", ["SwitchWindow", SwitchWindow],
    "ralt", ["SwitchWindow", SwitchWindow],
    "p", ["Panel/Properties/Proxy/Git", () => G(
      "o", ["ProxyOn", ProxyOn],
      "f", ["ProxyOff", ProxyOff],
      "s", ["Sound", () => Run("mmsys.cpl")],
      "k", ["NormalWaitSeconds++", IncNormalWaitSeconds, "Continue"],
      "j", ["NormalWaitSeconds--", DecNormalWaitSeconds, "Continue"],
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
      "o", ["ExplorerSelMyOpen", () => ExplorerSelMyOpen(), "", 8],
      ; "n", ["ActivateNvim", () => G(
      ;   "n", ["ActivateNvimQtExeNoNet", ActivateNvimQtExeNoNet, "", 8],
      ; )],
    )],
    "q", ["ActivateWXWorkExe", ActivateWXWorkExe],
    "w", ["ActivateWeChatExe", ActivateWeChatExe],
    "s", ["MinimizeOrActivateMsedge", MinimizeOrActivateMsedge, "Continue"],
    ",", ["ActivateEmacs", ActivateEmacs, "ActivateWindow"],
    ".", ["ActivateOneNvimQtExe", ActivateOneNvimQtExe],
    "rshift", ["ActivateNvimQt1Exe", ActivateNvimQt1Exe, "ActivateWindow"],
    "lshift", ["RunNvimQt1Exe", RunNvimQt1Exe, "ActivateWindow"],
    "/", ["ActivateWindowsTerminalExe", ActivateWindowsTerminalExe, "ActivateWindow"],
    "enter", ["ActivateMstscExe", ActivateMstscExe, "ActivateWindow"],
    "f6", ["CbpBuild", CbpBuild],
    "k", ["Kill /f /im", () => G(
      "n", ["Nvim-qt", TaskkillNvim],
      "m", ["Emacs", TaskkillEmacs],
    )],
    "m", ["Media", () => KT(
      "m", ["Volume_Mute", () => Send("{Volume_Mute}")],
      "k", ["Volume_Up", () => Send("{Volume_Up}")],
      "j", ["Volume_Down", () => Send("{Volume_Down}")],
      "h", ["Media_Prev", () => Send("{Media_Prev}")],
      "l", ["Media_Next", () => Send("{Media_Next}")],
      "s", ["Media_Stop", () => Send("{Media_Stop}")],
      "space", ["Media_Play_Pause", () => Send("{Media_Play_Pause}")],
    )],
    "t", ["Test", () => G(
      "a", ["TestA", TestA],
      "b", ["TestB", TestB],
      "c", ["TestC", TestC],
    )],
  )
}
