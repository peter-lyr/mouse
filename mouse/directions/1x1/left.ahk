; Copyleft (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/21 12:46:47 Tuesday

d := "left"

A(1, 1, 1, 1, d, [
  "R", W("<Ctrl-Alt-Tab>", S("^!{Tab}")),
])

A(1, 1, 2, 1, d, [
  "R", W("<Win-Tab>", S("#{Tab}")),
])

A(1, 1, 2, 6, d, [
  "R", W("<Win-Tab>", S("#{Tab}")),
])

A(1, 1, 1, 2, d, [
  "R", W("<Ctrl-Tab>", S("^{Tab}")),
  "U", W("<Ctrl-Shift-Tab>", S("^+{Tab}")),
  "D", W("<Ctrl-Tab>", S("^{Tab}")),
])

A(1, 1, 2, 2, d, [
  "R", W("<Ctrl-Shift-Tab>", S("^+{Tab}")),
])

A(1, 1, 1, 2, d, [
  "R", W("<Alt-Tab>", S("!{Tab}")),
])

A(1, 1, 1, 6, d, [
  "R", W("<Alt-Tab>", S("!{Tab}")),
])

A(1, 1, 2, 3, d, [
  "R", W("<Alt-Shift-Tab>", S("!+{Tab}")),
])

A(1, 2, 1, 1, d, [
  "R", W("copy files to desktop", CopyFilesToDesktop),
])
