Extrack7z() {
  CopyFilePath()
  Run(GetPy("7z-extrack.py") . " " . GetExe("SHGetFolderPath.exe"))
}
