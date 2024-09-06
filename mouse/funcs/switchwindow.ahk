SwitchWindow() {
  Global NormalWaitSeconds
  Send("^!{Tab}")
  G(
    "tab", ["Ctrl-Alt-Tab", () => Send("^!{Tab}"), "Continue", NormalWaitSeconds],
    "space", ["Space", () => Send("{Space}"), "Continue", NormalWaitSeconds],
    "m", ["ActivateEmacs", ActivateEmacs, "Continue"],
    "rshift", ["ActivateNvimQtExe", ActivateNvimQtExe, "Continue"],
    "lshift", ["ActivateNvimQtExe", ActivateNvimQtExe, "Continue"],
    "l", ["Right", () => Send("{Right}"), "Continue", NormalWaitSeconds],
    "h", ["Left", () => Send("{Left}"), "Continue", NormalWaitSeconds],
    "k", ["Up", () => Send("{Up}"), "Continue", NormalWaitSeconds],
    "j", ["Down", () => Send("{Down}"), "Continue", NormalWaitSeconds],
  )
}
