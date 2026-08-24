import os
import strutils
import nimfasm
let args: ant = commandLineParams()
var buf = initBuffer()
var filec: string = readText(args[1])
var spla: any = filec.splitLines()
for (uh in spla):
  var asa: any = uh.split()
  if (asa[0] == "M"):
    registerdo(buf, "mov", asa[1], asa[2])