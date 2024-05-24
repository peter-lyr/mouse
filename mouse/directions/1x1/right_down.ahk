; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/21 12:47:07 Tuesday

d := "right_down"

A(1, 1, 1, 1, d, [
  "R", W("WinMinimize", WinMinimizeRbuttonPressWin),
])

A(1, 1, 1, 2, d, [
  "R", W("<Ctrl-V>", () => Send("^v")),
])
