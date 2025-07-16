; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/21 12:47:07 Tuesday

d := "right_down"

A(1, 1, 1, 1, d, [
  "R", W("WinMinimize", WinMinimizeRbuttonPressWin),
  "U", W("<Ctrl-Win-Left>", S("^#{Left}")),
  "D", W("<Ctrl-Win-Right>", S("^#{Right}")),
])

A(1, 1, 1, 2, d, [
  "R", W("<Ctrl-V>", S("^v")),
])

A(1, 1, 1, 6, d, [
  "R", W("WinMinimize", WinMinimizeRbuttonPressWin),
])
