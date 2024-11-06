import os
import shutil
import sys
import b


if __name__ == "__main__":
    _, desktop = b.get_sta_output([sys.argv[1], "desktop"], True)
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
            dst = os.path.join(_bak, os.path.split(f)[-1])
            if os.path.exists(dst):
                os.remove(dst)
            shutil.move(f, _bak)
            # shutil.move(f, _bak, copy_function=shutil.copy2)
    elif to_bak == "todesktop":
        py_bats = []
        for f in os.listdir(_bak):
            if f.split(".")[-1].lower() in ["bat", "py"]:
                py_bats.append(os.path.join(_bak, f))
        for f in py_bats:
            print(f)
            shutil.copy(f, desktop)

# os.system("pause")
