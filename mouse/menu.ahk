; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/07 01:13:46 星期五

MyDirsTxt := A_ScriptDir . "\mydirs.txt"

G(items*) {
  menus := Map()
  menus.Set(items*)
  msg := ""
  For key, val in menus {
    msg .= key . ": " . val[1] . "`n"
  }
  msg := Strip(msg)
  Tooltip(msg, A_ScreenWidth / 2, A_ScreenHeight / 4)
  key := StrLower(KeyWaitAny())
  If menus.Has(key) {
    v := menus[key][1]
    f := menus[key][2]
    If (Type(f) == "Func") {
      f()
    } Else If (DirExist(v)) {
      ExplorerOpen(v)
    } Else If (FileExist(v)) {
      Run(v)
    }
    Tooltip
  } Else {
    Print("<" . key . ">")
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

MyMenu() {
  G(
    "space", ["<Win-R>", () => Send("#r")],
    "o", ["Open", () => G(
      "s", ["Startup", () => G(
        "space", ["A_Startup", () => ExplorerOpen(A_Startup)],
        "c", ["A_StartupCommon", () => ExplorerOpen(A_StartupCommon)],
      )],
      "c", ["A_ComSpec", () => Run(A_ComSpec)],
      "d", ["A_Desktop", () => ExplorerOpen(A_Desktop)],
      "p", ["A_ProgramFiles", () => ExplorerOpen(A_ProgramFiles)],
      "t", ["A_Temp", () => ExplorerOpen(A_Temp)],
      "u", ["A_UserName", () => ExplorerOpen("C:\Users\" . A_UserName)],
      "a", ["ExplorerSelMyAdd", () => ExplorerSelMyAdd()],
      "o", ["ExplorerSelMyOpen", () => ExplorerSelMyOpen()],
    )],
  )
}
