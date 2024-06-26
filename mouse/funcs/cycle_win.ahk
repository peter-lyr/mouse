; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/14 00:10:36 Friday

InActivateAll() {
  InActivateAllExistWin([
    "ahk_exe WXWork.exe",
    "ahk_exe WeChat.exe",
    "ahk_class CabinetWClass",
    "ahk_exe msedge.exe",
    "ahk_exe Downloader.exe",
    "ahk_exe Fileserv.exe",
  ])
}

ActivateCycleWeChatWXWork() {
  InActivateAll()
  CycleActivateAllExistWin([
    "ahk_exe WXWork.exe",
    "ahk_exe WeChat.exe",
  ])
}

ActivateCycleExplorerMsedge() {
  InActivateAll()
  CycleActivateAllExistWin([
    "ahk_class CabinetWClass",
    "ahk_exe msedge.exe",
  ])
}

ActivateCycleDownloaderFileServ() {
  InActivateAll()
  CycleActivateAllExistWin([
    "ahk_exe Downloader.exe",
    "ahk_exe Fileserv.exe",
  ])
}
