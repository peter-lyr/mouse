TestA() {
  ; 确实会不起效果
  RunPyWithArgs(".input-method.py", "ZH")
}

TestB() {
  ; 这个OK
  RunPyWithArgs(".input-method.py", "EN")
}
