; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/14 00:10:36 Friday

MinimizeAll() {
  MinimizeAllExistWin([
    "ahk_exe WXWork.exe",
    "ahk_exe WeChat.exe",
    "ahk_class CabinetWClass",
    ; "ahk_exe msedge.exe",
    "ahk_exe Downloader.exe",
    "ahk_exe Fileserv.exe",
  ])
}

MinimizeOrActivateMsedge() {
  If (WinActive("ahk_exe msedge.exe")) {
    MinimizeAll()
    WinMinimize("ahk_exe msedge.exe")
  } Else {
    WinActivate("ahk_exe msedge.exe")
  }
}

ActivateCycleWeChatWXWork() {
  MinimizeAll()
  CycleActivateAllExistWin([
    "ahk_exe WXWork.exe",
    "ahk_exe WeChat.exe",
  ])
}

ActivateCycleExplorerMsedge() {
  MinimizeAll()
  CycleActivateAllExistWin([
    "ahk_class CabinetWClass",
    "ahk_exe msedge.exe",
  ])
}

ActivateCycleDownloaderFileServ() {
  MinimizeAll()
  CycleActivateAllExistWin([
    "ahk_exe Downloader.exe",
    "ahk_exe Fileserv.exe",
  ])
}
