import ctypes
lib = ctypes.CDLL("/usr/local/lib/libcbased.so")

lib._exp.argtypes = [ctypes.c_double]
lib._exp.restype = ctypes.c_double

result = lib._exp(1.01)

if (result == 2.7456010150169163):
    print("_exp work without any problom.")
else:
    print(f"wrong answer from _exp: {result}")