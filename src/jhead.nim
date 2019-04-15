import os
import jheadpkg/jheadprocs

proc main():void = 
  echo EnsurePathExists("/Users/lhope/dev/g.jpg")
  # let argc:cint = cint(2);
  # let args:array[2, string] = ["abc", "foo"]
  # let argv = allocCStringArray(args)
  # discard JheadMain(argc, argv)
  # deallocCStringArray(argv)

if isMainModule:
  main()