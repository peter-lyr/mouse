TestA() {

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
