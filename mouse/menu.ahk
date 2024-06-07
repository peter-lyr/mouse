; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/07 01:13:46 星期五

Menus := Map()

WinR() {
  ; SetTimer () => [Send("#r"), Send("#r")], -100
  Send("#r")
}

Menus.Set(
  ; "k", WinMaximizeRestoreA,
  ; ";", TransparentToggleA,
  ; "l", TopMostToggleA,
  "space", WinR,
)

ShowItems() {
  _temp := ""
  For k, v in Menus {
    _temp .= k . ": " . v.Name . "`n"
  }
  _temp := Strip(_temp)
  ; If (WinActive("ahk_exe StartMenuExperienceHost.exe")) {
  ;   WinMinimize("ahk_exe StartMenuExperienceHost.exe")
  ; If (WinActive("ahk_class Windows.UI.Core.CoreWindow")) {
  ;   WinMinimize("ahk_class Windows.UI.Core.CoreWindow")
  ; }
  Send("{Escape}")
  Tooltip(_temp)
}

WaitKey() {
  _key := StrLower(KeyWaitAny())
  If Menus.Has(_key) {
    Print("KEY: <" . _key . ">" . Type(Menus[_key]))
    Menus[_key]()
  } Else {
    Print("key: <" . _key . ">")
  }
}

MyMenu() {
  ShowItems()
  WaitKey()
}
