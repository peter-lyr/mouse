; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/24 11:08:46 Friday

d := "up"

; Snipaste
; See https://github.com/Snipaste/feedback/wiki/命令行选项

A(1, 1, 1, 1, d, [
  "R", W("Snipaste snip", () => Run("Snipaste snip")),
])

A(1, 1, 1, 2, d, [
  "R", W("Snipaste paste", () => Run("Snipaste paste")),
])

A(1, 1, 1, 3, d, [
  "R", W("Transparent Toggle", TransparentToggleRbuttonPressWin),
  "U", W("Transparent Up", TransparentUpRbuttonPressWin),
  "D", W("Transparent Down", TransparentDownRbuttonPressWin),
])

A(1, 1, 1, 4, d, [
  "R", W("TopMost Toggle", TopMostToggleRbuttonPressWin),
])

A(1, 1, 1, 5, d, [
  ; "R", W("ssh -T git@github.com", () => Run("ssh -T git@github.com")),
  "R", W("ssh -T git@github.com", () => Run(A_ScriptDir . "\bat\ssh.bat")),
])

Test1() {
  CopyFilePath()
  Run(A_ScriptDir . "\py\7z-extrack.py " . A_ScriptDir . "\py\SHGetFolderPath.exe")
}

A(1, 1, 1, 6, d, [
  "R", W("ssh -T git@github.com", Test1),
])
