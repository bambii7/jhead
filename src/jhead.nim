import os
import jheadpkg/jpgfile
import docopt

const doc = """

Jhead is a program for manipulating settings and thumbnails in Exif jpeg headers
used by most Digital Cameras.  3.03 Matthias Wandel, Dec 31 2018.
http://www.sentex.net/~mwandel/jhead


Usage:
  jhead <files>...
  jhead --jfif <files>
  jhead -v <files>...
  jhead (-h | --help)

Options:
  --jfif       Show JFIF header
"""

proc main():void = 
  let args = docopt(doc, version = "Jhead 3.03")
  let file:string = $args["<files>"]
  var sections:set[byte] = { byte(0xFF) }
  
  if args["--jfif"]:
    sections.incl(byte(0xE0))

  discard readJpgSections(file, sections)

if isMainModule:
  main()