; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/05 23:58:24 星期三

#Requires AutoHotkey v2.0

Strip(text) {
  Return Trim(text, " `r`t`n")
}

CmdRunOutput(cmd) {
  shell := ComObject("WScript.Shell")
  exec := shell.Exec(A_ComSpec . " /C " . cmd)
  Return Strip(exec.StdOut.ReadAll())
}

MsgBox(CmdRunOutput("cd " . A_ScriptDir . " && search_start_sub_dir.py C:\Users\llydr\DEPEI\Repos\mouse search_start_sub_dir.ahk"))
