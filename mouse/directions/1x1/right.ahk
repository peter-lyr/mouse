; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/20 14:18:09 Monday

d := "right"

A(1, 1, 1, 1, d, [
  "R", W("<Esc>", S("{Esc}")),
])

AA(d, [
  "R", W("<Esc>", S("{Esc}")),
], [1], [1], [2, 3])

A(1, 1, 1, 2, d, [
  "R", W("<Enter>", S("{Enter}")),
])

A(1, 1, 1, 3, d, [
  "R", W("<Space>", S(" ")),
])

A(1, 1, 1, 4, d, [
  "R", W("<Ctrl-v><Enter>", S("^v{Enter}")),
])

A(1, 1, 1, 5, d, [
  "R", W("<Ctrl-a><Ctrl-v><Enter>", S("^a^v{Enter}")),
])
