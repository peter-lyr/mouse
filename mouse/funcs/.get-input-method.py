# not using
# import ctypes
#
# user32 = ctypes.WinDLL("user32", use_last_error=True)
# curr_window = user32.GetForegroundWindow()
# thread_id = user32.GetWindowThreadProcessId(curr_window, 0)
# klid = user32.GetKeyboardLayout(thread_id)
# lid = klid & (2**16 - 1)
# lid_hex = hex(lid)
# if lid_hex == "0x804":  # zh
#     print(1)
# # elif lid_hex == "0x409":  # en
# #     print(0)
# else:
#     print(0)
