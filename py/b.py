import os
import subprocess
import sys
from traceback import format_exc

import win32clipboard
import win32con

b_py_folder_full = os.path.dirname(os.path.abspath(__file__))
shgetfolderpath_exe = os.path.join(b_py_folder_full, "SHGetFolderPath.exe")


def get_sta_output(cmd_params, silent=False):
    output = []
    sta = 1234
    try:
        process = subprocess.Popen(
            cmd_params,
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            universal_newlines=True,
            text=True,
            encoding="utf-8",
            errors="ignore",
        )
        while True:
            res = process.stdout.readline()
            if res == "" and process.poll() is not None:
                break
            if res:
                res = res.strip()
                output.append(res)
                if not silent:
                    print(res)
                sys.stdout.flush()
        sta = process.wait()
    except:
        sys.stdout.flush()
        e = format_exc()
        print(e, flush=True)
    return sta, output


def get_clipboard_data():
    win32clipboard.OpenClipboard()
    try:
        data = win32clipboard.GetClipboardData(win32con.CF_UNICODETEXT)
        if data:
            data = data.replace("\r\n", "\n")
    except TypeError:
        data = None
    win32clipboard.CloseClipboard()
    return data


def get_desktop():
    _, desktop = get_sta_output([shgetfolderpath_exe, "desktop"], True)
    return desktop[0]


def add_ignore_files(dir, files):
    parent_bak = parent = dir
    is_git = 0
    while 1:
        if os.path.exists(os.path.join(parent, ".git")):
            is_git = 1
            break
        parent = os.path.dirname(parent)
        if parent_bak == parent:
            break
        parent_bak = parent
    if not is_git:
        return
    lines = []
    gitignore = os.path.join(dir, ".gitignore")
    if os.path.exists(gitignore):
        with open(gitignore, "rb") as f:
            for line in f.readlines():
                line = line.strip()
                if line not in lines:
                    lines.append(line)
    for file in files:
        if file.encode("utf-8") not in lines:
            lines.append(file.encode("utf-8"))
    with open(gitignore, "wb") as f:
        for line in lines:
            f.write(line + b"\n")
