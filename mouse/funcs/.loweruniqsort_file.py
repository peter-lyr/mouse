import sys

lines = []
file = sys.argv[1]
with open(file, 'rb') as f:
    lines = [line.decode('utf-8').strip() for line in f.readlines() if line.strip()]
new_lines = []
for line in lines:
    new_lines.append(line.lower())
new_lines = sorted(new_lines)
new_lines_bak = []
for line in new_lines:
    if not line in new_lines_bak:
        new_lines_bak.append(line)
with open(file, 'wb') as f:
    for line in new_lines_bak:
        f.write(line.encode('utf-8') + b'\n')
