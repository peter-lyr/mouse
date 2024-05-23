; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/23 10:05:06 Thursday

_dir := "left_up"

AddFunction(1, 1, _dir, [
  "Ri", "<Alt-Up>",
  "Rf", () => [ Send("!{Up}"), ],
  "Ui", "<Alt-Right>",
  "Uf", () => [ Send("!{Right}"), ],
  "Di", "<Alt-Left>",
  "Df", () => [ Send("!{Left}"), ],
])
