import ctypes
lib = ctypes.CDLL("/usr/local/lib/libcbased.so")

lib._atan2.argtypes = [ctypes.c_double, ctypes.c_double]
lib._atan2.restype = ctypes.c_double

result = lib._atan2(0.5, 0.6)
print(result)