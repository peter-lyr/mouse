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

TestA() {

  WinSplit3()

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
