import ctypes
lib = ctypes.CDLL("/usr/local/lib/libcbased.so")

lib._fabs.argtypes = [ctypes.c_double]
lib._fabs.restype = ctypes.c_double

result = lib._fabs(-1)

if (result == 1):
    print("_fabs work without any problom.")
else:
    print(f"wrong answer from _fabs: {result}")