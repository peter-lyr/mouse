; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/09 13:17:06 星期日

#HotIf WinActive("ahk_exe msedge.exe")

!l:: {
  Send("!{Right}")
}

!h:: {
  Send("!{Left}")
}

!k:: {
  Send("!{Up}")
}

!j:: {
  Send("{Up}")
}

!m:: {
  Send("{Down}")
}

#HotIf
