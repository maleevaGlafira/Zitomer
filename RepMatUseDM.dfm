inherited dm_RepMatUse: Tdm_RepMatUse
  OldCreateOrder = False
  Left = 555
  Top = 256
  Height = 325
  Width = 352
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 88
    Top = 16
  end
  object ResultDset: TkbmMemTable
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
    Left = 168
    Top = 16
    object ResultDsetattach: TStringField
      FieldName = 'attach'
      Size = 30
    end
    object ResultDsetrevs: TStringField
      FieldName = 'revs'
    end
    object ResultDsetdt_in: TDateTimeField
      FieldName = 'dt_in'
    end
    object ResultDsetnomer: TIntegerField
      FieldName = 'nomer'
    end
    object ResultDsetmat: TStringField
      FieldName = 'mat'
      Size = 40
    end
    object ResultDsetdiam: TIntegerField
      FieldName = 'diam'
    end
    object ResultDsetzav_id: TIntegerField
      FieldName = 'zav_id'
    end
    object ResultDsetkol_mat: TFloatField
      FieldName = 'kol_mat'
    end
    object ResultDsetadres: TStringField
      FieldName = 'adres'
      Size = 170
    end
    object ResultDsetid_attach: TIntegerField
      FieldName = 'id_attach'
    end
  end
  object dset: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 24
    Top = 80
  end
  object dset_ZavAdres: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select adres'
      'from get_zav_adres( :pZavID )')
    Left = 24
    Top = 136
  end
  object frDS_Result: TfrDBDataSet
    DataSet = ResultDset
    Left = 256
    Top = 24
  end
end
