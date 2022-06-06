inherited dm_RepOpenDisconShift: Tdm_RepOpenDisconShift
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object dset_main: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 160
    Top = 120
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Left = 88
    Top = 128
  end
  object rmem: TRxMemoryData
    FieldDefs = <>
    Left = 88
    Top = 32
    object rmemid: TIntegerField
      FieldName = 'id'
    end
    object rmemnomer: TIntegerField
      FieldName = 'nomer'
    end
    object rmemattach: TStringField
      FieldName = 'attach'
      Size = 150
    end
    object rmemaddress: TStringField
      FieldName = 'address'
      Size = 200
    end
    object rmemnarads: TMemoField
      FieldName = 'narads'
      BlobType = ftMemo
    end
    object rmemrev: TStringField
      FieldName = 'rev'
      Size = 150
    end
    object rmemdt_in: TStringField
      FieldName = 'dt_in'
    end
    object rmemid_revs: TIntegerField
      FieldName = 'id_revs'
    end
    object rmemcomment: TStringField
      FieldName = 'comment'
      Size = 100
    end
  end
end
