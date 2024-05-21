; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/21 12:46:47 Tuesday

AddFunction(1, 1, "right", [
  "ri", "<Alt-Tab>",
  "rf", () => [ Send("!{Tab}"), ],
])

AddFunction(2, 1, "right", [
  "ri", "<Alt-Shift-Tab>",
  "rf", () => [ Send("!+{Tab}"), ],
])

AddFunction(1, 2, "right", [
  "ri", "<Ctrl-Tab>",
  "rf", () => [ Send("^{Tab}"), ],
])

AddFunction(2, 2, "right", [
  "ri", "<Ctrl-Shift-Tab>",
  "rf", () => [ Send("^+{Tab}"), ],
])


AddFunction(1, 3, "right", [
  "ri", "<Ctrl-Alt-Tab>",
  "rf", () => [ Send("^!{Tab}"), ],
])
AddFunction(2, 3, "right", [
  "ri", "<Win-Tab>",
  "rf", () => [ Send("#{Tab}"), ],
])
