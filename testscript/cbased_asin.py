import ctypes
lib = ctypes.CDLL("/usr/local/lib/libcbased.so")

lib._asin.argtypes = [ctypes.c_double]
lib._asin.restype = ctypes.c_double

result = lib._asin(0.5)
print(result)