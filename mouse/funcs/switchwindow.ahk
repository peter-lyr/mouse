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
    "d", ["ActivateDownloader", () => WinWaitActivate("ahk_exe Downloader.exe"), "Confirm"],
    "c", ["ActivateCodeBlocks", () => WinWaitActivate("ahk_exe codeblocks.exe"), "Confirm"],
    "q", ["ActivateWXWork", () => WinWaitActivate("ahk_exe WXWork.exe"), "Confirm"],
    "w", ["ActivateWeChat", () => WinWaitActivate("ahk_exe WeChat.exe"), "Confirm"],
    "e", ["ActivateExplorer", () => WinWaitActivate("ahk_class CabinetWClass"), "Confirm"],
    "m", ["ActivateMsedge", () => WinWaitActivate("ahk_exe msedge.exe"), "Confirm"],
  )
}
