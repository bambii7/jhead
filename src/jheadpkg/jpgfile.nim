import streams

const
  SEC     = 0xFF # section start
  SOI     = 0xD8 # start of image
  EOI     = 0xD9 # end of image
  SOS     = 0xDA # start of scan
  JFIF    = 0xE0 # Jfif marker
  EXIF    = 0xE1 # exkf marker
  # XMP     = 0x10E1 # not a real tag
  COM     = 0xFE # comment
  DQT     = 0xDB # define quantization table
  DHT     = 0xC4 # define huffmann table
  DRI     = 0xDD
  IPTC    = 0xED # IPTC marker

type
  Jpeg = object
    path: string
    sections: seq[JpegSection]
    bytes: seq[byte]
  JpegSection = object
    data: char
    classification: int
    size: uint

iterator chars(s: FileStream): char =
  while not s.atEnd:
    yield s.readChar

proc fileToSeq(s: FileStream): seq[byte] =
  result = @[]
  for c in s.chars:
    result.add(byte(c))

proc readSections(bytes: seq[byte]): seq[JpegSection] =
  var cursor = 0
  while cursor < bytes.len:
    if bytes[cursor] == SEC:
      let section_type = bytes[cursor + 1]
      case section_type:
        of SOI:
          echo "start of image"
        of EOI:
          echo "end of image"
        of SOS:
          echo "start of scan"
        of JFIF:
          echo "jfif marker"
        of EXIF:
          echo "exif marker"
        of COM:
          echo "comment"
        of DQT:
          echo "quantization table"
        of DHT:
          echo "huffmann table"
        of DRI:
          echo "DRI"
        of IPTC:
          echo "IPTC"
        else:
          discard
    cursor += 1

proc read*(jpeg_path: string): Jpeg =
  let s = newFileStream(jpeg_path, FileMode.fmRead)
  let bytes = fileToSeq(s)
  let sections = readSections(bytes)
  let jpeg = Jpeg(path: jpeg_path, bytes: bytes, sections: sections)

  return jpeg
  
discard read("IMG_7098.jpg")
