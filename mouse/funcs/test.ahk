; RunWaitOne(command) {
;   shell := ComObject("WScript.Shell")
;   launch := "cmd.exe /c " . command . " > temp.txt"
;   exec := shell.Run(launch, 0, true)
;   ; 读取并返回命令的输出
;   output := FileRead("temp.txt")
;   FileDelete "temp.txt"
;   return output
; }

WinSplitDo(cnt) {
  WinGetPos(&_x, &_y, &_w, &_h, "A")
  X := []
  Y := []
  W := []
  H := []
  Index := []
  Loop cnt {
    i := A_Index
    Loop cnt {
      j := A_Index
      X.Push(_x + (j - 1) * _w / cnt)
      Y.Push(_y + (i - 1) * _h / cnt)
      W.Push(_w / cnt)
      H.Push(_h / cnt)
      Index.Push((i - 1) * cnt + j)
    }
  }
  DrawRectangles(X, Y, W, H, Index)
}

WinSplit5() {
  WinSplitDo(5)
}

WinSplit4() {
  WinSplitDo(4)
}

WinSplit3() {
  WinSplitDo(3)
}

WinSplit2() {
  WinSplitDo(2)
}

ClickWhenCursorArrowDo(x, y, w, h) {
  MouseGetPos(&x0, &y0)
  WinGetPos(&x, &y, &w, &h, "A")
  cnt := 8
  Loop cnt - 1 {
    MouseMove(Integer(x + A_Index * w / cnt), Integer(y + A_Index * h / cnt), 0)
    Sleep 20
    If A_Cursor == "Arrow" {
      MouseClick("Left", Integer(x + A_Index * w / cnt), Integer(y + A_Index * h / cnt))
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

TestA() {

  ClickWhenCursorArrow()
  ; WinSplit3()

  ; result := StrSplit(Strip(RunWaitOne("dir")), "`n")
  ; ; MsgBox(Type(result))
  ; MsgBox(result.Length)

  ; MsgBox(RunWaitOne("dir"))

  ; MsgBox "The active window's class is " WinGetClass("A")

  ; Send("#{Space}")

  ; ; 测试切换输入法
  ; ; 确实会不起效果
  ; RunPyWithArgs(".input-method.py", "ZH")

  ; ; 测试切换输入法
  ; ; 这个是OK的
  ; Send("#{Space}")

}

TestB() {

  ; ; 测试切换输入法
  ; ; 这个OK
  ; RunPyWithArgs(".input-method.py", "EN")

}

TestC() {
  ControlDisplay()
}
