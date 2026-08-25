import ctypes
lib = ctypes.CDLL("/usr/local/lib/libcbased.so")

lib._cosh.argtypes = [ctypes.c_double]
lib._cosh.restype = ctypes.c_double

result = lib._cosh(1)

if (result == 1.5430806348152437):
    print("_cosh work without any problom.")
else:
    print(f"wrong answer from _cosh: {result}")