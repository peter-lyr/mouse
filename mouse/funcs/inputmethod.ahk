inputmethod_exes := ["nvim-qt.exe", "emacs.exe"]

last_wid := 0
cur_wid  := 1

For p In inputmethod_exes {
  FileAppend "", Format("C:\\Windows\\Temp\\{:}-input-method.txt", p)
}

GetCurrentKeyboardLayout() {
  Global cur_wid
  DetectHiddenWindows True
  threadID := DllCall("GetWindowThreadProcessId", "UInt", cur_wid, "UInt", 0)
  hkl := DllCall("GetKeyboardLayout", "UInt", threadID)
  hkl := DllCall("GetKeyboardLayout", "UInt", threadID)
  hkl := DllCall("GetKeyboardLayout", "UInt", threadID)
  hkl := DllCall("GetKeyboardLayout", "UInt", threadID)
  hkl := DllCall("GetKeyboardLayout", "UInt", threadID)
  hkl := DllCall("GetKeyboardLayout", "UInt", threadID)
  DetectHiddenWindows False
  If (hkl == 0x4090409) { ; en
    Return 0
  }
  Return 1
}

ChangeInputMethod(lang) {
  InputMethod := GetCurrentKeyboardLayout()
  If lang == "1" { ; zh
    If InputMethod == 0 {
      Send("#{Space}")
    }
  } Else {
    If InputMethod == 1 {
      Send("#{Space}")
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
    If last_wid != cur_wid {
      last_wid := cur_wid
      SetTimer(() => ChangeInputMethod("1"), -10)
    }
  }
}
