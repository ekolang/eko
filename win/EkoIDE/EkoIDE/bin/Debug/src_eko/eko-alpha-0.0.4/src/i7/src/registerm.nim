import os
import nimfasm
import convert

proc registerdo(buffer: any, funca: string, registername: string, registername2: string): void =
    if (funca == "mov"):
        emitMov(buffer, convert_to_reg8(registername), convert_to_reg8(registername2))
    else:
        echo "still in beta."