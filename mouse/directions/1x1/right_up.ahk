; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/20 14:18:09 Monday

d := "right_up"

A(1, 1, 1, 1, d, [
  "R", W("WinMaximizeRestore", WinMaximizeRestoreRbuttonPressWin),
  "U", W("Volume_Up", () => Send("{Volume_Up}")),
  "D", W("Volume_Down", () => Send("{Volume_Down}")),
])

A(1, 1, 1, 2, d, [
  "R", W("<Ctrl-C>", () => Send("^c")),
  "U", W("Volume_Up 10", () => [
    SoundSetVolume("+8"),
    Send("{Volume_Up}"),
  ]),
  "D", W("Volume_Down 10", () => [
    SoundSetVolume("-8"),
    Send("{Volume_Down}"),
  ]),
])

A(1, 1, 1, 3, d, [
  "R", W("Copy File Path", CopyFilePath),
  "U", W("Volume_Up 20", () => [
    SoundSetVolume("+18"),
    Send("{Volume_Up}"),
  ]),
  "D", W("Volume_Down 20", () => [
    SoundSetVolume("-18"),
    Send("{Volume_Down}"),
  ]),
])

A(1, 1, 1, 4, d, [
  "U", W("SoundBeep(523Hz, 800ms)", () => SoundBeep(523, 800)),
  ; "D", W("SoundPlay", () => SoundPlay("C:\Users\depei_liu\DEPEI\Repos\2024s\w\d\bin\拽犯法么（硬曲热播）.mp3")),
])
