import os
home = os.environ["USERPROFILE"]
dp = os.path.join(home, "Dp")
temp = os.path.join(dp, "temp")
source_dir = os.path.join(temp, "fileserv-libdir-detect")
fileserv_libdir_detect_bat = os.path.join(temp, "fileserv-libdir-detect.bat")

# 问豆包
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

# 定义一个事件处理类，继承自 FileSystemEventHandler
class AFileChangeHandler(FileSystemEventHandler):
    def __init__(self, action):
        self.action = action

    # 当文件被修改时触发该方法
    def on_modified(self, event):
        if event.is_directory:
            return
        # 检查文件是否为 .a 文件
        if event.src_path.endswith('.a'):
            print(f"文件 {event.src_path} 已修改")
            # 执行指定的动作
            self.action()

# 定义你想要执行的动作
def my_action():
    print("执行自定义动作...")

if __name__ == "__main__":
    if os.path.exists(fileserv_libdir_detect_bat):
        os.system(fileserv_libdir_detect_bat)
    with open(fileserv_libdir_detect_bat, "wb") as f:
        f.write(b"@echo off\n")
        f.write(f"taskkill /f /pid {os.getpid()}\n".encode("utf-8"))
        f.write(f"taskkill /f /pid {os.getppid()}\n".encode("utf-8"))

    # 要监控的文件夹路径
    folder_path = r"C:\Users\depei_liu"
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
