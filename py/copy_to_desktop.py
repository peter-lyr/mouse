# copy /y a.file desktop.dir

import os
import sys

import b

if __name__ == "__main__":
    clipboard_content = b.get_clipboard_data()
    # print("剪贴板内容:", clipboard_content)
    if not clipboard_content:
        os._exit(1)
    paths = clipboard_content.split("\n")
    new_files = []
    for path in paths:
        if os.path.isfile(path):
            new_files.append(path)
    desktop = b.get_desktop()
    # print(desktop)
    for f in new_files:
        tail = os.path.split(f)[-1]
        os.system(rf"""copy /y "{f}" {desktop}\{tail}""")

# os.system("pause")
