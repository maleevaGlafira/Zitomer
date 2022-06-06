object frame_BaseSingleItemSelect: Tframe_BaseSingleItemSelect
  Left = 0
  Top = 0
  Width = 260
  Height = 27
  TabOrder = 0
  object lbl_Caption: TLabel
    Left = 8
    Top = 8
    Width = 52
    Height = 13
    Caption = 'lbl_Caption'
  end
  object dbl_Item: TRxDBLookupCombo
    Left = 68
    Top = 5
    Width = 145
    Height = 21
    DropDownCount = 8
    LookupField = 'ItemID'
    LookupDisplay = 'ItemName'
    LookupSource = ds_MemTable
    TabOrder = 0
  end
  object ds_MemTable: TDataSource
    DataSet = MemTable
    Left = 112
    Top = 8
  end
  object MemTable: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 152
    Top = 8
  end
end
