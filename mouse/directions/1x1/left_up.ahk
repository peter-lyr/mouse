; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/23 10:05:06 Thursday

; j: just info

d := "left_up"

A(1, 1, 1, 1, d, [
  "R", NavigateUp,
  "U", NavigateForward,
  "D", NavigateBackward,
])

A(1, 1, 1, 5, d, [
  "R", W("StartAppDcfFolder", StartAppDcfFolder),
])
