; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/04 13:41:37 Tuesday

CbpBuild() {
  ActivateWaitSend("ahk_exe codeblocks.exe", "{Esc}{F7}")
  SetTimer () => [
    Send("{Alt Down}{Tab Down}"),
    Send("{Alt Up}"),
    Send("{Tab Up}"),
  ], -200
}

~F6:: {
  CbpBuild()
}
