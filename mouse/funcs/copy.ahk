; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/23 01:31:09 星期四

; CopyFilePathDo() {
;   A_Clipboard := A_Clipboard
;   SetTimer () => Print(A_Clipboard), -20
; }
;
; CopyFilePath() {
;   If (WinActive("ahk_exe explorer.exe")) {
;     Send("^c")
;     SetTimer CopyFilePathDo, -20
;   }
; }
;
; ^+c:: {
;   CopyFilePath()
; }
