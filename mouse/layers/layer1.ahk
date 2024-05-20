; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/20 14:18:09 Monday

AddFunction(1, "right_up", [
  "ri", "WinMaximizeRestore",
  "rf", WinMaximizeRestoreRbuttonPressWin,
  "ui", "Volume_Up",
  "uf", () => [ Send("{Volume_Up}"), ],
  "di", "Volume_Down",
  "df", () => [ Send("{Volume_Down}"), ],
])

AddFunction(1, "right_down", [
  "ri", "WinMinimize",
  "rf", WinMinimizeRbuttonPressWin,
  ; "ui", "",
  ; "uf", 0,
  ; "di", "",
  ; "df", 0,
])
