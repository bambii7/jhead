import os
import jheadpkg/jheadprocs

proc main():void = 
  let param_count = paramCount() + 1
  let argc:cint = cint(param_count);

  var args =  newSeq[string](param_count)
  var x = 0
  while x < param_count:
    args[x] = paramStr(x)
    x += 1

  var argv: cStringArray = args.allocCStringArray()
  discard Jheadmain(argc, argv)
  argv.deallocCStringArray()

if isMainModule:
  main()