# Exif Jpeg header manipulation tool

This is a  Nim port of Matthias Wandel Jhead utilility. A jpg header manipulation tool.
http://www.sentex.net/~mwandel/jhead/

There are breaking interface changes. Where single dashed commands `-di` are expanded to double dashed and verbose naming `--delete-iptc`. Single dash is reserved for flags.

# Build

`nimble build`

# Usage
 - `jhead --jfif <file>` # print jfif header
 - `jhead --com <file>` # print comment

TODO:

 - hash quantization and huffman tables, ignoring meta data to dedupe images.
 - base64 jpeg
 - show exif data
 - show tags
 - edit comments
 - edit tags