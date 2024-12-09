import datetime
import os
import re
import threading
import time
import tkinter
import tkinter.ttk as ttk

import pynput
import win32con
import win32gui
from watchdog.events import FileSystemEventHandler
from watchdog.observers import Observer
from win32.win32api import GetSystemMetrics
from win32api import GetMonitorInfo, MonitorFromPoint

home = os.environ["USERPROFILE"]
dp = os.path.join(home, "Dp")
temp = os.path.join(dp, "temp")

root = os.path.join(temp, "py-keyboard-mouse")
py_keyboard_mouse_bat = os.path.join(temp, "py-keyboard-mouse.bat")

all = os.path.join(root, "all.txt")
mean = os.path.join(root, "mean.txt")
today = os.path.join(root, datetime.datetime.now().strftime("%Y%m%d.txt"))

os.makedirs(root, exist_ok=True)

colors = [
    "#00FF00",  # (绿色)
    "#33FF00",
    "#66FF00",
    "#99FF00",
    "#CCFF00",
    "#FFFF00",  # (黄色)
    "#FFCC00",
    "#FF9900",
    "#FF6600",
    "#FF0000",  # (红色)
]


def write_bytes(file, text):
    with open(file, "wb") as f:
        f.write(text)


def get_screen_scale_height():
    """
    获取屏幕缩放后的分辨率高度
    """
    return GetSystemMetrics(1)


def get_taskbar_height():
    """
    仅限任务栏放在底部的情况
    """
    monitor_info = GetMonitorInfo(MonitorFromPoint((0, 0)))
    monitor = monitor_info.get("Monitor")
    work = monitor_info.get("Work")
    taskbar_height = monitor[3] - work[3]
    return taskbar_height


def start_threading(func, params=[]):
    """
    创建子线程并执行函数
    """
    threading.Thread(target=func, args=params).start()


class MyProgressBar(ttk.Progressbar):
    _inst_count = 0

    def __init__(self, root, text, *args, **kwargs):
        classname = type(self).__name__
        assert (
            "style" not in kwargs
        ), f'{classname} initializer does not support providing a ttk "style".'
        type(self)._inst_count += 1
        self.style = ttk.Style(root)
        self.style.theme_use("default")
        self.stylename = f"text.Horizontal.TProgressbar{self._inst_count}"
        self.style.layout(
            self.stylename,
            [
                (
                    "Horizontal.Progressbar.trough",
                    {
                        "children": [
                            (
                                "Horizontal.Progressbar.pbar",
                                {"side": "left", "sticky": "ns"},
                            )
                        ],
                        "sticky": "nswe",
                    },
                ),
                ("Horizontal.Progressbar.label", {"sticky": ""}),
            ],
        )
        self.style.configure(self.stylename, text=text)
        kwargs.update(style=self.stylename)
        super().__init__(*args, **kwargs)


def mouse_penetrate(title, alpha=int(0.382 * 255)):
    """
    开一个线程，让窗口实现鼠标穿透，10秒未找到则退出
    """

    def mouse_penetrate_do():
        for _ in range(10):
            try:
                hwnd = win32gui.FindWindow(None, title)
                style = win32gui.GetWindowLong(hwnd, win32con.GWL_EXSTYLE)
                win32gui.SetWindowLong(
                    hwnd,
                    win32con.GWL_EXSTYLE,
                    style | win32con.WS_EX_TRANSPARENT | win32con.WS_EX_LAYERED,
                )
                win32gui.SetLayeredWindowAttributes(hwnd, 0, alpha, win32con.LWA_ALPHA)
                break
            except:
                time.sleep(1)

    start_threading(mouse_penetrate_do)
    return


