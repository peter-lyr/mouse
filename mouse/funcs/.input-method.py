import sys
# import os

import win32api
import win32gui
from win32con import WM_INPUTLANGCHANGEREQUEST

# output_txt = os.path.join(os.path.dirname(os.path.realpath(sys.argv[0])), 'output.txt')

LANG = {"ZH": 0x0804, "EN": 0x0409}
try:
    hwnd = win32gui.GetForegroundWindow()
    win32api.PostMessage(hwnd, WM_INPUTLANGCHANGEREQUEST, None, LANG[sys.argv[1]])
    # with open(output_txt, 'ab') as f:
    #     f.write(str(sys.argv[1]).encode('utf-8') + b'\n')
except Exception as e:
    print("change_language - Exception:", e)
    # with open(output_txt, 'ab') as f:
    #     f.write(str(e).encode('utf-8') + b'\n')
