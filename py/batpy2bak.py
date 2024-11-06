import os
import shutil
import subprocess
import sys
from traceback import format_exc


def get_sta_output(cmd_params, silent=False):
    output = []
    sta = 1234
    try:
        process = subprocess.Popen(
            cmd_params,
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            universal_newlines=True,
            text=True,
            encoding="utf-8",
            errors="ignore",
        )
        while True:
            res = process.stdout.readline()
            if res == "" and process.poll() is not None:
                break
            if res:
                res = res.strip()
                output.append(res)
                if not silent:
                    print(res)
                sys.stdout.flush()
        sta = process.wait()
    except:
        sys.stdout.flush()
        e = format_exc()
        print(e, flush=True)
    return sta, output


if __name__ == "__main__":
    _, desktop = get_sta_output([sys.argv[1], "desktop"], True)
    to_bak = sys.argv[2]
    desktop = desktop[0]
    _bak = os.path.join(desktop, ".bak")
    print(desktop)
    if to_bak == "tobak":
        py_bats = []
        for f in os.listdir(desktop):
            if f.split(".")[-1].lower() in ["bat", "py"]:
                py_bats.append(os.path.join(desktop, f))
        for f in py_bats:
            print(f)
            dst=os.path.join(_bak, os.path.split(f)[-1])
            if os.path.exists(dst):
                os.remove(dst)
            shutil.move(f, _bak)
    elif to_bak == "todesktop":
        py_bats = []
        for f in os.listdir(_bak):
            if f.split(".")[-1].lower() in ["bat", "py"]:
                py_bats.append(os.path.join(_bak, f))
        for f in py_bats:
            print(f)
            shutil.copy(f, desktop)

# os.system("pause")
