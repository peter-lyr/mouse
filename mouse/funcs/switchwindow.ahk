K_SwitchWindow() {
  Send("^!{Tab}")
  K(
    "tab", ["Ctrl-Alt-Tab", () => Send("^!{Tab}")],
    "m", ["ActivateEmacs", ActivateEmacs],
    "rshift", ["ActivateNvimQtExe", ActivateNvimQtExe],
    "lshift", ["ActivateNvimQtExe", ActivateNvimQtExe],
    "l", ["Right", () => Send("{Right}")],
    "h", ["Left", () => Send("{Left}")],
    "k", ["Up", () => Send("{Up}")],
    "j", ["Down", () => Send("{Down}")],
  )
}
