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

SwitchWindow() {
  G(
    "d", ["ActivateDownloader", () => ActivateWins("ahk_exe Downloader.exe"), "Confirm"],
    "c", ["ActivateCodeBlocks", () => ActivateWins("ahk_exe codeblocks.exe"), "Confirm"],
    "q", ["ActivateWXWork", () => ActivateWins("ahk_exe WXWork.exe"), "Confirm"],
    "w", ["ActivateWeChat", () => ActivateWins("ahk_exe WeChat.exe"), "Confirm"],
    "e", ["ActivateExplorer", () => ActivateWins("ahk_class CabinetWClass"), "Confirm"],
    "m", ["ActivateMsedge", () => ActivateWins("ahk_exe msedge.exe"), "Confirm"],
  )
}