class ProgressBar(FileSystemEventHandler):
    """
    时刻监测文件，若改动则更新到"进度条"
    用法：
    ProgressBar().start(
        [
            'file-1.txt',
            'file-2.txt',
            'file-3.txt',
        ]
    )
    应放到最后一行代码，这里会阻塞运行
    """

    def on_modified(self, event):
        if event.is_directory:
            return None
        else:
            for i in range(len(self.files)):
                file = self.files[i]
                modified_dirname = os.path.split(event.src_path)[-1].lower()
                if modified_dirname == os.path.split(file)[-1].lower():
                    self.update(i)
                    break

    def get_percentage(self, file):
        percentage = self.get_text_from_file(file)
        if not percentage:
            return "0.00"
        return f"{percentage:.2f}"

    def update(self, i):
        file = self.files[i]
        percentage = self.get_percentage(file)
        progressbar = self.progressbars[i]
        temp = eval(percentage) % 100
        i = int(temp // 10)
        progressbar.config(value=temp)
        progressbar.style.configure(
            progressbar.stylename, background=colors[i], text=percentage
        )
        self.root.attributes("-topmost", 1)
        self.root.update()

    def prepare_root(self, files):
        self.files = files
        self.cell_height = 16
        self.total_width = 48
        self.text_width = 6
        self.screen_scale_height = get_screen_scale_height()
        self.taskbar_height = get_taskbar_height()
        self.total_height = len(self.files) * self.cell_height
        self.progressbars = []
        self.title = "Progressbar"
        self.root = tkinter.Tk()
        self.root.title(self.title)
        self.root.overrideredirect(True)
        self.ori_y = int(
            self.screen_scale_height - self.taskbar_height - self.total_height
        )
        self.opt = f"{self.total_width}x{self.total_height}+0+{self.ori_y}"
        self.root.geometry(self.opt)
        self.root.attributes("-topmost", 1)
        self.root.attributes("-toolwindow", 1)
        self.root.attributes("-disabled", 1)
        for i in range(len(self.files)):
            file = self.files[i]
            percentage = self.get_percentage(file)
            progressbar = MyProgressBar(
                self.root, percentage, length=self.total_width, maximum=100
            )
            progressbar.place(x=0, y=i * self.cell_height)
            self.progressbars.append(progressbar)

    def start_root(self):
        self.root.mainloop()

    def detect_modified_files(self):
        observer = Observer()
        observer.schedule(self, path=os.path.dirname(self.files[0]), recursive=False)
        observer.start()
        observer.join()

    def get_text_from_file(self, file):
        if not os.path.exists(file):
            return b""
        with open(file, "rb") as f:
            lines = f.readlines()
        if not lines:
            lines = [""]
        first_line = lines[0]
        text = 0
        try:
            text = float(first_line)
        except:
            pass
        return text

    def start(self, files):
        self.prepare_root(files)
        start_threading(self.detect_modified_files)
        mouse_penetrate(self.title)
        self.start_root()


class KeyboardMouseMonitor:
    def __init__(self) -> None:
        self.prepare()
        start_threading(self.monitor_keyboard)
        ProgressBar().start([today, mean, all])

    def prepare(self):
        global all, mean, today
        self.date = datetime.datetime.now().strftime("%Y%m%d")
        self.today = today
        self.all = all
        self.mean = mean

        self.today_cnt = self.get_num_from_file(self.today) * 100
        self.all_cnt = self.get_num_from_file(self.all) * 100
        self.all_txts = [
            txt
            for txt in os.listdir(root)
            if re.findall(re.compile(r"\d{6}\.txt"), txt)
        ]
        self.all_txt_num = len(self.all_txts)
        self.mean_cnt = self.all_cnt / self.all_txt_num

        self.keyboard_pressed = {}
        self.keyboard_released = {}

    def get_num_from_file(self, file):
        if not os.path.exists(file):
            with open(file, "wb") as f:
                lines = f.write(b"0.00")
            return 0
        with open(file, "rb") as f:
            lines = f.readlines()
        if not lines:
            lines = [""]
        first_line = lines[0]
        try:
            return float(first_line)
        except:
            return 0

    def get_key(self, key):
        char = str(key).strip('"' + "'").lower().split("key.")[-1].split("\\x")[-1]
        string = char.encode("utf-8")
        if len(char) > 1:
            string = b"{" + string + b"}"
        return string

    def key_short(self, key):
        # print(str(key) + " pressed")
        self.all_cnt += 1
        self.today_cnt += 1
        self.mean_cnt = self.all_cnt / self.all_txt_num
        write_bytes(self.today, f"{self.today_cnt/100}".encode("utf-8"))
        write_bytes(self.mean, f"{self.mean_cnt/100}".encode("utf-8"))
        write_bytes(self.all, f"{self.all_cnt/100}".encode("utf-8"))

    def on_key_press(self, key):
        date = datetime.datetime.now().strftime("%Y%m%d")
        if date != self.date:
            self.prepare()
        key = self.get_key(key)
        self.keyboard_pressed[key] = 1
        if key not in self.keyboard_released or self.keyboard_released.get(key, 0) == 1:
            self.keyboard_released[key] = 0
            self.key_short(key)
        elif self.keyboard_released.get(key, 0) == 0:
            pass  # long

    def on_key_release(self, key):
        key = self.get_key(key)
        self.keyboard_pressed[key] = 0
        self.keyboard_released[key] = 1
        # print(str(key) + " released")

    def monitor_keyboard(self):
        with pynput.keyboard.Listener(
            on_release=self.on_key_release, on_press=self.on_key_press
        ) as listener:
            listener.join()


if __name__ == "__main__":
    if os.path.exists(py_keyboard_mouse_bat):
        os.system(py_keyboard_mouse_bat)
    with open(py_keyboard_mouse_bat, "wb") as f:
        f.write(b"@echo off\n")
        f.write(f"taskkill /f /pid {os.getpid()}\n".encode("utf-8"))
        f.write(f"taskkill /f /pid {os.getppid()}\n".encode("utf-8"))
    KeyboardMouseMonitor()
