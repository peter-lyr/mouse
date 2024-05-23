; Copyleft (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/21 12:46:47 Tuesday

_dir := "left"

AddFunction(1, 1, 1, 1, _dir, [
  "R", WIF("<Alt-Tab>", () => Send("!{Tab}")),
])

AddFunction(1, 1, 2, 1, _dir, [
  "R", WIF("<Alt-Shift-Tab>", () => Send("!+{Tab}")),
])

AddFunction(1, 1, 1, 2, _dir, [
  "R", WIF("<Ctrl-Tab>", () => Send("^{Tab}")),
  "U", WIF("<Ctrl-Shift-Tab>", () => Send("^+{Tab}")),
  "D", WIF("<Ctrl-Tab>", () => Send("^{Tab}")),
])

AddFunction(1, 1, 2, 2, _dir, [
  "R", WIF("<Ctrl-Shift-Tab>", () => Send("^+{Tab}")),
])

AddFunction(1, 1, 1, 3, _dir, [
  "R", WIF("<Ctrl-Alt-Tab>", () => Send("^!{Tab}")),
])

AddFunction(1, 1, 2, 3, _dir, [
  "R", WIF("<Win-Tab>", () => Send("#{Tab}")),
])
