import ctypes
lib = ctypes.CDLL("/usr/local/lib/libcbased.so")

lib._fmod.argtypes = [ctypes.c_double, ctypes.c_double]
lib._fmod.restype = ctypes.c_double

result = lib._fmod(1.0, 3.0)

if (result == 1.0):
    print("_fmod work without any problom.")
else:
    print(f"wrong answer from _fmod: {result}")