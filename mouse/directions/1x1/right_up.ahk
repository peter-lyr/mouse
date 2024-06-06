; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/20 14:18:09 Monday

d := "right_up"

; 1x1x1

A(1, 1, 1, 1, d, [
  "R", W("WinMaximizeRestore", WinMaximizeRestoreRbuttonPressWin),
  "U", W("Volume_Up", S("{Volume_Up}")),
  "D", W("Volume_Down", S("{Volume_Down}")),
])

A(1, 1, 1, 2, d, [
  "R", W("<Ctrl-C>", S("^c")),
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
  "U", W("SoundBeep(100Hz, 200ms)", () => SoundBeep(100, 200)),
  "D", W("SoundBeep(100Hz, 800ms)", () => SoundBeep(100, 800)),
  ; "D", W("SoundPlay", () => SoundPlay("C:\Users\depei_liu\DEPEI\Repos\2024s\w\d\bin\拽犯法么（硬曲热播）.mp3")),
])

; 1x1x2

A(1, 1, 2, 1, d, [
  "R", W("CbpBuild", CbpBuild),
])
