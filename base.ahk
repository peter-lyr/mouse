; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/17 23:55:49 星期五

Print(text:="222222222222", timeout:=4000) {
  Tooltip(text)
    SetTimer(Tooltip, timeout)
}


; 见https://wyagd001.github.io/v2/docs/lib/_HotIf.htm#ExVolume
MouseIsOver(WinTitle) {
  MouseGetPos ,, &Win
    return WinExist(WinTitle " ahk_id " Win)
}
