import time
import os
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
import threading
try:
    import pyttsx3
except:
    os.system(
        "pip install pyttsx3 -i https://pypi.tuna.tsinghua.edu.cn/simple --trusted-host mirrors.aliyun.com"
    )
    import pyttsx3



# 定义文件监控事件处理类
class FileChangeHandler(FileSystemEventHandler):
    def __init__(self, file_path):
        self.file_path = file_path
        # 记录文件的最后修改时间
        self.last_modified = None
        try:
            self.last_modified = time.ctime(int(os.path.getmtime(self.file_path)))
        except FileNotFoundError:
            pass

    def on_modified(self, event):
        if not event.is_directory and event.src_path == self.file_path:
            try:
                current_modified = time.ctime(int(os.path.getmtime(self.file_path)))
                if current_modified != self.last_modified:
                    self.last_modified = current_modified
                    # 读取文件内容
                    with open(self.file_path, 'r', encoding='utf-8') as file:
                        content = file.read()
                    # 创建一个新线程来进行语音朗读
                    t = threading.Thread(target=self.read_content, args=(content,))
                    t.start()
            except Exception as e:
                print(f"发生错误: {e}")

    def read_content(self, content):
        # 为每个线程创建独立的语音引擎实例
        engine = pyttsx3.init()
        # 朗读文件内容
        engine.say(content)
        engine.runAndWait()

if __name__ == "__main__":
    # 要监控的文件路径
    home = os.environ["USERPROFILE"]
    dp = os.path.join(home, "Dp")
    temp = os.path.join(dp, "temp")

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
        observer.schedule(event_handler, path=os.path.dirname(os.path.abspath(file_path)), recursive=False)
        # 启动观察者
        observer.start()
        try:
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            observer.stop()
        observer.join()
