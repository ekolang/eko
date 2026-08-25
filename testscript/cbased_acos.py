import ctypes
lib = ctypes.CDLL("/usr/local/lib/libcbased.so")

lib._acos.argtypes = [ctypes.c_double]
lib._acos.restype = ctypes.c_double

result = lib._acos(0.5)
print(result)