K_SwitchWindow() {
  Send("^!{Tab}")
  K(
    "tab", ["Ctrl-Alt-Tab", () => Send("^!{Tab}")],
    ",", ["ActivateEmacs", ActivateEmacs],
    ".", ["ActivateNvimQtExe", ActivateNvimQtExe],
    "l", ["Right", () => Send("{Right}")],
    "h", ["Left", () => Send("{Left}")],
    "k", ["Up", () => Send("{Up}")],
    "j", ["Down", () => Send("{Down}")],
  )
}

SwitchWindow_List := [
  "d", ["ActivateDownloader", () => ActivateWins("ahk_exe Downloader.exe"), "ActivateWindow"],
  "c", ["ActivateCodeBlocks", () => ActivateWins("ahk_exe codeblocks.exe"), "ActivateWindow"],
  "q", ["ActivateWXWork", () => ActivateWins("ahk_exe WXWork.exe"), "ActivateWindow"],
  "w", ["ActivateWeChat", () => ActivateWins("ahk_exe WeChat.exe"), "ActivateWindow"],
  "e", ["ActivateExplorer", () => ActivateWins("ahk_class CabinetWClass"), "ActivateWindow"],
  "g", ["ActivateMsedge", () => ActivateWins("ahk_exe msedge.exe"), "ActivateWindow"],
  "f", ["ActivateFileServ", () => ActivateWins("ahk_exe Fileserv.exe"), "ActivateWindow"],
  ",", ["ActivateEmacs", ActivateEmacs, "ActivateWindow"],
  ".", ["ActivateNvimQtExe", ActivateNvimQtExe, "ActivateWindow"],
  "enter", ["ActivateMstscExe", ActivateMstscExe, "ActivateWindow"],
]

SwitchWindow() {
  G(SwitchWindow_List*)
}
