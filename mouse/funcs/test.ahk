TestA() {

  ; PostMessage 0x50, 0, 0x4090409, , "A" ; ok
  ; ; DllCall("ActivateKeyboardLayout", "UInt", 0x0409, "UInt", 0) ; 不OK

  ; Send("#{Space}")

  ; ; 测试切换输入法
  ; ; 确实会不起效果
  ; RunPyWithArgs(".input-method.py", "ZH")

  ; ; 测试切换输入法
  ; ; 这个是OK的
  ; Send("#{Space}")

}

TestB() {

  ; PostMessage 0x50, 0, 0x8040804, , "A" ; ok
  ; ; DllCall("ActivateKeyboardLayout", "UInt", 0x0804, "UInt", 0) ; 不OK

  ; ; 测试切换输入法
  ; ; 这个OK
  ; RunPyWithArgs(".input-method.py", "EN")

}
