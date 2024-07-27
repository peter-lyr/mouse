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
  WinWaitActivate("ahk_exe Fileserv.exe")
}

FileServUpClip() {
  wid := WinGetId("A")
  ActivateFileserv()
  Try {
    WinGetPos(&x1, &y1, , , "ahk_exe Fileserv.exe")
    MouseGetPos(&x0, &y0)
    MouseClick("Left", x1 + 76, y1 + 36, , 0, "D")
    MouseMove(x0, y0)
    ControlFocus(ControlGetClassNN("上传剪贴板"))
    Send("{Space}")
  }
  WinWaitActivate(wid)
}

FileServLibChangeDir() {
  wid := WinGetId("A")
  ActivateFileserv()
  WinWaitActivate("ahk_exe Fileserv.exe")
  Try {
    WinGetPos(&x1, &y1, , , "ahk_exe Fileserv.exe")
    MouseGetPos(&x0, &y0)
    MouseClick("Left", x1 + 124, y1 + 36, , 0, "D")
    MouseMove(x0, y0)
    LibEditClassNN := "WindowsForms10.EDIT.app.0.33c0d9d4"
    Loop 10 {
      ControlSend("^a^a{Del}", LibEditClassNN)
      If Not ControlGetText(LibEditClassNN) {
        ControlSendText(A_Clipboard, LibEditClassNN)
        Break
      }
    }
  }
  WinWaitActivate(wid)
}

FileServLibToggleDir() {
  wid := WinGetId("A")
  ActivateFileserv()
  WinWaitActivate("ahk_exe Fileserv.exe")
  Try {
    WinGetPos(&x1, &y1, , , "ahk_exe Fileserv.exe")
    MouseGetPos(&x0, &y0)
    MouseClick("Left", x1 + 124, y1 + 36, , 0, "D")
    MouseMove(x0, y0)
    ControlSetChecked(1, ControlGetClassNN("库目录"))
  }
  WinWaitActivate(wid)
}

#HotIf WinExist("ahk_exe codeblocks.exe")

F6:: {
  If (Not CbpBuild()) {
    Send("{F6}")
  }
}

#HotIf
