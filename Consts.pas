
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{  Copyright (c) 1995-2001 Borland Software Corporation }
{                                                       }
{*******************************************************}

unit Consts;

interface

resourcestring
  SOpenFileTitle = '�������';
  SCantWriteResourceStreamError = '�� ���� ���������� � ����� �������� "������ ��� ������"';
  SDuplicateReference = 'WriteObject ������ ������ ��� ������ � ���� �� ����������';
  SClassMismatch = '�������� ����� ������� %s';
  SInvalidTabIndex = 'Tab ������ ����� �� �������';
  SInvalidTabPosition = '������� tab ������������ � ������� ������ tab';
  SInvalidTabStyle = 'C���� tab ����������� � ������� �������� tab';
  SInvalidBitmap = '����������� Bitmap ����� �������� ������';
  SInvalidIcon = '������ (Icon) ����� �������� ������';
  SInvalidMetafile = '�������� ����� �������� ������';
  SInvalidPixelFormat = '�������� �������� (pixel) ������';
  SInvalidImage = '�������� �����������';
  SBitmapEmpty = '����������� Bitmap ������';
  SScanLine = 'Scan line ������ ����� �� �������';
  SChangeIconSize = '�� ���� �������� ������ ������';
  SOleGraphic = '�������� �������� � TOleGraphic';
  SUnknownExtension = '����������� ���������� ����� ����������� (.%s)';
  SUnknownClipboardFormat = '���������������� ������ ������ ������';
  SOutOfResources = '�� ������� ��������� ��������';
  SNoCanvasHandle = 'Canvas �� ��������� ��������';
  SInvalidImageSize = '�������� ������ �����������';
  STooManyImages = '������� ����� �����������';
  SDimsDoNotMatch = '������� ����������� �� ��������� � ��������� � image list';
  SInvalidImageList = '�������� ImageList';
  SReplaceImage = '���������� �������� �����������';
  SImageIndexError = '�������� ������ ImageList';
  SImageReadFail = '������ ������ ������ ImageList �� ������';
  SImageWriteFail = '������ ������ ������ ImageList � �����';
  SWindowDCError = '������ �������� ��������� ���� (window device context)';
  SClientNotSet = '������ TDrag �� ���������������';
  SWindowClass = '������ �������� �������� ������';
  SWindowCreate = '������ �������� ����';
  SCannotFocus = '�� ���� �������� ����� ����� ������������ ��� ���������� ����';
  SParentRequired = '������� ���������� ''%s'' �� ����� ������������� ����';
  SParentGivenNotAParent = '������ �������� �� �������� ��������� ''%s''';
  SMDIChildNotVisible = '�� ���� ������ �������� ����� MDI';
  SVisibleChanged = '�� ���� �������� Visible � OnShow ��� OnHide';
  SCannotShowModal = '�� ���� ������� ������� ��������� ����';
  SScrollBarRange = '�������� Scrollbar ����� �� �������';
  SPropertyOutOfRange = '�������� %s ����� �� �������';
  SMenuIndexError = '������ ���� ����� �� �������';
  SMenuReinserted = '���� ��������� ������';
  SMenuNotFound = '������� - �� � ����';
  SNoTimers = '��� ��������� ��������';
  SNotPrinting = '������� �� ��������� ������ � ��������� ������';
  SPrinting = '���� ������...';
  SPrinterIndexError = '������ �������� ����� �� �������';
  SInvalidPrinter = '������ �������� �������';
  SDeviceOnPort = '%s on %s';
  SGroupIndexTooLow = 'GroupIndex �� ����� ���� ������, ��� GroupIndex ����������� ������ ����';
  STwoMDIForms = '������ ����� ����� ����� �������� MDI ����� � ���������';
  SNoMDIForm = '�� ���� ������� �����. ��� �������� MDI ����';
  SImageCanvasNeedsBitmap = '����� ������������� ������ �����������, ������� �������� bitmap';
  SControlParentSetToSelf = '������� ���������� �� ����� ���� ��������� ������ ����';
  SOKButton = 'OK';
  SCancelButton = '������';
  SYesButton = '&��';
  SNoButton = '&���';
  SHelpButton = '&�������';
  SCloseButton = '&�������';
  SIgnoreButton = '���&�������';
  SRetryButton = '&���������';
  SAbortButton = '��������';
  SAllButton = '&���';

  SCannotDragForm = '�� ���� ���������� �����';
  SPutObjectError = 'PutObject ��� ��������������� ����';
  SCardDLLNotLoaded = '�� ���� ��������� CARDS.DLL';
  SDuplicateCardId = '������ �������� CardId';

  SDdeErr = '���������� ������ DDE  ($0%x)';
  SDdeConvErr = '������ DDE - ������ �� ���������� ($0%x)';
  SDdeMemErr = '������ - �� ������� ������ ��� DDE ($0%x)';
  SDdeNoConnect = '�� ���� ������������ DDE ������ (conversation)';

  SFB = 'FB';
  SFG = 'FG';
  SBG = 'BG';
  SOldTShape = '�� ���� ��������� ������ ������ TShape';
  SVMetafiles = '���������';
  SVEnhMetafiles = '����������� ���������';
  SVIcons = '������';
  SVBitmaps = '��������';
  SGridTooLarge = '������� (Grid) ������� ������� ��� ������';
  STooManyDeleted = '��������� ������� ����� ����� ��� ��������';
  SIndexOutOfRange = '������ Grid ����� �� �������';
  SFixedColTooBig = '����� ������������� �������� ������ ���� ������ ������ ����� ��������';
  SFixedRowTooBig = '����� ������������� ����� ������ ���� ������ ������ ����� �����';
  SInvalidStringGridOp = '�� ���� �������� ��� ������� ������ �� ������� (grid)';
  SInvalidEnumValue = '�������� Enum ��������';
  SInvalidNumber = '�������� �������� ��������';
  SOutlineIndexError = '������ Outline �� ������';
  SOutlineExpandError = '������������ ���� ������ ���� �������';
  SInvalidCurrentItem = '�������� �������� ��� �������� ��������';
  SMaskErr = '������� �������� ��������';
  SMaskEditErr = '������� �������� ��������.  ������� Esc ��� ������ ���������';
  SOutlineError = '�������� ������ outline';
  SOutlineBadLevel = '�������� ����������� ������';
  SOutlineSelection = '�������� �����';
  SOutlineFileLoad = '������ �������� �����';
  SOutlineLongLine = '������ ������� �������';
  SOutlineMaxLevels = '���������� ������������ ������� outline';

  SMsgDlgWarning = '��������������';
  SMsgDlgError = '������';
  SMsgDlgInformation = '����������';
  SMsgDlgConfirm = '�������������';
  SMsgDlgYes = '&��';
  SMsgDlgNo = '&���';
  SMsgDlgOK = 'OK';
  SMsgDlgCancel = '������';
  SMsgDlgHelp = '&�������';
  SMsgDlgHelpNone = '������� ����������';
  SMsgDlgHelpHelp = '�������';
  SMsgDlgAbort = '�&�������';
  SMsgDlgRetry = '&���������';
  SMsgDlgIgnore = '���&�������';
  SMsgDlgAll = '&���';
  SMsgDlgNoToAll = '�&�� ��� ����';
  SMsgDlgYesToAll = '�&� ��� ����';

  SmkcBkSp = 'BkSp';
  SmkcTab = 'Tab';
  SmkcEsc = 'Esc';
  SmkcEnter = 'Enter';
  SmkcSpace = 'Space';
  SmkcPgUp = 'PgUp';
  SmkcPgDn = 'PgDn';
  SmkcEnd = 'End';
  SmkcHome = 'Home';
  SmkcLeft = 'Left';
  SmkcUp = 'Up';
  SmkcRight = 'Right';
  SmkcDown = 'Down';
  SmkcIns = 'Ins';
  SmkcDel = 'Del';
  SmkcShift = 'Shift+';
  SmkcCtrl = 'Ctrl+';
  SmkcAlt = 'Alt+';

  srUnknown = '(����������)';
  srNone = '(���)';
  SOutOfRange = '�������� ������ ���� ����� %d � %d';

  SDateEncodeError = '�������� �������� ��� ������������ ����';
  SDefaultFilter = '��� ����� (*.*)|*.*';
  sAllFilter = '���';
  SNoVolumeLabel = ': [ - ��� ����� ���� - ]';
  SInsertLineError = '���������� �������� ������';

  SConfirmCreateDir = '��������� ����� �� ����������. ������� ��?';
  SSelectDirCap = '����� �����';
  SDirNameCap = '&��� �����:';
  SDrivesCap = '&����������:';
  SDirsCap = '&�����:';
  SFilesCap = '&�����: (*.*)';
  SNetworkCap = '&����...';

  SColorPrefix = 'Color';
  SColorTags = 'ABCDEFGHIJKLMNOP';

  SInvalidClipFmt = '�������� ������ ������ ������';
  SIconToClipboard = '����� ������ �� ������������ ������';
  SCannotOpenClipboard = '�� ���� ������� ����� ������';

  SDefault = 'Default';

  SInvalidMemoSize = '����� �������� ������� memo';
  SCustomColors = 'Custom Colors';
  SInvalidPrinterOp = '�������� �� �������������� �� ��������� ��������';
  SNoDefaultPrinter = '��� ���������� �� ��������� ��������';

  SIniFileWriteError = '�� ���� �������� � %s';

  SBitsIndexError = '������ Bits ����� �� �������';

  SUntitled = '(��� �����)';

  SInvalidRegType = '�������� ��� ������ ��� ''%s''';

  SUnknownConversion = '����������� ���������� ����� ��� ��������������� RichEdit (.%s)';
  SDuplicateMenus = '���� ''%s'' ��� ������������ ������ ������';

  SPictureLabel = '��������:';
  SPictureDesc = ' (%dx%d)';
  SPreviewLabel = '��������';

  SCannotOpenAVI = '�� ���� ������� AVI';

  SNotOpenErr = '��� �������� ��������� MCI';
  SMPOpenFilter = '��� ����� (*.*)|*.*|����� ����� (*.wav)|*.wav|Midi ����� (*.mid)|*.mid|����� ��� Windows (*.avi)|*.avi';
  SMCINil = '';
  SMCIAVIVideo = 'AVIVideo';
  SMCICDAudio = 'CDAudio';
  SMCIDAT = 'DAT';
  SMCIDigitalVideo = 'DigitalVideo';
  SMCIMMMovie = 'MMMovie';
  SMCIOther = 'Other';
  SMCIOverlay = 'Overlay';
  SMCIScanner = 'Scanner';
  SMCISequencer = 'Sequencer';
  SMCIVCR = 'VCR';
  SMCIVideodisc = 'Videodisc';
  SMCIWaveAudio = 'WaveAudio';
  SMCIUnknownError = '����������� ��� ������';

  SBoldItalicFont = 'Bold Italic';
  SBoldFont = 'Bold';
  SItalicFont = 'Italic';
  SRegularFont = 'Regular';

  SPropertiesVerb = '��������';

  SServiceFailed = '���� ������ �� %s: %s';
  SExecute = 'execute';
  SStart = 'start';
  SStop = 'stop';
  SPause = 'pause';
  SContinue = 'continue';
  SInterrogate = 'interrogate';
  SShutdown = 'shutdown';
  SCustomError = '���� ������ � custom message(%d): %s';
  SServiceInstallOK = '������ ����������� �������';
  SServiceInstallFailed = '���� ��� ��������� ������ "%s", ������: "%s"';
  SServiceUninstallOK = '������ ����� �������';
  SServiceUninstallFailed = '���� ��� ������ ������ "%s", ������: "%s"';

  SInvalidActionRegistration = '�������� ����������� �������� (action)';
  SInvalidActionUnregistration = '�������� ������ ����������� �������� (action)';
  SInvalidActionEnumeration = '�������� �������� �������� (action)';
  SInvalidActionCreation = '�������� �������� �������� (action)';

  SDockedCtlNeedsName = '������������ ������� ������ ����� ���';
  SDockTreeRemoveError = '������ �������� �������� �� dock tree';
  SDockZoneNotFound = ' - ������� ����������� �� �������';
  SDockZoneHasNoCtl = ' - ������� ����������� �� ����� ��������� ����������';

  SAllCommands = 'All Commands';

  SDuplicateItem = '������ �� ��������� ���������� ($0%x)';

  STextNotFound = '����� �� ������: "%s"';
  SBrowserExecError = '�� ��������� ������� �� ���������';

  SColorBoxCustomCaption = '�������...';

  SMultiSelectRequired = '����� �������������� ������ ������ ���� ������� ��� ���� �����������';

  SKeyCaption = '��������';
  SValueCaption = '��������';
  SKeyConflict = '�������� � ������ "%s" ��� ������';
  SKeyNotFound = '�������� "%s" �� ������';
  SNoColumnMoving = 'goColMoving - ���������������� �����';
  SNoEqualsInKey = '�������� �� ����� ��������� ���� "�����" ("=")';

  SSendError = '������ �������� �����';
  SAssignSubItemError = '�� ���� ��������� �������� � actionbar ����� ���� �� ��� ������� ��� �������� actionbar';
  SDeleteItemWithSubItems = '����� %s ����� ���������, ��� ����� �������?';
  SDeleteNotAllowed = '��� �� ��������� ������� ���� �������';
  SMoveNotAllowed = '������� %s �� ��������� ����������';
  SMoreButtons = '������ ������';
  SErrorDownloadingURL = '������ �������� URL: %s';
  SUrlMonDllMissing = '���������� ��������� %s';
  SAllActions = '(��� ��������)';
  SNoCategory = '(��� ���������)';
  SExpand = 'Expand';
  SErrorSettingPath = '������ ��������� ����: "%s"';
  SLBPutError = '������� ��������� ������ � ����������� listbox';
  SErrorLoadingFile = '������ �������� ����� ������������ ����� ��������: %s'#13'�� ������ ������� ���?';
  SResetUsageData = 'Reset ��� ������������ ������?';
  SFileRunDialogTitle = '���������';
  SNoName = '(��� �����)';
  SErrorActionManagerNotAssigned = 'ActionManager ������ ���� �������� ������';
  SAddRemoveButtons = '&�������� ��� ������� ������';
  SResetActionToolBar = 'Reset Toolbar';
  SCustomize = '&���������';
  SSeparator = '�����������';
  SCirularReferencesNotAllowed = '����������� ������ �� ��������������';
  SCannotHideActionBand = '%s �� ��������� ������ (hiding)';
  SErrorSettingCount = '������ ��������� %s.Count';
  SListBoxMustBeVirtual = 'Listbox (%s) Style ������ ���� Virtual ��� ��������� ������ Count';
  SUnableToSaveSettings = '�� ���� ��������� ���������';
  SRestoreDefaultSchedule = '�� ������ ������������ Priority Schedule �� ���������?';
  SNoGetItemEventHandler = '�� ��������� ���������� OnGetItem';
  SInvalidColorMap = 'Invalid Colormap this ActionBand requires ColorMaps of type TCustomActionBarColorMapEx';
  SDuplicateActionBarStyleName = '����� � ��������� %s ���������������';
  SStandardStyleActionBars = '����������� �����';
  SXPStyleActionBars = 'XP �����';
  SActionBarStyleMissing = 'No ActionBand style unit present in the uses clause.'#13 +
    'Your application must include either XPStyleActnCtrls, StdStyleActnCtrls or ' +
    'a third party ActionBand style unit in its uses clause.';

implementation

end.