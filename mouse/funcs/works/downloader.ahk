; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/13 14:44:45 星期四

ActivateAllDownloader() {
  If (Not WinActive("ahk_exe Downloader.exe")) {
    For id in WinGetList("ahk_exe Downloader.exe") {
      WinActivate(id)
    }
  } Else {
    For id in WinGetList("ahk_exe Fileserv.exe") {
      WinActivate(id)
    }
  }
}
