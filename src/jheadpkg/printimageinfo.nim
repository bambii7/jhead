import jtypes
import strformat

proc `$`*(info: ImageInfo): string =
  result = ""
  result = result & "Image Info" & "\n"

  if info.jfifHeader.present:
    var resolutions_units_str:string
    case info.jfifHeader.resolutionUnits:
      of 0:
        resolutions_units_str = "Units (aspect ratio)"
      of 1:
        resolutions_units_str = "Units (dots per inch)"
      of 2:
        resolutions_units_str = "Units (dots per cm)"
      else:
        resolutions_units_str = "Units (unknown)"
    result = result & &"JFIF SOI marker: {resolutions_units_str}  X-density={$info.jfifHeader.xDensity} Y-density={$info.jfifHeader.yDensity}" & "\n"

  if info.comments.len > 0:
    result = result & info.comments & "\n"