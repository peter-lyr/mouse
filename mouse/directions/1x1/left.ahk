; Copyleft (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/21 12:46:47 Tuesday

d := "left"

A(1, 1, 1, 1, d, [
  "R", W("<Alt-Tab>", () => Send("!{Tab}")),
])

A(1, 1, 2, 1, d, [
  "R", W("<Alt-Shift-Tab>", () => Send("!+{Tab}")),
])

A(1, 1, 1, 2, d, [
  "R", W("<Ctrl-Tab>", () => Send("^{Tab}")),
  "U", W("<Ctrl-Shift-Tab>", () => Send("^+{Tab}")),
  "D", W("<Ctrl-Tab>", () => Send("^{Tab}")),
])

A(1, 1, 2, 2, d, [
  "R", W("<Ctrl-Shift-Tab>", () => Send("^+{Tab}")),
])

A(1, 1, 1, 3, d, [
  "R", W("<Ctrl-Alt-Tab>", () => Send("^!{Tab}")),
])

A(1, 1, 2, 3, d, [
  "R", W("<Win-Tab>", () => Send("#{Tab}")),
])
