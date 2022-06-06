inherited dm_RepEkonomPokaz: Tdm_RepEkonomPokaz
  OldCreateOrder = False
  Left = 438
  Top = 354
  Height = 236
  Width = 363
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 104
    Top = 16
  end
  object dset: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 168
    Top = 8
  end
  object mt_TZ: TkbmMemTable
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
    Left = 32
    Top = 96
    object mt_TZwork: TStringField
      FieldName = 'work'
      Size = 40
    end
    object mt_TZplace: TStringField
      FieldName = 'place'
    end
    object mt_TZdiam: TIntegerField
      FieldName = 'diam'
    end
    object mt_TZtz: TFloatField
      FieldName = 'tz'
    end
    object mt_TZbrig: TStringField
      FieldName = 'brig'
      Size = 30
    end
    object mt_TZdolgn: TStringField
      FieldName = 'dolgn'
      Size = 25
    end
  end
  object mt_Obor: TkbmMemTable
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
    Left = 144
    Top = 88
    object mt_Oborobor: TStringField
      FieldName = 'obor'
      Size = 30
    end
  end
  object mt_Mat: TkbmMemTable
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
    Left = 256
    Top = 88
    object mt_Matmat: TStringField
      FieldName = 'mat'
      Size = 30
    end
    object mt_Mated_izm: TStringField
      FieldName = 'ed_izm'
      Size = 10
    end
    object mt_Matdiam: TIntegerField
      FieldName = 'diam'
    end
    object mt_Matkol_mat: TFloatField
      FieldName = 'kol_mat'
    end
  end
  object frDS_TZ: TfrDBDataSet
    DataSet = mt_TZ
    Left = 32
    Top = 152
  end
  object frDS_Obor: TfrDBDataSet
    DataSet = mt_Obor
    Left = 144
    Top = 152
  end
  object frDS_Mat: TfrDBDataSet
    DataSet = mt_Mat
    Left = 256
    Top = 152
  end
  object dset_WorkTime: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select n.dt_in, n.dt_out'
      'from nnarad n, ord_people op'
      'where ( n.id = op.id_work )'
      'and ( n.dt_in is not null )'
      'and ( op.id_zav = :pZavID)'
      'and ( op.add_people = :pBrigID )'
      'union all'
      'select n.dt_in, n.dt_out'
      'from narad n, ord_people op'
      'where ( n.id = op.id_work )'
      'and ( n.dt_in is not null )'
      'and ( op.id_zav = :pZavID)'
      'and ( op.add_people = :pBrigID )'
      'order by 1')
    Left = 256
    Top = 16
  end
end
