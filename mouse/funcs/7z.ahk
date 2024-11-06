Extrack7z() {
  CopyFilePath()
  Run(GetPy("7z-extrack.py") . " " . GetPy("SHGetFolderPath.exe"))
}

