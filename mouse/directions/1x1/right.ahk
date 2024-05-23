; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/20 14:18:09 Monday

_dir := "right"

AddFunction(1, 1, 1, 1, _dir, [
  "R", WIF("<Esc>", () => Send("{Esc}")),
])

AddFunction(1, 1, 1, 2, _dir, [
  "R", WIF("<Enter>", () => Send("{Enter}")),
])

AddFunction(1, 1, 1, 3, _dir, [
  "R", WIF("<Space>", () => Send(" ")),
])
