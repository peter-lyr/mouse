; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/20 14:18:09 Monday

_dir := "right_up"

AddFunction(1, 1, _dir, [
  "Ri", "WinMaximizeRestore",
  "Rf", WinMaximizeRestoreRbuttonPressWin,
  "Ui", "Volume_Up",
  "Uf", () => [ Send("{Volume_Up}"), ],
  "Di", "Volume_Down",
  "Df", () => [ Send("{Volume_Down}"), ],
])

AddFunction(1, 2, _dir, [
  "Ri", "Copy File Path",
  "Rf", CopyFilePath,
  "Ui", "Volume_Up 10",
  "Uf", () => [
    SoundSetVolume("+8"),
    Send("{Volume_Up}"),
  ],
  "Di", "Volume_Down 10",
  "Df", () => [
    SoundSetVolume("-8"),
    Send("{Volume_Down}"),
  ],
])

AddFunction(1, 3, _dir, [
  "Ui", "Volume_Up 30",
  "Uf", () => [
    SoundSetVolume("+28"),
    Send("{Volume_Up}"),
  ],
  "Di", "Volume_Down 30",
  "Df", () => [
    SoundSetVolume("-28"),
    Send("{Volume_Down}"),
  ],
])

AddFunction(1, 4, _dir, [
  "Ui", "SoundBeep(523Hz, 800ms)",
  "Uf", () => [
    SoundBeep(523, 800),
  ],
  ; "Di", "SoundPlay",
  ; "Df", () => [
  ;   SoundPlay("C:\Users\depei_liu\DEPEI\Repos\2024s\w\d\bin\拽犯法么（硬曲热播）.mp3"),
  ; ],
])
