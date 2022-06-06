object dm_SearchAdres: Tdm_SearchAdres
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 207
  Top = 389
  Height = 323
  Width = 497
  object IBSQL: TIBSQL
    Database = DM_main.IBDatabase
    Transaction = tran_view
    Left = 400
    Top = 16
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 24
    Top = 16
  end
  object tran_view: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 400
    Top = 72
  end
  object md_res: TRxMemoryData
    FieldDefs = <>
    Left = 24
    Top = 144
    object md_resid_group: TIntegerField
      FieldName = 'id_group'
    end
    object md_resadres: TStringField
      FieldName = 'adres'
      Size = 100
    end
    object md_resdmg_count: TIntegerField
      FieldName = 'dmg_count'
    end
    object md_resid_ul1: TIntegerField
      FieldName = 'id_ul1'
    end
    object md_resid_ul2: TStringField
      FieldName = 'id_ul2'
    end
    object md_reskod_ul: TIntegerField
      FieldName = 'kod_ul'
    end
    object md_resid_dopadr: TIntegerField
      FieldName = 'id_dopadr'
    end
  end
  object dset: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 24
    Top = 80
  end
  object dset_adres: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 72
    Top = 80
  end
  object md_bygroup: TRxMemoryData
    FieldDefs = <>
    Left = 208
    Top = 8
    object md_bygroupid: TIntegerField
      FieldName = 'id'
    end
    object md_bygroupdt_in: TDateTimeField
      FieldName = 'dt_in'
    end
    object md_bygroupnomer: TIntegerField
      FieldName = 'nomer'
    end
    object md_bygrouprevs: TStringField
      FieldName = 'revs'
    end
    object md_bygroupadres: TStringField
      FieldName = 'adres'
      Size = 100
    end
    object md_bygroupplace: TStringField
      FieldName = 'place'
    end
    object md_bygroupdiam: TIntegerField
      FieldName = 'diam'
    end
  end
  object frReport: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbPrint, pbExit]
    RebuildPrinter = False
    Left = 72
    Top = 16
    ReportForm = {19000000}
  end
  object frDS_res: TfrDBDataSet
    DataSet = md_res
    Left = 80
    Top = 144
  end
  object frREportDoch: TfrReport
    Dataset = frDBDataSet_doch
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    Left = 216
    Top = 72
    ReportForm = {19000000}
  end
  object frDBDataSet_doch: TfrDBDataSet
    DataSet = md_bygroup
    Left = 224
    Top = 144
  end
end
