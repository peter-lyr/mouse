; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/23 10:05:06 Thursday

; j: just info

_dir := "left_up"

AddFunction(1, 1, _dir, [
  "R", NavigateUp,
  "U", NavigateForward,
  "D", NavigateBackward,
])
