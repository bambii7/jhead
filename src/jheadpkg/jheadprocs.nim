# {.compile: "csrc/jhead.c".}
{.compile: "paths.c".}
# int EnsurePathExists(const char * FileName);
proc EnsurePathExists*(FileName: cstring): int {.importc.}