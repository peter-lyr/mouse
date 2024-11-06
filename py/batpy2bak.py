import os
import shutil
import sys
import b


if __name__ == "__main__":
    try:
        desktop = b.get_desktop()
        print(desktop)
        to_bak = sys.argv[1]
        _bak = os.path.join(desktop, ".bak")
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
    except Exception as e:
        print(e)
        os.system("pause")

# os.system("pause")
