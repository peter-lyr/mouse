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
