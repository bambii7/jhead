import times

type
  JifiHeader = object
    present: char
    resolutionUnits: char
    xDensity: int
    yDensity: int
  GpsInfo = object
    lat: char
    long: char
    alt: char
  ImageInfo* = object
    fileName: char
    fileDateTime: DateTime
    jfifHeaderL: JifiHeader
    fileSize: uint
    cameraMake: char
    cameraModel: char
    dateTime: char
    height: uint
    width: uint
    orientation: int
    isColor: int
    process: int
    flashUsed: int
    focalLength: float
    exposureTime: float
    apertureFNumer: float
    distance: float
    ccdWidth: float
    exposureBias: float
    digitalZoomRatio: float
    focalLength35mmEquiv: int
    whiteBalance: int
    masteringMode: int
    exposureProgram: int
    exposureMode:int
    isoEquivalent: int
    lightSource: int
    distanceRange: int
    xResolution: float
    yResolution: float
    resolutionUnit: int
    comments: string
    commentWidthChars: int
    thumbnailOffset: int
    thumbnailSize: int
    largestExifOffset: int
    thumbnailAtEnd: char
    thumbnailSizeOffset: int
    dateTimeOffsets: int
    numDateTimeTags: int
    gpsInfo: GpsInfo
    qualityGuess: int
