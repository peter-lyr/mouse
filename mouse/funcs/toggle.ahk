ProxyOn() {
  Run("git config --global http.proxy http://127.0.0.1:10809")
  Run("git config --global https.proxy https://127.0.0.1:10809")
  RunWait 'reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f', , 'Hide'
}

ProxyOff() {
  Run("git config --global --unset http.proxy")
  Run("git config --global --unset https.proxy")
  RunWait 'reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f', , 'Hide'
}
