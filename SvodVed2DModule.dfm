object dm_SvodVed2: Tdm_SvodVed2
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Left = 513
  Top = 472
  Height = 271
  Width = 382
  object frReport: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbPrint, pbExit]
    RebuildPrinter = False
    Left = 32
    Top = 24
    ReportForm = {19000000}
  end
  object dset_tmp: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 112
    Top = 24
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Left = 192
    Top = 24
  end
  object md_res: TRxMemoryData
    FieldDefs = <>
    Left = 280
    Top = 24
    object md_resmain_gr: TIntegerField
      FieldName = 'main_gr'
    end
    object md_reszav_type_name: TStringField
      FieldName = 'zav_type_name'
      Size = 50
    end
    object md_resid: TIntegerField
      FieldName = 'id'
    end
    object md_resnomer: TIntegerField
      FieldName = 'nomer'
    end
    object md_resdt_in: TDateTimeField
      FieldName = 'dt_in'
    end
    object md_resid_attach: TIntegerField
      FieldName = 'id_attach'
    end
    object md_resid_revs: TIntegerField
      FieldName = 'id_revs'
    end
    object md_resrevs: TStringField
      FieldName = 'revs'
      Size = 50
    end
    object md_resattach: TStringField
      FieldName = 'attach'
    end
    object md_resadres: TStringField
      FieldName = 'adres'
      Size = 100
    end
    object md_ressod: TStringField
      FieldName = 'sod'
      Size = 50
    end
    object md_resvrabote: TStringField
      FieldName = 'vrabote'
    end
    object md_resprimech: TStringField
      FieldName = 'primech'
      Size = 500
    end
    object md_resvipol: TStringField
      FieldName = 'vipol'
    end
    object md_reswwater_list: TStringField
      FieldName = 'wwater_list'
      Size = 1000
    end
    object md_resobject: TStringField
      FieldName = 'object'
      Size = 120
    end
    object md_resdt_out: TDateTimeField
      FieldName = 'dt_out'
    end
    object md_resdisp_in: TStringField
      FieldName = 'disp_in'
      Size = 100
    end
    object md_resdisp_out: TStringField
      FieldName = 'disp_out'
      Size = 100
    end
    object md_resdt_in_str: TStringField
      FieldName = 'dt_in_str'
    end
    object md_resbrigs: TStringField
      FieldName = 'brigs'
      Size = 500
    end
  end
  object dset_tmp2: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 112
    Top = 88
  end
  object dset_tmp3: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 112
    Top = 152
  end
  object frDS_res: TfrDBDataSet
    DataSet = md_res
    Left = 280
    Top = 88
  end
end
