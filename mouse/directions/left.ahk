; Copyleft (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/21 12:46:47 Tuesday

_dir := "left"

AddFunction(1, 1, _dir, [
  "R", (j) => j And "<Alt-Tab>" Or Send("!{Tab}"),
])

AddFunction(2, 1, _dir, [
  "R", (j) => j And "<Alt-Shift-Tab>" Or Send("!+{Tab}"),
])

AddFunction(1, 2, _dir, [
  "R", (j) => j And "<Ctrl-Tab>" Or Send("^{Tab}"),
  "U", (j) => j And "<Ctrl-Shift-Tab>" Or Send("^+{Tab}"),
  "D", (j) => j And "<Ctrl-Tab>" Or Send("^{Tab}"),
])

AddFunction(2, 2, _dir, [
  "R", (j) => j And "<Ctrl-Shift-Tab>" Or Send("^+{Tab}"),
])

AddFunction(1, 3, _dir, [
  "R", (j) => j And "<Ctrl-Alt-Tab>" Or Send("^!{Tab}"),
])

AddFunction(2, 3, _dir, [
  "R", (j) => j And "<Win-Tab>" Or Send("#{Tab}"),
])
