import time
import b
import re
import os
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

try:
    import pyttsx3
except:
    os.system(
        "pip install pyttsx3 -i https://pypi.tuna.tsinghua.edu.cn/simple --trusted-host mirrors.aliyun.com"
    )
    import pyttsx3

import time
import os
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
import pyttsx3
from multiprocessing import Process

temp = b.get_temp_path()

# 定义文件监控事件处理类
class FileChangeHandler(FileSystemEventHandler):
    def __init__(self, file_path):
        self.file_path = file_path
        self.time = 0

    def on_modified(self, event):
        if not event.is_directory and event.src_path == self.file_path:
            try:
                t = time.time()
                if self.time and t - self.time < 0.05:
                    return
                self.time = t
                with open(self.file_path, "r", encoding="utf-8") as file:
                    content = file.read()
                # 创建一个新进程来进行语音朗读
                p = Process(target=self.read_content, args=(content,))
                p.start()
            except Exception as e:
                print(f"发生错误: {e}")

    def read_content(self, content):
        # 为每个进程创建独立的语音引擎实例
        engine = pyttsx3.init()
        new_rate = 1.0 * 200  # 你可以根据需要调整这个值
        engine.setProperty("rate", new_rate)
        # 朗读文件内容
        if not content.strip():  # 没用到
            content = (
                content.replace(" ", "空格")
                .replace("\t", "制表符")
                .replace("\n", "回车符")
            )
        pattern = r"<!--.*?-->"
        content = content.strip()
        print(content)
        content = re.sub(pattern, "", content)
        if content == "删除":
            return
        engine.say(content)
        engine.runAndWait()


if __name__ == "__main__":
    b.try_kill_py(__file__)
    # 要监控的文件路径
    file = os.path.join(temp, "tts.txt")
    file_path = file
    if not os.path.exists(file_path):
        print(f"文件 {file_path} 不存在，请检查路径。")
    else:
        # 创建事件处理对象
        event_handler = FileChangeHandler(file_path)
        # 创建观察者对象
        observer = Observer()
        # 安排监控任务
        observer.schedule(
            event_handler,
            path=os.path.dirname(os.path.abspath(file_path)),
            recursive=False,
        )
        # 启动观察者
        observer.start()
        try:
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            observer.stop()
        observer.join()
