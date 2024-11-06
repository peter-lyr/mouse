import sys
import win32clipboard
import win32con


import subprocess
from traceback import format_exc


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
