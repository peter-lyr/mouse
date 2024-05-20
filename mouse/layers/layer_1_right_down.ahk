; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/20 14:18:09 Monday

AddFunction(1, "right_down", FunctionWrap(Array2Map([
  "ri", "WinMinimize",
  "rf", WinMinimizeRbuttonPressWin,
  "ui", "",
  "uf", 0,
  "di", "",
  "df", 0,
])))
