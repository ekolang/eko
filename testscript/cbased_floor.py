import ctypes
lib = ctypes.CDLL("/usr/local/lib/libcbased.so")

lib._floor.argtypes = [ctypes.c_double]
lib._floor.restype = ctypes.c_double

result = lib._floor(1.02)

if (result == 1.0):
    print("_floor work without any problom.")
else:
    print(f"wrong answer from _floor: {result}")