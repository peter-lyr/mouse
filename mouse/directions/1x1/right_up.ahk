; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/20 14:18:09 Monday

_dir := "right_up"

AddFunction(1, 1, 1, 1, _dir, [
  "R", (j) => j And "WinMaximizeRestore" Or WinMaximizeRestoreRbuttonPressWin(),
  "U", (j) => j And "Volume_Up" Or Send("{Volume_Up}"),
  "D", (j) => j And "Volume_Down" Or Send("{Volume_Down}"),
])

AddFunction(1, 1, 1, 2, _dir, [
  "R", (j) => j And "Copy File Path" Or CopyFilePath(),
  "U", (j) => j And "Volume_Up 10" Or [
    SoundSetVolume("+8"),
    Send("{Volume_Up}"),
  ],
  "D", (j) => j And "Volume_Down 10" Or [
    SoundSetVolume("-8"),
    Send("{Volume_Down}"),
  ],
])

AddFunction(1, 1, 1, 3, _dir, [
  "U", (j) => j And "Volume_Up 20" Or [
    SoundSetVolume("+18"),
    Send("{Volume_Up}"),
  ],
  "D", (j) => j And "Volume_Down 20" Or [
    SoundSetVolume("-18"),
    Send("{Volume_Down}"),
  ],
])

AddFunction(1, 1, 1, 4, _dir, [
  "U", (j) => j And "SoundBeep(523Hz, 800ms)" Or [
    SoundBeep(523, 800),
  ],
  ; "D", (j) => j And "SoundPlay" Or [
  ;   SoundPlay("C:\Users\depei_liu\DEPEI\Repos\2024s\w\d\bin\拽犯法么（硬曲热播）.mp3"),
  ; ],
])
