; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/09 13:10:40 星期日

ExplorerMainPanel := ["DirectUIHWND2", "Microsoft.UI.Content.DesktopChildSiteBridge1"]
ExplorerTreeView := ["SysTreeView321"]
ExplorerAddress := ["Microsoft.UI.Content.DesktopChildSiteBridge2", "Microsoft.UI.Content.DesktopChildSiteBridge3"]

ExplorerAhkClass := "ahk_class CabinetWClass"

ExplorerAllTabsToOneWindow() {
  Global first_id
  ids := WinGetList(ExplorerAhkClass)
  MouseGetPos(&x0, &y0)
  If Not IsSet(first_id) {
    For id in ids {
      first_id := id
      Break
    }
  } Else {
    _first_id := 0
    _flag := 0
    For id in ids {
      If (A_Index == 1) {
        _first_id := id
      }
      If (id == first_id) {
        _flag := 1
        Break
      }
    }
    If _flag == 0 And _first_id {
      first_id := _first_id
    }
  }
  If Not IsSet(first_id) {
    Return
  }
  WinGetPos(&x, &y, &w, &h, first_id)
  if w < 800 {
    w := 800
    WinMove(x, y, 800, h, first_id)
  }
  if ids.Length == 1 {
    Return
  }
  WinActivate(first_id)
  WinWaitActive(first_id)
  For id in ids {
    If (first_id == id) {
      Continue
    }
    WinActivate(first_id)
    WinWaitActive(first_id)
    WinActivate(id)
    WinWaitActive(id)
    WinMove(x, y, w - 200, h, id)
    WinGetPos(&x1, &y1, &w1, &h1, id)
    Sleep 100
    MouseClick("Left", x1 + 30, y1 + 23, , , "D")
    MouseMove(x + w - 100, y + 23)
    Sleep 300
    Click("Up")
  }
  MouseMove(x0, y0)
}

TryControlFocus(classNNS) {
  For classNN in classNNS {
    Try {
      ControlFocus(classNN, ExplorerAhkClass)
      Return
    }
  }
}

ToggleExplorerMainPanelTreeView() {
  Try {
    If Not StrInArray(ControlGetClassNN(ControlGetFocus(ExplorerAhkClass)), ExplorerMainPanel) {
      TryControlFocus(ExplorerMainPanel)
    } Else {
      TryControlFocus(ExplorerTreeView)
    }
  }
}

#HotIf WinActive(ExplorerAhkClass) Or WinActive(DesktopAhkClass)

:*:;:: {
  ExplorerAllTabsToOneWindow()
}

':: {
  ToggleExplorerMainPanelTreeView()
}

#HotIf WinActive(ExplorerAhkClass)

^+l:: {
  Send("+{Right}")
}

^+h:: {
  Send("+{Left}")
}

^+k:: {
  Send("+{Up}")
}

^+j:: {
  Send("+{Down}")
}

^l:: {
  Send("{Right}")
}

^h:: {
  Send("{Left}")
}

^k:: {
  Send("{Up}")
}

^j:: {
  Send("{Down}")
}

^g:: {
  Send("{AppsKey}")
}

!l:: {
  Send("!{Right}")
}

!h:: {
  Send("!{Left}")
}

!k:: {
  Send("!{Up}")
}

CopyFilePathDo() {
  A_Clipboard := A_Clipboard
  SetTimer () => Print(A_Clipboard), -20
}

CopyFilePath() {
  If (WinActive("ahk_exe explorer.exe")) {
    Send("^c")
    SetTimer CopyFilePathDo, -20
  }
}

^+c:: {
  CopyFilePath()
}

CopyFileAndOpenWithNvimQt() {
  A_Clipboard := A_Clipboard
  cmd := "nvim-qt "
  cmd := cmd . '"'
  cmd := cmd . A_Clipboard
  cmd := cmd . '"'
  cmd := cmd . " -- -u "
  cmd := cmd . '"'
  cmd := cmd . A_ScriptDir
  cmd := cmd . "\mouse\funcs\init-only-colorscheme.lua"
  cmd := cmd . '"'
  CmdRunOutput(cmd)
}

^+Enter:: {
  If (WinActive("ahk_exe explorer.exe")) {
    Send("^c")
    SetTimer CopyFileAndOpenWithNvimQt, -20
  }
}

#HotIf WinActive(ExplorerAhkClass) And StrInArray(ControlGetClassNN(ControlGetFocus(ExplorerAhkClass)), ExplorerTreeView)

; ~Enter:: {
;   SetTimer(() => TryControlFocus(ExplorerMainPanel), -100)
; }

#HotIf
