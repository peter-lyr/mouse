; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/20 14:18:09 Monday

_dir := "right_up"

AddFunction(1, 1, 1, 1, _dir, [
  "R", WIF("WinMaximizeRestore", WinMaximizeRestoreRbuttonPressWin),
  "U", WIF("Volume_Up", () => Send("{Volume_Up}")),
  "D", WIF("Volume_Down", () => Send("{Volume_Down}")),
])

AddFunction(1, 1, 1, 2, _dir, [
  "R", WIF("Copy File Path", CopyFilePath),
  "U", WIF("Volume_Up 10", () => [
    SoundSetVolume("+8"),
    Send("{Volume_Up}"),
  ]),
  "D", WIF("Volume_Down 10", () => [
    SoundSetVolume("-8"),
    Send("{Volume_Down}"),
  ]),
])

AddFunction(1, 1, 1, 3, _dir, [
  "U", WIF("Volume_Up 20", () => [
    SoundSetVolume("+18"),
    Send("{Volume_Up}"),
  ]),
  "D", WIF("Volume_Down 20", () => [
    SoundSetVolume("-18"),
    Send("{Volume_Down}"),
  ]),
])

AddFunction(1, 1, 1, 4, _dir, [
  "U", WIF("SoundBeep(523Hz, 800ms)", () => SoundBeep(523, 800)),
  ; "D", WIF("SoundPlay", () => SoundPlay("C:\Users\depei_liu\DEPEI\Repos\2024s\w\d\bin\拽犯法么（硬曲热播）.mp3")),
])
