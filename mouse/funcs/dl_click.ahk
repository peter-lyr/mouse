DL_Click() {
  If WinActive("ahk_class CabinetWClass") {
    clsnn := ControlGetFocus("ahk_class CabinetWClass")
    Try {
      If InStr(ControlGetClassNN(clsnn), "DirectUIHWND") {
        Home := EnvGet("USERPROFILE")
        out := CmdRunOutput(Home . "\p\python\014-不通过选中地址栏的方式去获取到地址栏的路径直接获取到.py")
        ; MsgBox("------------")
        ; MsgBox(out)
        ; MsgBox(Home)
      }
    }
  }
}
