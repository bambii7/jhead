import os
import jheadpkg/jheadprocs

proc main():void = 
  let argc:cint = cint(2);
  let args:seq[string] = @["jhead", paramStr(1)]
  var argv: cStringArray = args.allocCStringArray()
  discard Jheadmain(argc, argv)
  argv.deallocCStringArray()

if isMainModule:
  main()