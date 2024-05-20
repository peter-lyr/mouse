; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/19 23:55:59 星期日

AddFunction(1, "right_up", FunctionWrap(Array2Map([
  "ri", "WinMaximizeRestore",
  "rf", WinMaximizeRestoreRbuttonPressWin,
  "ui", "Volume_Up",
  "uf", () => Send("{Volume_Up}"),
  "di", "Volume_Down",
  "df", () => Send("{Volume_Down}"),
])))
