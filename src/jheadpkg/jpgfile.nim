import streams
import strformat

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

iterator bytes(s: FileStream): byte =
  while not s.atEnd:
    yield s.readUint8

proc fileToSeq(s: FileStream): seq[byte] =
  result = @[]
  for c in s.bytes:
    result.add(byte(c))
  
proc byteSeqToString(s: seq[byte]): string =
  result = ""
  for c in s:
    result.addEscapedChar(char(c))

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
          let lh = bytes[cursor + 2]
          let ll = bytes[cursor + 3]
          let section_len = (lh shl 8) or ll
          let data = bytes[cursor + 4..(cursor + int(section_len) + 4)]

          assert(byteSeqToString(data[0..4]) == "JFIF\\x00", "JFIF marker missing header")
          assert(int(section_len) >= 16, "JFIF header too short")

          let resolutions_units = int(data[7])
          let x_density = (data[8] shl 8) or data[9];
          let y_density = (data[10] shl 8) or data[11];
          
          var resolutions_units_str:string
          case resolutions_units:
            of 0:
              resolutions_units_str = "Units (aspect ratio)"
            of 1:
              resolutions_units_str = "Units (dots per inch)"
            of 2:
              resolutions_units_str = "Units (dots per cm)"
            else:
              resolutions_units_str = "Units (unknown)"

          echo &"JFIF SOI marker: {resolutions_units_str}  X-density={$x_density} Y-density={$y_density}"
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
