Extrack7zToDesktop() {
  CopyFilePath()
  Run(GetPy("7z-extract2desktop.py"))
}

Extrack7zHere() {
  CopyFilePath()
  Run(GetPy("7z-extracthere.py"))
}
