# 7z x -y .\SDK_BT893X_TYPEC_S7592_20241106.zip -oD:\Desktop\we>nul
import os
import sys

import b

zip_ext = [
    "zip",
    "7z",
    "rar",
]

if __name__ == "__main__":
    clipboard_content = b.get_clipboard_data()
    # print("剪贴板内容:", clipboard_content)
    if not clipboard_content:
        os._exit(1)
    paths = clipboard_content.split("\n")
    new_zips = []
    for path in paths:
        if (
            os.path.isfile(path)
            and path.split(".")[-1].lower()
            in [
                "temp",
            ]
            + zip_ext
        ):
            new_zips.append(path)
    # desktop = b.get_desktop()
    # print(desktop)
    for f in new_zips:
        if f.split(".")[-1].lower() == "temp":
            tgt = ".".join(f.split(".")[:-1])
            os.system(rf'''copy /y "{f}" "{tgt}"''')
            ext = tgt.split(".")[-1].lower()
            if not ext in zip_ext:
                for zip in zip_ext:
                    if zip in ext:
                        tgt_new = ".".join(tgt.split(".")[:-1]) + "." + zip
                        os.system(rf'''move "{tgt}" "{tgt_new}"''')
                        f = tgt_new
                        break
        tail = os.path.splitext(os.path.split(f)[-1])[0]
        # print(tail)
        # print(rf"""7z x -y "{f}" -o"{desktop}\{tail}">nul""")
        dir =os.path.dirname(f)
        os.chdir(dir)
        os.system(rf"""7z x -y "{f}" -o"{dir}\{tail}">nul""")

# os.system("pause")
