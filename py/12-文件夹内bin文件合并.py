# pys
#  M 2 files | 6     2 | 1ba0946d (HEAD -> main, origin/main, origin/HEAD) b.add_ignore_files(bins_dir_root, [out_file_true]) peter-lyr, 13 minutes ago

import os
import b


def merge_bins_file(bins_dir_full):
    bins_dir_root, bins_dir = os.path.split(bins_dir_full)

    out_file = "-bin".join(bins_dir.split("-bin")[:-1])
    if not out_file:
        os._exit(4)

    out_file_name = out_file

    temp = out_file.split(".")
    out_file_true = ".".join(temp[:-1])
    out_ext = temp[-1]

    out_file_true = out_file_true + "." + out_ext

    b.add_ignore_files(bins_dir_root, [out_file_true])

    bins = os.listdir(bins_dir_full)
    bins.sort()
    new_bins = []
    for bin in bins:
        if out_file_name in bin:
            new_bins.append(bin)
    if not new_bins:
        os._exit(3)
    with open(os.path.join(bins_dir_root, out_file_true), "wb") as outf:
        for bin in new_bins:
            if out_file_name not in bin:
                continue
            print(bin)
            with open(os.path.join(bins_dir_full, bin), "rb") as inf:
                buffer = inf.read()
                outf.write(buffer)


if __name__ == "__main__":
    clipboard_content = b.get_clipboard_data()
    # print("剪贴板内容:", clipboard_content)
    if not clipboard_content:
        os._exit(1)
    paths = clipboard_content.split("\n")
    for path in paths:
        if os.path.isdir(path):
            merge_bins_file(path)

# os.system("pause")
