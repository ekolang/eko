import ctypes
lib = ctypes.CDLL("/usr/local/lib/libcbased.so")

lib._ceil.argtypes = [ctypes.c_double]
lib._ceil.restype = ctypes.c_double

result = lib._ceil(0.5)

if (result == 1):
    print("_ceil work without any problom.")
else:
    print(f"wrong answer from _ceil: {result}")