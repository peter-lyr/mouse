import time
import sys
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
    engine.say(content)
    engine.runAndWait()


if __name__ == "__main__":
    if len(sys.argv) < 2:
        os._exit(9)
    cnt = sys.argv[1]
    file = os.path.join(temp, f"tts.txt")
    with open(f'{file}.{cnt}.txt', 'rb') as f:
        read_content(f.read().decode('utf-8'))
