; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/20 14:18:09 Monday

AddFunction(1, 1, "right_up", [
  "ri", "WinMaximizeRestore",
  "rf", WinMaximizeRestoreRbuttonPressWin,
  "ui", "Volume_Up",
  "uf", () => [ Send("{Volume_Up}"), ],
  "di", "Volume_Down",
  "df", () => [ Send("{Volume_Down}"), ],
])

AddFunction(2, 1, "right_up", [
  "ui", "Volume_Up 10",
  "uf", () => [
    SoundSetVolume("+8"),
    Send("{Volume_Up}"),
  ],
  "di", "Volume_Down 10",
  "df", () => [
    SoundSetVolume("-8"),
    Send("{Volume_Down}"),
  ],
])

AddFunction(3, 1, "right_up", [
  "ui", "Volume_Up 30",
  "uf", () => [
    SoundSetVolume("+28"),
    Send("{Volume_Up}"),
  ],
  "di", "Volume_Down 30",
  "df", () => [
    SoundSetVolume("-28"),
    Send("{Volume_Down}"),
  ],
])
