import ctypes
lib = ctypes.CDLL("/usr/local/lib/libcbased.so")
lib._abs.argtypes = [ctypes.c_int]
lib._abs.restype = ctypes.c_int

rsu = lib._abs(-2)

print(rsu)