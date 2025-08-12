import os
import re
import sys

os.chdir(sys.argv[1])

def main():
    with open('Downloader.config', 'rb') as f:
        lines = f.readlines()
    L = []
    C = 0
    for line in lines:
        res = re.findall(re.compile(r'key="DownFile\d*" value="([^"]*)"'), line.decode('utf-8'))
        if res:
            if res[0] and os.path.exists(res[0]):
                a = C
                if C == 0:
                    a = ''
                line = f'        <add key="DownFile{a}" value="{res[0]}" />\r\n'
                C += 1
                L.append(line.encode('utf-8'))
        else:
            L.append(line)
    with open('Downloader.config', 'wb') as f:
        f.writelines(L)

if __name__ == "__main__":
    main()
