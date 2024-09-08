ControlDisplay() {
  Global Lines
  Global TextPos
  For line in Lines {
    line.Destroy()
  }
  Lines := []
  TextPos := []
  Try {
    _wid := WinGetId("A")
  } Catch {
    Return
  }
  Controls := WinGetControls(_wid)
  WinGetPos(&_x0, &_y0, , , _wid)
  ; Try {
  ;   i := 1
  ;   ControlFocus(Controls[i], _wid)
  ;   ControlGetPos(&_x, &_y, &_w, &_h, Controls[i], _wid)
  ;   DrawRectangle(_x0 + _x, _y0 + _y, _w, _h, i)
  ; }
  For _control In Controls {
    ; Try {
      ControlGetPos(&_x, &_y, &_w, &_h, _control, _wid)
      DrawRectangle(_x0 + _x, _y0 + _y, _w, _h, A_Index)
    ; } Catch As err {
    ;   MsgBox Format("{1}: {2}.`n`nFile:`t{3}`nLine:`t{4}`nWhat:`t{5}`nStack:`n{6}"
    ;       , type(err), err.Message, err.File, err.Line, err.What, err.Stack)
    ;   MsgBox(Mod(A_Index, BarColors.Length + 1))
      ; MsgBox(type(_control))
    ; }
    ; Break
  }
  ; msgbox(Lines.Length)
}

; RunWaitOne(command) {
;   shell := ComObject("WScript.Shell")
;   launch := "cmd.exe /c " . command . " > temp.txt"
;   exec := shell.Run(launch, 0, true)
;   ; 读取并返回命令的输出
;   output := FileRead("temp.txt")
;   FileDelete "temp.txt"
;   return output
; }
