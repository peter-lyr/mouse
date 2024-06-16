; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/09 13:10:40 星期日

ExplorerMainPanel := ["DirectUIHWND2", "Microsoft.UI.Content.DesktopChildSiteBridge1"]
ExplorerTreeView := ["SysTreeView321"]
ExplorerAddress := ["Microsoft.UI.Content.DesktopChildSiteBridge2", "Microsoft.UI.Content.DesktopChildSiteBridge3"]

ExplorerAhkClass := "ahk_class CabinetWClass"

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
  MouseGetPos(&x, &y)
  If Not IsSet(first_id) {
    For id in WinGetList(ExplorerAhkClass) {
      first_id := id
      Break
    }
  } Else {
    _first_id := 0
    _flag := 0
    For id in WinGetList(ExplorerAhkClass) {
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
  WinMove(0, 0, , , first_id)
  WinActivate(first_id)
  WinWaitActive(first_id)
  For id in WinGetList(ExplorerAhkClass) {
    If (first_id == id) {
      Continue
    }
    WinActivate(id)
    WinWaitActive(id)
    WinMove(300, 300, , , id)
    Sleep 100
    MouseClick("Left", 590, 350, , , "D")
    MouseMove(390, 80)
    Sleep 100
    Click("Up")
  }
  MouseMove(x, y)
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
  If Not StrInArray(ControlGetClassNN(ControlGetFocus(ExplorerAhkClass)), ExplorerMainPanel) {
    TryControlFocus(ExplorerMainPanel)
  } Else {
    TryControlFocus(ExplorerTreeView)
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
