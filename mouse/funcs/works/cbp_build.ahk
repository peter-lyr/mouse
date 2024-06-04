; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/04 13:41:37 Tuesday

CbpBuild() {
  _win := WinGetID("A")
  ActivateWaitSend("ahk_exe codeblocks.exe", "{Esc}{F7}")
  SetTimer () => WinActivate(_win), -200
}

~F6:: {
  CbpBuild()
}
