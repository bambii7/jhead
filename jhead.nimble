# Package

version       = "0.1.0"
author        = "Alexis"
description   = "A port of Jhead to nim, inspects jpg EXiF data"
license       = "MIT"
srcDir        = "src"
bin           = @["jhead"]

# Dependencies
requires "docopt"
requires "nim >= 0.18.0"
