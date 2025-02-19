import b
import pyautogui
import re
import os

# 问豆包
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

flag = 0

def get_fileserv_config():
    home = os.environ["USERPROFILE"]
    return os.path.join(home, "w", 'wk-sw', 'Fileserv', 'Fileserv.config')

fileserv_config = get_fileserv_config()
detect_dir = ''
with open(fileserv_config, 'rb') as f:
    for line in f.readlines():
        line = line.decode('utf-8')
        res = re.findall(r'key="LibDir" value="([^"]+)"', line)
        if res:
            detect_dir = res[0]
            break

# print('detect_dir:', detect_dir)

# 定义一个事件处理类，继承自 FileSystemEventHandler
class AFileChangeHandler(FileSystemEventHandler):
    def __init__(self, action):
        self.action = action
        self.last_modified_time = {}
        self.last_action_time = time.time()

    def on_modified(self, event):
        if event.is_directory:
            return
        if event.src_path.endswith('.a'):
            current_time = time.time()
            last_time = self.last_modified_time.get(event.src_path, 0)
            # 设置时间间隔，例如 1 秒
            if current_time - last_time > 1:
                # print(f"文件 {event.src_path} 已修改")
                t = time.time()
                if t - self.last_action_time > 2:
                    self.last_action_time = t
                    self.action()
                self.last_modified_time[event.src_path] = current_time

# 定义你想要执行的动作
def my_action():
    global flag
    if flag:
        return
    flag = 1
    time.sleep(0.8)
    pyautogui.press('alt')
    pyautogui.press('alt')
    time.sleep(0.1)
    pyautogui.press('f6')
    # print('f6')
    flag = 0
    time.sleep(0.1)
    pyautogui.press('alt')
    pyautogui.press('alt')
    pyautogui.press('.')
    pyautogui.press('esc')
    # print("执行自定义动作...")

if __name__ == "__main__":
    b.try_kill_py(__file__)

    # 要监控的文件夹路径
    folder_path = detect_dir
    # 创建事件处理对象，传入要执行的动作
    event_handler = AFileChangeHandler(my_action)
    # 创建观察者对象
    observer = Observer()
    # 安排观察者监控指定文件夹，并使用指定的事件处理程序
    observer.schedule(event_handler, path=folder_path, recursive=False)
    # 启动观察者
    observer.start()
    # try:
    #     while True:
    #         # 每隔 1 秒检查一次
    #         time.sleep(1)
    # except KeyboardInterrupt:
    #     # 当用户按下 Ctrl+C 时，停止观察者
    #     observer.stop()
    # 等待观察者线程结束
    observer.join()
