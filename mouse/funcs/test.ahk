RunWaitOne(command) {
  shell := ComObject("WScript.Shell")
  launch := "cmd.exe /c " . command . " > temp.txt"
  exec := shell.Run(launch, 0, true)
  ; 读取并返回命令的输出
  output := FileRead("temp.txt")
  FileDelete "temp.txt"
  return output
}

TestA() {

  result := StrSplit(Strip(RunWaitOne("dir")), "`n")
  ; MsgBox(Type(result))
  MsgBox(result.Length)

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
