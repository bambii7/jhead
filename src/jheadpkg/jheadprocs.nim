{.compile: "jhead.c".}
{.compile: "exif.c".}
{.compile: "gpsinfo.c".}
{.compile: "iptc.c".}
{.compile: "jpgfile.c".}
{.compile: "jpgqguess.c".}
{.compile: "makernote.c".}
# {.compile: "myglob.c".}
{.compile: "paths.c".}
# int EnsurePathExists(const char * FileName);
proc EnsurePathExists*(FileName: cstring): int {.importc.}
# int jheadmain (int argc, char **argv)
proc Jheadmain*(argc: cint; argv: cstringArray): cint {.importc.}