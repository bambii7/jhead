{.compile: "jhead.c".}
{.compile: "exif.c".}
{.compile: "gpsinfo.c".}
{.compile: "iptc.c".}
{.compile: "jpgfile.c".}
{.compile: "jpgqguess.c".}
{.compile: "makernote.c".}
{.compile: "paths.c".}

proc EnsurePathExists*(FileName: cstring): int {.importc.}
proc Jheadmain*(argc: cint; argv: cstringArray): cint {.importc.}