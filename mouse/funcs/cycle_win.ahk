; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/14 00:10:36 Friday

MinimizeAll() {
  MinimizeAllExistWin([
    "ahk_exe WXWork.exe",
    "ahk_exe WeChat.exe",
    "ahk_class CabinetWClass",
    "ahk_exe Downloader.exe",
    "ahk_exe codeblocks.exe",
    "ahk_exe emacs.exe",
    "ahk_exe nvim-qt.exe",
    "ahk_exe WindowsTerminal.exe",
  ])
}

ActivateMsedge() {
  If (WinExist("ahk_exe msedge.exe")) {
    WinActivate("ahk_exe msedge.exe")
  } Else {
    Run("msedge.exe")
  }
}

MinimizeOrActivateMsedge() {
  If (WinActive("ahk_exe msedge.exe")) {
    MinimizeAll()
    WinMinimize("ahk_exe msedge.exe")
  } Else {
    ActivateMsedge()
  }
}

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

ActivateCycleDownloaderCodeBlocks() {
  CycleActivateAllExistWin([
    "ahk_exe Downloader.exe",
    "ahk_exe codeblocks.exe",
  ])
}
