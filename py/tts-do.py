import time
import re
import os
try:
    import pyttsx3
except:
    os.system(
        "pip install pyttsx3 -i https://pypi.tuna.tsinghua.edu.cn/simple --trusted-host mirrors.aliyun.com"
    )
    import pyttsx3

import os
import pyttsx3

home = os.environ["USERPROFILE"]
dp = os.path.join(home, "Dp")
temp = os.path.join(dp, "temp")

py_tts_bat = os.path.join(temp, "py-tts.bat")

def read_content(content):
    # 为每个进程创建独立的语音引擎实例
    engine = pyttsx3.init()
    new_rate = 3.0 * 200  # 你可以根据需要调整这个值
    engine.setProperty('rate', new_rate)
    # 朗读文件内容
    if not content.strip(): # 没用到
        content = content.replace(" ", "空格").replace("\t", "制表符").replace("\n", "回车符")
    pattern = r'<!--.*?-->'
    content = content.strip()
    print(content)
    content = re.sub(pattern, '', content)
    if content == '删除':
        return
    print('88888888', time.time())
    engine.say(content)
    print('88888889', time.time())
    engine.runAndWait()
    print('88888890', time.time())


if __name__ == "__main__":
    file = os.path.join(temp, "tts.txt")
    with open(file, 'rb') as f:
        read_content(f.read().decode('utf-8'))
