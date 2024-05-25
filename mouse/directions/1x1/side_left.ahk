; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/25 20:24:11 星期六

d := "side_left"

A(1, 1, 1, 0, d, [
  "R", W("Only Show Mouse Actions", OnlyShowMouseActions),
])

A(1, 1, 2, 0, d, [
  "R", W("No Mouse Actions", DisMouseActionFlag),
])

A(1, 1, 3, 0, d, [
  "R", W("Write Mouse Actions And Open File", WriteInfosAndOpenFile),
])
