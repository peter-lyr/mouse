# 7z x -y .\SDK_BT893X_TYPEC_S7592_20241106.zip -oD:\Desktop\we>nul
import os
import sys

import b

if __name__ == "__main__":
    clipboard_content = b.get_clipboard_data()
    # print("剪贴板内容:", clipboard_content)
    if not clipboard_content:
        os._exit(1)
    paths = clipboard_content.split("\n")
    new_zips = []
    for path in paths:
        if os.path.isfile(path) and path.split(".")[-1].lower() in ["zip", "7z", "tar"]:
            new_zips.append(path)
    desktop = b.get_desktop()
    # print(desktop)
    for f in new_zips:
        tail = os.path.splitext(os.path.split(f)[-1])[0]
        # print(tail)
        os.system(rf"""7z x -y "{f}" -o"{desktop}\{tail}">nul""")
        print(rf"""7z x -y "{f}" -o"{desktop}\{tail}">nul""")

# os.system("pause")
