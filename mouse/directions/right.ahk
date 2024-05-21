; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/21 12:46:47 Tuesday

AddFunction(1, "right", [
  "ri", "<Alt-Tab>",
  "rf", () => [ Send("!{Tab}"), ],
])

AddFunction(2, "right", [
  "ri", "<Ctrl-Tab>",
  "rf", () => [ Send("^{Tab}"), ],
])

AddFunction(3, "right", [
  "ri", "<Win-Tab>",
  "rf", () => [ Send("#{Tab}"), ],
])
