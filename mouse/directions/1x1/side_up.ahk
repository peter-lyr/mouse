; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/27 14:08:03 Monday

d := "side_up"

A(1, 1, 1, 0, d, [
  "R", W("Draw Circle En/Dis", DrawCircleEnDis),
])

; [x] FIXDONE:重新初始化圆
A(1, 1, 2, 0, d, [
  "R", W("InitCircle", InitCircle),
])
