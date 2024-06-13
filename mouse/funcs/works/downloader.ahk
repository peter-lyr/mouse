; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/13 14:44:45 星期四

ActivateAllDownloader() {
  For id in WinGetList("ahk_exe Downloader.exe") {
    WinActivate(id)
  }
}
