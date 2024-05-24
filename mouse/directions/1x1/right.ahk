; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/20 14:18:09 Monday

d := "right"

A(1, 1, 1, 1, d, [
  "R", W("<Esc>", () => Send("{Esc}")),
])

A(1, 1, 2, 1, d, [
  "R", W("<Esc>", () => Send("{Esc}")),
])

A(1, 1, 1, 2, d, [
  "R", W("<Enter>", () => Send("{Enter}")),
])

A(1, 1, 1, 3, d, [
  "R", W("<Space>", () => Send(" ")),
])
