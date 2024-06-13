; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/13 14:44:45 星期四

ActivateCycleDownloaderFileServ() {
  CycleActivateAllExistWin([
    "ahk_exe Downloader.exe",
    "ahk_exe Fileserv.exe",
  ])
}
