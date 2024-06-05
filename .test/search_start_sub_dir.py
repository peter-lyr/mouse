# Copyright (c) 2024 liudepei. All Rights Reserved.
# create at 2024/06/05 23:58:35 星期三

# search_start_sub_dir.py C:\Users\llydr\DEPEI\Repos\2024s 240527-ergan_rocket-耳感ab5622d带耳返有滴水流水的杂音.md
# argv[1]: 目录路径,从这个目录开始查找
# argv[2]: 文件名称,查找它

import sys
import os

if len(sys.argv) < 3:
    os._exit(1)

root = sys.argv[1]
if not os.path.exists(root):
    os._exit(2)
search_file = sys.argv[2].lower()

result = ""

for dir, dirs, files in os.walk(root):
    for file in files:
        if search_file == file.lower():
            print(dir)
            break
