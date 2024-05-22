; Copyleft (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/21 12:46:47 Tuesday

AddFunction(1, 1, "left", [
  "Ri", "<Alt-Tab>",
  "Rf", () => [ Send("!{Tab}"), ],
])

AddFunction(2, 1, "left", [
  "Ri", "<Alt-Shift-Tab>",
  "Rf", () => [ Send("!+{Tab}"), ],
])

AddFunction(1, 2, "left", [
  "Ri", "<Ctrl-Tab>",
  "Rf", () => [ Send("^{Tab}"), ],
  "Ui", "<Ctrl-Shift-Tab>",
  "Uf", () => [ Send("^+{Tab}"), ],
  "Di", "<Ctrl-Tab>",
  "Df", () => [ Send("^{Tab}"),   ],
])

AddFunction(2, 2, "left", [
  "Ri", "<Ctrl-Shift-Tab>",
  "Rf", () => [ Send("^+{Tab}"), ],
])

AddFunction(1, 3, "left", [
  "Ri", "<Ctrl-Alt-Tab>",
  "Rf", () => [ Send("^!{Tab}"), ],
])

AddFunction(2, 3, "left", [
  "Ri", "<Win-Tab>",
  "Rf", () => [ Send("#{Tab}"), ],
])
