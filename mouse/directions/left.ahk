; Copyleft (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/21 12:46:47 Tuesday

AddFunction(1, 1, "left", [
  "ri", "<Alt-Tab>",
  "rf", () => [ Send("!{Tab}"), ],
])

AddFunction(2, 1, "left", [
  "ri", "<Alt-Shift-Tab>",
  "rf", () => [ Send("!+{Tab}"), ],
])

AddFunction(1, 2, "left", [
  "ri", "<Ctrl-Tab>",
  "rf", () => [ Send("^{Tab}"), ],
  "ui", "<Ctrl-Shift-Tab>",
  "uf", () => [ Send("^+{Tab}"), ],
  "di", "<Ctrl-Tab>",
  "df", () => [ Send("^{Tab}"),   ],
])

AddFunction(2, 2, "left", [
  "ri", "<Ctrl-Shift-Tab>",
  "rf", () => [ Send("^+{Tab}"), ],
])

AddFunction(1, 3, "left", [
  "ri", "<Ctrl-Alt-Tab>",
  "rf", () => [ Send("^!{Tab}"), ],
])

AddFunction(2, 3, "left", [
  "ri", "<Win-Tab>",
  "rf", () => [ Send("#{Tab}"), ],
])
