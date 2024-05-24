; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/24 11:08:46 Friday

_dir := "up"

; Snipaste
; See https://github.com/Snipaste/feedback/wiki/命令行选项

AddFunction(1, 1, 1, 1, _dir, [
  "R", WIF("Snipaste snip", () => Run("Snipaste snip")),
])

AddFunction(1, 1, 1, 2, _dir, [
  "R", WIF("Snipaste paste", () => Run("Snipaste paste")),
])
