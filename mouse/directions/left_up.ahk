; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/23 10:05:06 Thursday

; j: just info

_dir := "left_up"

AddFunction(1, 1, _dir, [
  "R", (j) => j And "<Alt-Up>" Or Send("!{Up}"),
  "U", (j) => j And "<Alt-Right>" Or Send("!{Right}"),
  "D", (j) => j And "<Alt-eft>" Or Send("!{Left}"),
])
