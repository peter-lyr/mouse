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

WinSplitX := []
WinSplitY := []
WinSplitW := []
WinSplitH := []
WinSplitIndex := []

WinSplitDo(cnt) {
  Global WinSplitX ,WinSplitY ,WinSplitW ,WinSplitH, WinSplitIndex
  WinSplitX := []
  WinSplitY := []
  WinSplitW := []
  WinSplitH := []
  WinSplitIndex := []
  WinGetPos(&_x, &_y, &_w, &_h, "A")
  Loop cnt {
    i := A_Index
    Loop cnt {
      j := A_Index
      WinSplitX.Push(Integer(_x + (j - 1) * _w / cnt))
      WinSplitY.Push(Integer(_y + (i - 1) * _h / cnt))
      WinSplitW.Push(Integer(_w / cnt))
      WinSplitH.Push(Integer(_h / cnt))
      WinSplitIndex.Push((i - 1) * cnt + j)
    }
  }
}

WinSplitTest() {
  WinSplitDo(3)
  DrawRectangles(WinSplitX, WinSplitY, WinSplitW, WinSplitH, WinSplitIndex)
}

SelClick() {
  WinSplitDo(5)
  SelClickDo(WinSplitX, WinSplitY, WinSplitW, WinSplitH, WinSplitIndex)
}

ClickWhenCursorArrowDo(x, y, w, h) {
  MouseGetPos(&x0, &y0)
  cnt := 8
  Loop cnt - 1 {
    _x := Integer(x + A_Index * w / cnt)
    _y := Integer(y + A_Index * h / cnt)
    MouseMove(_x, _y, 0)
    Sleep 20
    If A_Cursor == "Arrow" {
      MouseClick("Left", _x, _y)
      Break
    }
  }
  MouseMove(x0, y0, 0)
}

ClickWhenCursorArrow() {
  MouseGetPos(&x0, &y0)
  WinGetPos(&x, &y, &w, &h, "A")
  ClickWhenCursorArrowDo(x, y, w, h)
  MouseMove(x0, y0, 0)
}
