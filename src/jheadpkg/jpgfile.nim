import streams
import strformat
import jtypes

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

proc readSections(bytes: seq[byte], sections: set[byte]): seq[JpegSection] =
  var cursor = 0
  while cursor < bytes.len:
    if bytes[cursor] == SEC:
      let section_type = bytes[cursor + 1]
      case section_type:
        of SOI:
          # start of image
          if not sections.contains(section_type):
            cursor.inc
            continue
        of EOI:
          # end of image
          if not sections.contains(section_type):
            cursor.inc
            continue
        of SOS:
          # start of scan
          if not sections.contains(section_type):
            cursor.inc
            continue
        of JFIF:
          if not sections.contains(section_type):
            cursor.inc
            continue
          let lh = bytes[cursor + 2]
          let ll = bytes[cursor + 3]
          let section_len = (lh shl 8) or ll
          let data = bytes[cursor + 4..(cursor + int(section_len) + 4)]

          assert(byteSeqToString(data[0..4]) == "JFIF\\x00", "JFIF marker missing header")
          assert(int(section_len) >= 16, "JFIF header too short")

          let resolutions_units = data[7]
          let x_density = (data[8] shl 8) or data[9];
          let y_density = (data[10] shl 8) or data[11];
          let jfif = JifiHeader(present: true, resolutionUnits: resolutions_units, xDensity: x_density, yDensity: y_density)
          echo jfif
          # var resolutions_units_str:string
          # 
          # case resolutions_units:
          #   of 0:
          #     resolutions_units_str = "Units (aspect ratio)"
          #   of 1:
          #     resolutions_units_str = "Units (dots per inch)"
          #   of 2:
          #     resolutions_units_str = "Units (dots per cm)"
          #   else:
          #     resolutions_units_str = "Units (unknown)"

          # echo &"JFIF SOI marker: {resolutions_units_str}  X-density={$x_density} Y-density={$y_density}"
        of EXIF:
          if not sections.contains(section_type):
            cursor.inc
            continue
        of COM:
          if not sections.contains(section_type):
            cursor.inc
            continue
        of DQT:
          # quantization table
          if not sections.contains(section_type):
            cursor.inc
            continue
        of DHT:
          # huffmann table
          if not sections.contains(section_type):
            cursor.inc
            continue
        of DRI:
          if not sections.contains(section_type):
            cursor.inc
            continue
        of IPTC:
          if not sections.contains(section_type):
            cursor.inc
            continue
        else:
          discard
    cursor.inc

proc readJpgSections*(jpeg_path: string, sections: set[byte]): Jpeg =
  let s = newFileStream(jpeg_path, FileMode.fmRead)
  let bytes = fileToSeq(s)
  let sections = readSections(bytes, sections)
  let jpeg = Jpeg(path: jpeg_path, bytes: bytes, sections: sections)

  return jpeg
  