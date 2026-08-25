import ctypes
lib = ctypes.CDLL("/usr/local/lib/libcbased.so")

lib._cos.argtypes = [ctypes.c_double]
lib._cos.restype = ctypes.c_double

result = lib._cos(0.523599) #30

if (result == 0.8660252915835662):
    print("_cos work without any problom.")
else:
    print(f"wrong answer from _cos: {result}")