import times

const
  SEC*     = 0xFF # section start
  SOI*     = 0xD8 # start of image
  EOI*     = 0xD9 # end of image
  SOS*     = 0xDA # start of scan
  JFIF*    = 0xE0 # Jfif marker
  EXIF*    = 0xE1 # exkf marker
  COM*     = 0xFE # comment
  DQT*     = 0xDB # define quantization table
  DHT*     = 0xC4 # define huffmann table
  DRI*     = 0xDD
  IPTC*    = 0xED # IPTC marker

type
  JifiHeader* = object
    present*: bool
    resolutionUnits*: byte
    xDensity*: byte
    yDensity*: byte
  # GpsInfo* = object
  #   lat*: char
  #   long*: char
  #   alt*: char
  ImageInfo* = object
    # fileName*: char
    # fileDateTime*: DateTime
    jfifHeader*: JifiHeader
    # fileSize*: uint
    # cameraMake*: char
    # cameraModel*: char
    # dateTime*: char
    # height*: uint
    # width*: uint
    # orientation*: int
    # isColor*: int
    # process*: int
    # flashUsed*: int
    # focalLength*: float
    # exposureTime*: float
    # apertureFNumer*: float
    # distance*: float
    # ccdWidth*: float
    # exposureBias*: float
    # digitalZoomRatio*: float
    # focalLength35mmEquiv*: int
    # whiteBalance*: int
    # masteringMode*: int
    # exposureProgram*: int
    # exposureMode*:int
    # isoEquivalent*: int
    # lightSource*: int
    # distanceRange*: int
    # xResolution*: float
    # yResolution*: float
    # resolutionUnit*: int
    comments*: string
    # commentWidthChars*: int
    # thumbnailOffset*: int
    # thumbnailSize*: int
    # largestExifOffset*: int
    # thumbnailAtEnd*: char
    # thumbnailSizeOffset*: int
    # dateTimeOffsets*: int
    # numDateTimeTags*: int
    # gpsInfo*: GpsInfo
    # qualityGuess*: int
