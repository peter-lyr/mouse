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
  If (hkl == 0x4090409) {
    Return 0
  }
  Return 1
}

ChangeInputMethod(lang) {
  InputMethod := GetCurrentKeyboardLayout()
  ; Print(Format("{:X}", InputMethod))
  Print(Format("{:},{:}", InputMethod, lang))
  If lang == "1" { ; zh
    If InputMethod == 0 {
      SetTimer(() => Send("#{Space}"), -10)
      ; Send("#{Space}")
    }
  } Else { ; en
    If InputMethod == 1 {
      ; SetTimer(() => Send("#{Space}"), -1000)
      SetTimer(() => Send("#{Space}"), -10)
      ; Send("#{Space}")
    }
    ; Print(InputMethod . "EN")
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
          ; InputMethod := CmdRunOutput("cd " . A_ScriptDir . "\mouse\funcs" . " && .get-input-method.py")
          ; InputMethod := GetCurrentKeyboardLayout()
          Loop Read, Format("C:\\Windows\\Temp\\{:}-input-method.txt", p) {
            temp := A_LoopReadLine
            SetTimer(() => ChangeInputMethod(temp), -10)
            ; If A_LoopReadLine == "1" {
            ;   Print(Format("C:\\Windows\\Temp\\{:}-input-method.txt: 1 [{:}]", p, InputMethod), 800)
            ;   If InputMethod == 0 {
            ;     Send("#{Space}")
            ;   }
            ; } Else {
            ;   Print(Format("C:\\Windows\\Temp\\{:}-input-method.txt: 0 [{:}]", p, InputMethod), 800)
            ;   If InputMethod == 1 {
            ;     Send("#{Space}")
            ;   }
            ; }
            ; Print(A_LoopReadLine . InputMethod)
            ; Print(A_LoopReadLine)
            ; Print(DllCall("GetKeyboardLayout", "int", 0))
            ; Print(Format("{:}-{:X}", A_LoopReadLine, DllCall("GetKeyboardLayout", "int", 0)))
            ; Print(Format("{:}-{:X}-{:}", A_LoopReadLine, GetCurrentKeyboardLayout(), WinGetProcessName(cur_wid)))
            Break
          }
          Return
        }
      }
    }
    If last_wid != cur_wid {
      last_wid := cur_wid
      ; InputMethod := GetCurrentKeyboardLayout()
      SetTimer(() => ChangeInputMethod("1"), -10)
      ; Print(WinGetProcessName(cur_wid), 800)
      ; Print(WinGetProcessName(cur_wid))
      ; Print(Format("{:}-{:X}", WinGetProcessName(cur_wid), GetCurrentKeyboardLayout()))
    }
  }
}
