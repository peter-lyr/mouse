; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/04 13:41:37 Tuesday

CbpBuild() {
  If (WinExist("ahk_exe codeblocks.exe") And WinExist("ahk_exe Downloader.exe")) {
    ActivateWaitMaximizeSend("ahk_exe codeblocks.exe", "{Esc}{F7}")
    SetTimer () => WinActivate("ahk_exe Downloader.exe"), -400
    SetTimer () => WinRestore("ahk_exe codeblocks.exe"), -200
    Return 1
  }
  Return 0
}

ActivateFileserv() {
  If WinExist("ahk_exe Fileserv.exe") {
    WinActivate("ahk_exe Fileserv.exe")
  } Else {
    Run("Fileserv.exe")
  }
}

FileServUpClip() {
  If (WinExist("ahk_exe Fileserv.exe")) {
    wid := WinGetId("A")
    WinWaitActivate("ahk_exe Fileserv.exe")
    Try {
      WinGetPos(&x1, &y1, , , "ahk_exe Fileserv.exe")
      MouseGetPos(&x0, &y0)
      MouseClick("Left", x1 + 76, y1 + 36, , 0, "D")
      MouseMove(x0, y0)
      ControlFocus("WindowsForms10.BUTTON.app.0.33c0d9d4")
      Send("{Space}")
    }
    WinWaitActivate(wid)
  }
}

FileServLibChangeDir() {
  If (WinExist("ahk_exe Fileserv.exe")) {
    wid := WinGetId("A")
    WinWaitActivate("ahk_exe Fileserv.exe")
    Try {
      WinGetPos(&x1, &y1, , , "ahk_exe Fileserv.exe")
      MouseGetPos(&x0, &y0)
      MouseClick("Left", x1 + 124, y1 + 36, , 0, "D")
      MouseMove(x0, y0)
      ControlSetChecked(1, "WindowsForms10.BUTTON.app.0.33c0d9d6")
      ControlSend("^a^v", "WindowsForms10.EDIT.app.0.33c0d9d4")
    }
    WinWaitActivate(wid)
  }
}

FileServLibDisableDir() {
}

#HotIf WinExist("ahk_exe codeblocks.exe")

F6:: {
  If (Not CbpBuild()) {
    Send("{F6}")
  }
}

#HotIf
