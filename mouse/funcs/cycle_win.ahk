; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/14 00:10:36 Friday

ActivateCycleWeChatWXWork() {
  CycleActivateAllExistWin([
    "ahk_exe WXWork.exe",
    "ahk_exe WeChat.exe",
  ])
}

ActivateCycleExplorerMsedge() {
  CycleActivateAllExistWin([
    "ahk_class CabinetWClass",
    "ahk_exe msedge.exe",
  ])
}

ExplorerAllTabsToOneWindow() {
  Global first_id
  MouseGetPos(&x, &y)
  If Not IsSet(first_id) {
    For id in WinGetList("ahk_class CabinetWClass") {
      first_id := id
      Break
    }
  } Else {
    _first_id := 0
    _flag := 0
    For id in WinGetList("ahk_class CabinetWClass") {
      _first_id := id
      If (id == first_id) {
        _flag := 1
        Break
      }
    }
    If _flag == 0 And _first_id {
      first_id := _first_id
    }
  }
  WinMove(0, 0, , , first_id)
  WinActivate(first_id)
  WinWaitActive(first_id)
  For id in WinGetList("ahk_class CabinetWClass") {
    If (first_id == id) {
      Continue
    }
    WinActivate(id)
    WinWaitActive(id)
    WinMove(300, 300, , , id)
    Sleep 100
    MouseClick("Left", 590, 350, , , "D")
    MouseMove(390, 80)
    Sleep 100
    Click("Up")
  }
  MouseMove(x, y)
}

#HotIf WinActive("ahk_class CabinetWClass")

f1:: {
  ExplorerAllTabsToOneWindow()
}

#HotIf
