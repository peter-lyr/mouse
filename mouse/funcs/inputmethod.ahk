inputmethod_exes := ["nvim-qt.exe", "emacs.exe"]

last_wid := 0
cur_wid  := 1

For p In inputmethod_exes {
  FileAppend "", Format("C:\\Windows\\Temp\\{:}-input-method.txt", p)
}

ChangeInputMethod(lang) {
  Global cur_wid
  Try {
    If lang == "1" { ; zh
      PostMessage 0x50, 0, 0x8040804, , cur_wid
    } Else {
      PostMessage 0x50, 0, 0x4090409, , cur_wid
    }
  }
}

DetectInputMethod() {
  Global last_wid
  Global cur_wid
  Try {
    cur_wid := WinGetID("A")
    For p In inputmethod_exes {
      If WinActive("ahk_exe " . p) {
        If last_wid != cur_wid {
          last_wid := cur_wid
          Loop Read, Format("C:\\Windows\\Temp\\{:}-input-method.txt", p) {
            temp := A_LoopReadLine
            SetTimer(() => ChangeInputMethod(temp), -10)
            Break
          }
          Return
        }
      }
    }
    If (WinGetClass(cur_wid) == "XamlExplorerHostIslandWindow" Or WinGetTitle(cur_wid) == "Task Switching") { ; Alt Tab
      Return
    }
    If last_wid != cur_wid {
      last_wid := cur_wid
      If (WinGetTitle(cur_wid) == "Task Switching" Or WinGetClass(cur_wid) == "XamlExplorerHostIslandWindow") {
        Return
      }
      SetTimer(() => ChangeInputMethod("1"), -10)
    }
  }
}
