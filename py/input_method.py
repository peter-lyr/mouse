# 见: 013-3-用1的方法监测指定文件的增加删除和改动.py
import pyautogui
import ctypes
import win32api
import win32gui
import time
import re
import os

from win32con import WM_INPUTLANGCHANGEREQUEST
from watchdog.events import FileSystemEventHandler
from watchdog.observers import Observer

home = os.environ["USERPROFILE"]
dp = os.path.join(home, "Dp")
temp = os.path.join(dp, "temp")
source_dir = os.path.join(temp, "py-input-method")
py_input_method_bat = os.path.join(temp, "py-input-method.bat")

os.makedirs(source_dir, exist_ok=True)

patt = re.compile(r"~$|\.#-*")

cnt = 0
start = 0

nvim_focus_lost_gained_txt = "nvim-focus-lost-gained.txt"
nvim_lang_en_zh_txt = "nvim-lang-en-zh.txt"

emacs_focus_lost_gained_txt = "emacs-focus-lost-gained.txt"
emacs_lang_en_zh_txt = "emacs-lang-en-zh.txt"

LANG = {"zh": 0x0804, "en": 0x0409}

TRACE_EN = 0

def TRACE(*args):
    if TRACE_EN:
        print(*args)

def get_file_sta(tail):
    os.chdir(source_dir)
    if not os.path.exists(tail):
        return -2
    with open(tail, "rb") as f:
        try:
            return eval(f.read().split(b"\n")[0])  # 0/1
        except:
            pass
    return -1


def check_input_method(lang):
    user32 = ctypes.WinDLL("user32", use_last_error=True)
    curr_window = user32.GetForegroundWindow()
    thread_id = user32.GetWindowThreadProcessId(curr_window, 0)
    klid = user32.GetKeyboardLayout(thread_id)
    lid = klid & (2**16 - 1)
    lid_hex = hex(lid)
    if lid_hex == "0x409":  # en
        if lang == "zh":
            pyautogui.hotkey("win", "space")
    elif lid_hex == "0x804":  # zh
        if lang == "en":
            pyautogui.hotkey("win", "space")


def change_input_method(lang):
    hwnd = win32gui.GetForegroundWindow()
    win32api.PostMessage(hwnd, WM_INPUTLANGCHANGEREQUEST, None, LANG[lang])
    time.sleep(0.5)
    check_input_method(lang)


def watcher_do(tail):
    TRACE(tail)
    if tail == nvim_focus_lost_gained_txt:
        sta = get_file_sta(nvim_focus_lost_gained_txt)
        if sta == 0:  # lost
            change_input_method("zh")
        elif sta == 1:
            sta = get_file_sta(nvim_lang_en_zh_txt)
            if sta == 0:  # en
                change_input_method("en")
            elif sta == 1:
                change_input_method("zh")
    elif tail == nvim_lang_en_zh_txt:
        sta = get_file_sta(nvim_lang_en_zh_txt)
        TRACE(sta)
        if sta == 0:  # en
            change_input_method("en")
        elif sta == 1:
            change_input_method("zh")
    elif tail == emacs_focus_lost_gained_txt:
        sta = get_file_sta(emacs_focus_lost_gained_txt)
        TRACE(sta)
        if sta == 0:  # lost
            change_input_method("zh")
        elif sta == 1:
            sta = get_file_sta(emacs_lang_en_zh_txt)
            TRACE(emacs_lang_en_zh_txt)
            TRACE(sta)
            if sta == 0:  # en
                change_input_method("en")
            elif sta == 1:
                change_input_method("zh")
    elif tail == emacs_lang_en_zh_txt:
        sta = get_file_sta(emacs_lang_en_zh_txt)
        TRACE(sta)
        if sta == 0:  # en
            change_input_method("en")
        elif sta == 1:
            change_input_method("zh")


def watcher(file):
    global cnt, start
    tail = os.path.split(file)[-1]
    cnt += 1
    if time.time() - start < 0.1 or re.findall(patt, file):
        return
    start = time.time()
    watcher_do(tail)


# 自定义事件处理器
class SyncHandler(FileSystemEventHandler):
    def on_modified(self, event):
        if not event.is_directory:
            watcher(event.src_path)


if __name__ == "__main__":
    if os.path.exists(py_input_method_bat):
        os.system(py_input_method_bat)
    with open(py_input_method_bat, "wb") as f:
        f.write(b"@echo off\n")
        f.write(f"taskkill /f /pid {os.getpid()}\n".encode("utf-8"))
        f.write(f"taskkill /f /pid {os.getppid()}\n".encode("utf-8"))

    # 创建观察者并启动
    observer = Observer()
    event_handler = SyncHandler()
    observer.schedule(event_handler, path=source_dir, recursive=True)
    observer.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()

    for i in range(30):
        time.sleep(1)

    observer.stop()
    observer.join()
