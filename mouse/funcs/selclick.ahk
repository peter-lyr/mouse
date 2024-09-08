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
