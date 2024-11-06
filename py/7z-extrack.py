# 7z x -y .\SDK_BT893X_TYPEC_S7592_20241106.zip -oD:\Desktop\we>nul
import os
import subprocess
import sys
from traceback import format_exc

import win32clipboard
import win32con


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


if __name__ == "__main__":
    clipboard_content = get_clipboard_data()
    # print("剪贴板内容:", clipboard_content)
    if not clipboard_content:
        os._exit(1)
    paths = clipboard_content.split("\n")
    new_zips = []
    for path in paths:
        if os.path.isfile(path) and path.split(".")[-1].lower() in ["zip", "7z", "tar"]:
            new_zips.append(path)
    for f in new_zips:
        print(f)
    _, desktop = get_sta_output([sys.argv[1], "desktop"], True)
    desktop = desktop[0]
    # print(desktop)

# print("wwwwwwwww")
os.system("pause")
