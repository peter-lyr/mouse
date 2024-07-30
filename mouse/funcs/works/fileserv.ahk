fileserv_exe := "ahk_exe Fileserv.exe"

ActivateFileserv() {
  If WinExist(fileserv_exe) {
    WinActivate(fileserv_exe)
  } Else {
    Run("Fileserv.exe")
  }
  WinWaitActivate(fileserv_exe)
}

CloseFileserv() {
  If Not WinExist(fileserv_exe) {
    Return
  }
  wid := WinGetId("A")
  ActivateFileserv()
  Send("!{Space}c")
  WinWaitActivate(wid)
}

FileServUpClip() {
  wid := WinGetId("A")
  ActivateFileserv()
  Try {
    WinGetPos(&x1, &y1, , , fileserv_exe)
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
  WinWaitActivate(fileserv_exe)
  Try {
    WinGetPos(&x1, &y1, , , fileserv_exe)
    MouseGetPos(&x0, &y0)
    MouseClick("Left", x1 + 124, y1 + 36, , 0, "D")
    MouseMove(x0, y0)

    Controls := WinGetControls("A")
    ControlList := []
    for ClassNN in Controls {
      If InStr(ClassNN, ".Edit.") {
        ControlList.Push(ClassNN)
      }
    }
    If ControlList.Length >= 3 {
      LibEditClassNN := ControlList[ControlList.Length-3+1]
    }

    ; test
    ; Controls := WinGetControls("A")
    ; ControlList := ""
    ; for ClassNN in Controls {
    ;   If InStr(ClassNN, ".Edit.") {
    ;     ControlList .= ClassNN . ":(" . ControlGetText(ClassNN) . ")`n"
    ;     ; ControlList .= ClassNN . "`n"
    ;   }
    ; }
    ; if (ControlList = "")
    ;   msgbox "The active window has no controls."
    ; else
    ;   msgbox ControlList

    Loop 10 {
      ControlSend("^a^a{Del}", LibEditClassNN)
      If Not ControlGetText(LibEditClassNN) {
        ControlSendText(A_Clipboard, LibEditClassNN)
        ControlFocus(ControlGetClassNN("确定"))
        Send("{Space}")
        Break
      }
    }
  }
  SetTimer(() => WinWaitActivate(wid), -10)
}

FileServLibShowDir() {
  wid := WinGetId("A")
  ActivateFileserv()
  WinWaitActivate(fileserv_exe)
  Try {
    WinGetPos(&x1, &y1, , , fileserv_exe)
    MouseGetPos(&x0, &y0)
    MouseClick("Left", x1 + 124, y1 + 36, , 0, "D")
    ControlFocus(ControlGetClassNN("确定"))
    MouseMove(x0, y0)
  }
  WinWaitActivate(wid)
}

FileServShowLog() {
  wid := WinGetId("A")
  ActivateFileserv()
  WinWaitActivate(fileserv_exe)
  Try {
    WinGetPos(&x1, &y1, , , fileserv_exe)
    MouseGetPos(&x0, &y0)
    MouseClick("Left", x1 + 27, y1 + 36, , 0, "D")
    MouseMove(x0, y0)
  }
  WinWaitActivate(wid)
}

FileServLibToggleDir() {
  wid := WinGetId("A")
  ActivateFileserv()
  WinWaitActivate(fileserv_exe)
  Try {
    WinGetPos(&x1, &y1, , , fileserv_exe)
    MouseGetPos(&x0, &y0)
    MouseClick("Left", x1 + 124, y1 + 36, , 0, "D")
    MouseMove(x0, y0)
    ControlSetChecked(1, ControlGetClassNN("库目录"))
    ControlFocus(ControlGetClassNN("确定"))
    SetTimer(() => [
      Send("{Space}")
    ], -200)
  }
  SetTimer(() => WinWaitActivate(wid), -400)
}
