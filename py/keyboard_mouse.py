import os
import threading
import pynput

home = os.environ["USERPROFILE"]
dp = os.path.join(home, "Dp")
temp = os.path.join(dp, "temp")
source_dir = os.path.join(temp, "py-keyboard-mouse")

os.makedirs(source_dir, exist_ok=True)


class KeyboardMouseMonitor:
    def __init__(self) -> None:
        threading.Thread(target=self.monitor_keyboard).start()

    def get_key(self, key):
        char = str(key).strip('"' + "'").lower().split("key.")[-1].split("\\x")[-1]
        string = char.encode("utf-8")
        if len(char) > 1:
            string = b"{" + string + b"}"
        return string

    def on_key_press(self, key):
        key = self.get_key(key)
        print(str(key) + " pressed")

    def monitor_keyboard(self):
        with pynput.keyboard.Listener(on_press=self.on_key_press) as listener:
            listener.join()


if __name__ == "__main__":
    KeyboardMouseMonitor()
