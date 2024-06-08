# Copyright (c) 2024 liudepei. All Rights Reserved.
# create at 2024/06/08 13:48:26 星期六

import sys

lines = ' '.join(sys.argv[1:]).strip(',').split(',')
new_lines = []
for line in lines:
    new_lines.append(line.lower())
new_lines = sorted(new_lines)
new_lines_bak = []
for line in new_lines:
    if not line in new_lines_bak:
        print(line)
    new_lines_bak.append(line)
