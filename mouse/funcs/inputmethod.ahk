inputmethod_exes := ["nvim-qt.exe", "emacs.exe"]

last_wid := 0
cur_wid  := 1

DetectInputMethod() {
  Global last_wid
  Global cur_wid
  Try {
    cur_wid := WinGetID("A")
    For p In inputmethod_exes {
      If WinActive("ahk_exe " . p) {
        If last_wid != cur_wid {
          last_wid := cur_wid
          Print(p, 800)
          Return
        }
      }
    }
    If last_wid != cur_wid {
      last_wid := cur_wid
      Print(WinGetProcessName(cur_wid), 800)
    }
  }
}
