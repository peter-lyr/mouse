; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/09 13:17:06 星期日

Browser() {
  ActivateMsedge()
  G(
    "h", ["Browser_Back", () => Send("{Browser_Back}"), "Continue", NormalWaitSeconds],
    "l", ["Browser_Forward", () => Send("{Browser_Forward}"), "Continue", NormalWaitSeconds],
    "r", ["Browser_Refresh", () => Send("{Browser_Refresh}"), "Continue", NormalWaitSeconds],
    "s", ["Browser_Search", () => Send("{Browser_Search}"), "Continue", NormalWaitSeconds],
    "a", ["Browser_Home", () => Send("{Browser_Home}"), "Continue", NormalWaitSeconds],
    "f", ["Browser_Favorites", () => Send("{Browser_Favorites}"), "Continue", NormalWaitSeconds],
  )
}

#HotIf

#!l:: {
  Send("!{Right}")
}

#!h:: {
  Send("!{Left}")
}

#!k:: {
  Send("!{Up}")
}

#!j:: {
  Send("{Up}")
}

#!m:: {
  Send("{Down}")
}
