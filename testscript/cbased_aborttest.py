import ctypes
lib = ctypes.CDLL("/usr/local/lib/libcbased.so")
lib._abort.argtypes = []
lib._abort.restype = None

lib._abort()

# this line must not print
print("Hello world")