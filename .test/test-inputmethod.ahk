SetTimer(TestInputMethod, 10)

inputmethod_exes := ["nvim-qt.exe", "emacs.exe"]

last_wid := 0
cur_wid  := 1

TestInputMethod() {
  Global last_wid
  Global cur_wid
  Try {
    cur_wid := WinGetID("A")
    For p In inputmethod_exes {
      If WinActive("ahk_exe " . p) {
        If last_wid != cur_wid {
          last_wid := cur_wid
          Tooltip(p)
          Return
        }
      }
    }
    If last_wid != cur_wid {
      last_wid := cur_wid
      Tooltip(WinGetProcessName(cur_wid))
    }
  }
}
