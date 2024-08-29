; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/14 00:10:36 Friday

MinimizeAll() {
  MinimizeAllExistWin([
    "ahk_exe WXWork.exe",
    "ahk_exe WeChat.exe",
    "ahk_class CabinetWClass",
    ; "ahk_exe msedge.exe",
    "ahk_exe Downloader.exe",
    "ahk_exe codeblocks.exe",
  ])
}

MinimizeOrActivateMsedge() {
  If (WinActive("ahk_exe msedge.exe")) {
    MinimizeAll()
    WinActivate("ahk_exe nvim-qt.exe")
    WinMinimize("ahk_exe msedge.exe")
  } Else {
    If (WinExist("ahk_exe msedge.exe")) {
      WinActivate("ahk_exe msedge.exe")
    } Else {
      Run("msedge.exe")
    }
  }
}

ActivateCycleWeChatWXWork() {
  ; MinimizeAll()
  CycleActivateAllExistWin([
    "ahk_exe WXWork.exe",
    "ahk_exe WeChat.exe",
  ])
}

ActivateCycleExplorerMsedge() {
  ; MinimizeAll()
  CycleActivateAllExistWin([
    "ahk_class CabinetWClass",
    "ahk_exe msedge.exe",
  ])
}

ActivateEmacs() {
  ; MinimizeAll()
  ActivateDesktop()
  CycleActivateAllExistWin([
    "ahk_exe emacs.exe",
    "ahk_exe emacs.exe",
  ])
}

ActivateCycleDownloaderCodeBlocks() {
  ; MinimizeAll()
  CycleActivateAllExistWin([
    "ahk_exe Downloader.exe",
    "ahk_exe codeblocks.exe",
  ])
}
