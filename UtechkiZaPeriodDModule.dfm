object dm_UtechkiZaPeriod: Tdm_UtechkiZaPeriod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 316
  Top = 304
  Height = 320
  Width = 489
  object dset: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 88
    Top = 32
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 24
    Top = 32
  end
  object tran_view: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 408
    Top = 40
  end
  object md_res: TRxMemoryData
    FieldDefs = <>
    Left = 40
    Top = 128
    object md_resid: TIntegerField
      FieldName = 'id'
    end
    object md_resnomer: TIntegerField
      FieldName = 'nomer'
    end
    object md_resdt_in: TDateTimeField
      FieldName = 'dt_in'
    end
    object md_resid_revs: TIntegerField
      FieldName = 'id_revs'
    end
    object md_resrevs: TStringField
      FieldName = 'revs'
      Size = 50
    end
    object md_resadres: TStringField
      FieldName = 'adres'
      Size = 150
    end
    object md_respromyv: TFloatField
      FieldName = 'promyv'
    end
    object md_resoporozhn: TFloatField
      FieldName = 'oporozhn'
    end
    object md_respovrezhd: TFloatField
      FieldName = 'povrezhd'
    end
    object md_ressum_poteri: TFloatField
      FieldName = 'sum_poteri'
    end
    object md_resmain_gr: TIntegerField
      FieldName = 'main_gr'
    end
  end
  object sql_view: TIBSQL
    Database = DM_main.IBDatabase
    Transaction = tran_view
    Left = 336
    Top = 40
  end
  object frReport: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbPrint, pbExit]
    RebuildPrinter = False
    Left = 224
    Top = 24
    ReportForm = {19000000}
  end
  object frDS_res: TfrDBDataSet
    DataSet = md_res
    Left = 224
    Top = 88
  end
end
