object dm_BworkShief: Tdm_BworkShief
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 498
  Top = 272
  Height = 316
  Width = 219
  object tran: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 24
    Top = 16
  end
  object mt_BworkWorks: TkbmMemTable
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
    Left = 40
    Top = 112
    object mt_BworkWorksid: TIntegerField
      FieldName = 'id'
    end
    object mt_BworkWorksid_bwork: TIntegerField
      FieldName = 'id_bwork'
    end
    object mt_BworkWorksid_work: TIntegerField
      FieldName = 'id_work'
    end
    object mt_BworkWorksid_diam: TIntegerField
      FieldName = 'id_diam'
    end
    object mt_BworkWorkswork_name: TStringField
      FieldName = 'work_name'
      Size = 50
    end
    object mt_BworkWorksed_izm: TStringField
      FieldName = 'ed_izm'
      Size = 10
    end
    object mt_BworkWorksplace: TStringField
      FieldName = 'place'
    end
    object mt_BworkWorksdiam: TIntegerField
      FieldName = 'diam'
      OnGetText = mt_BworkWorksdiamGetText
    end
  end
  object dset: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 72
    Top = 16
  end
  object mt_BworkMaters: TkbmMemTable
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
    Left = 40
    Top = 176
    object mt_BworkMatersid: TIntegerField
      FieldName = 'id'
    end
    object mt_BworkMatersid_bwork: TIntegerField
      FieldName = 'id_bwork'
    end
    object mt_BworkMatersid_mater: TIntegerField
      FieldName = 'id_mater'
    end
    object mt_BworkMatersid_diam: TIntegerField
      FieldName = 'id_diam'
    end
    object mt_BworkMatersmater: TStringField
      FieldName = 'mater'
    end
    object mt_BworkMatersdiam: TIntegerField
      FieldName = 'diam'
      OnGetText = mt_BworkWorksdiamGetText
    end
  end
  object IBSQL: TIBSQL
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 144
    Top = 16
  end
end
