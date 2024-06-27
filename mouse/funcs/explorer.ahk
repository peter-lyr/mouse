; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/09 13:10:40 星期日

ExplorerMainPanel := ["DirectUIHWND2", "Microsoft.UI.Content.DesktopChildSiteBridge1"]
ExplorerTreeView := ["SysTreeView321"]
ExplorerAddress := ["Microsoft.UI.Content.DesktopChildSiteBridge2", "Microsoft.UI.Content.DesktopChildSiteBridge3"]

DesktopAhkClass := "Program Manager"
ExplorerAhkClass := "ahk_class CabinetWClass"

diff_x0 := 300
diff_y0 := 300
diff_w := 190
diff_h := 30

#HotIf WinActive(ExplorerAhkClass)

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

ExplorerAllTabsToOneWindow() {
  Global first_id
  ids := WinGetList(ExplorerAhkClass)
  if ids.Length == 1 {
    Return
  }
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
  WinGetPos(&x, &y, &w, &h, first_id)
  WinMove(0, 0, , , first_id)
  WinActivate(first_id)
  WinWaitActive(first_id)
  For id in ids {
    If (first_id == id) {
      Continue
    }
    WinActivate(id)
    WinWaitActive(id)
    WinMove(diff_x0, diff_y0, , , id)
    Sleep 100
    MouseClick("Left", diff_x0 + diff_w, diff_y0 + diff_h, , , "D")
    MouseMove(diff_w, diff_h)
    Sleep 100
    Click("Up")
  }
  MouseMove(x0, y0)
  SetTimer(() => WinMove(x, y, w, h, first_id), -100)
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

ActivateDesktop() {
  If Not WinActive(DesktopAhkClass) {
    WinActivate(DesktopAhkClass)
  }
}

#HotIf WinActive(ExplorerAhkClass)

f1:: {
  ExplorerAllTabsToOneWindow()
}

f12:: {
  ToggleExplorerMainPanelTreeView()
}

#HotIf WinActive(ExplorerAhkClass) And StrInArray(ControlGetClassNN(ControlGetFocus(ExplorerAhkClass)), ExplorerTreeView)

~Enter:: {
  SetTimer(() => TryControlFocus(ExplorerMainPanel), -100)
}

#HotIf
