module CEF
  SEVERITY_LOW = '1'.freeze

  LOG_FORMAT = '<%d>%s %s CEF:0|%s|%s'.freeze
  LOG_TIME_FORMAT = '%b %d %Y %H:%M:%S'.freeze

  # CEF Dictionary
  # CEF Prefix attributes
  PREFIX_ATTRIBUTES = {
    deviceVendor: 'deviceVendor',
    deviceProduct: 'deviceProduct',
    deviceVersion: 'deviceVersion',
    deviceEventClassId: 'deviceEventClassId',
    name: 'name',
    deviceSeverity: 'deviceSeverity'
  }.freeze

  # these are the basic extension attributes. implementing others is as
  # simple as adding :symbolRepresentingMethodName => "cefkeyname", but
  # i am supremely lazy to type in the whole dictionary right now. perhaps
  # this should be a .yaml config file. Extension attributes are formatted
  # differently than core attributes.
  EXTENSION_ATTRIBUTES = {
    applicationProtocol: 'app',

    agentZoneURI: 'agentZoneURI',
    agentAddress: 'agt',
    agentHostName: 'ahost',
    agentId: 'aid',
    agentName: 'agentName',
    agentType: 'at',
    agentTimeZone: 'atz',
    agentVersion: 'av',

    baseEventCount: 'cnt',
    baseEventIds: 'baseEventIds',
    bytesIn: 'in',
    bytesOut: 'out',

    categoryBehavior: 'categoryBehavior',
    categoryDeviceGroup: 'categoryDeviceGroup',
    categoryObject: 'categoryObject',
    categoryOutcome: 'categoryOutcome',
    categorySignificance: 'categorySignificance',

    deviceAction: 'act',
    deviceDirection: 'deviceDirection',
    deviceDnsDomain: 'deviceDnsDomain',
    deviceEventCategory: 'cat',
    deviceExternalId: 'deviceExternalId',
    deviceFacility: 'deviceFacility',
    deviceAddress: 'dvc',
    deviceHostName: 'dvchost',
    deviceInboundInterface: 'deviceInboundInterface',
    deviceMacAddress: 'deviceMacAddress',
    deviceNtDomain: 'deviceNtDomain',
    deviceOutboundInterface: 'deviceOutboundInterface',
    devicePayloadId: 'devicePayloadId',
    deviceProcessName: 'deviceProcessName',
    deviceTimeZone: 'dtz',
    deviceTranslatedAddress: 'deviceTranslatedAddress',
    deviceTranslatedZoneURI: 'deviceTranslatedZoneURI',
    deviceZoneURI: 'deviceZoneURI',

    deviceCustomNumber1: 'cn1',
    deviceCustomNumber2: 'cn2',
    deviceCustomNumber3: 'cn3',
    deviceCustomNumber1Label: 'cn1Label',
    deviceCustomNumber2Label: 'cn2Label',
    deviceCustomNumber3Label: 'cn3Label',
    deviceCustomString1: 'cs1',
    deviceCustomString2: 'cs2',
    deviceCustomString3: 'cs3',
    deviceCustomString4: 'cs4',
    deviceCustomString5: 'cs5',
    deviceCustomString6: 'cs6',
    deviceCustomString1Label: 'cs1Label',
    deviceCustomString2Label: 'cs2Label',
    deviceCustomString3Label: 'cs3Label',
    deviceCustomString4Label: 'cs4Label',
    deviceCustomString5Label: 'cs5Label',
    deviceCustomString6Label: 'cs6Label',
    deviceCustomDate1: 'deviceCustomDate1',
    deviceCustomDate2: 'deviceCustomDate2',
    deviceCustomDate1Label: 'deviceCustomDate1Label',
    deviceCustomDate2Label: 'deviceCustomDate2Label',

    destinationAddress: 'dst',
    destinationDnsDomain: 'destinationDnsDomain',
    destinationNtDomain: 'dntdom',
    destinationHostName: 'dhost',
    destinationMacAddress: 'dmac',
    destinationPort: 'dpt',
    destinationProcessName: 'dproc',
    destinationServiceName: 'destinationServiceName',
    destinationTranslatedAddress: 'destinationTranslatedAddress',
    destinationTranslatedPort: 'destinationTranslatedPort',
    destinationUserId: 'duid',
    destinationUserPrivileges: 'dpriv',
    destinationUserName: 'duser',
    destinationZoneURI: 'destinationZoneURI',

    eventId: 'eventId',
    externalId: 'externalId',
    eventType: 'type',

    fileHash: 'fileHash',
    fileId: 'fileId',
    fileName: 'fname',
    filePath: 'filePath',
    filePermission: 'filePermission',
    fileSize: 'fsize',
    fileType: 'fileType',

    generatorID: 'generatorID',

    message: 'msg',

    oldfileHash: 'oldfileHash',
    oldfileId: 'oldfileId',
    oldFilename: 'oldFilename',
    oldfilePath: 'oldfilePath',
    oldfilePermission: 'oldfilePermission',
    oldfsize: 'oldfsize',
    oldfileType: 'oldfileType',

    requestURL: 'request',
    requestClientApplication: 'requestClientApplication',
    requestCookies: 'requestCookies',
    requestMethod: 'requestMethod',

    sourceAddress: 'src',
    sourceDnsDomain: 'sourceDnsDomain',
    sourceHostName: 'shost',
    sourceMacAddress: 'smac',
    sourceNtDomain: 'sntdom',
    sourcePort: 'spt',
    sourceServiceName: 'sourceServiceName',
    sourceTranslatedAddress: 'sourceTranslatedAddress',
    sourceTranslatedPort: 'sourceTranslatedPort',
    sourceUserPrivileges: 'spriv',
    sourceUserId: 'suid',
    sourceUserName: 'suser',
    sourceZoneURI: 'sourceZoneURI',

    transportProtocol: 'proto'
  }.freeze

  # these are tracked separately so they can be normalized during formatting
  TIME_ATTRIBUTES = {
    fileCreateTime: 'fileCreateTime',
    fileModificationTime: 'fileModificationTime',
    oldfileCreateTime: 'oldfileCreateTime',
    oldfileModificationTime: 'oldfileModificationTime',
    receiptTime: 'rt',
    startTime: 'start',
    endTime: 'end',
    managerReceiptTime: 'mrt',
    agentReceiptTime: 'art'

  }.freeze

  ATTRIBUTES = PREFIX_ATTRIBUTES.merge EXTENSION_ATTRIBUTES.merge TIME_ATTRIBUTES
end
