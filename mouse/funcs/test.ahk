TestA() {

  ; MsgBox(A_ClipBoard)

  ; MsgBox(Type("w"))

  ; WinSplitTest()
  ; ClickWhenCursorArrow()

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

  Run(GetWkSw("Fileserv\Fileserv.exe"))

  ; ; 测试切换输入法
  ; ; 这个OK
  ; RunPyWithArgs(".input-method.py", "EN")

}

TestC() {
  ControlDisplay()
}
