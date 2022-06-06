inherited dm_RepExcavNotFinished2: Tdm_RepExcavNotFinished2
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object rm_main: TRxMemoryData
    FieldDefs = <>
    Left = 80
    Top = 160
    object rm_mainid_zav: TIntegerField
      FieldName = 'id_zav'
    end
    object rm_mainid_ras: TIntegerField
      FieldName = 'id_ras'
    end
    object rm_mainnomer: TIntegerField
      FieldName = 'nomer'
    end
    object rm_mainadres: TStringField
      FieldName = 'adres'
      Size = 1000
    end
    object rm_maindt_out: TStringField
      FieldName = 'dt_zav_out'
    end
    object rm_maindt_excav: TStringField
      FieldName = 'dt_excav'
    end
    object rm_mainmes: TStringField
      FieldName = 'mes'
      Size = 50
    end
    object rm_mainplandateexcav: TStringField
      FieldName = 'plandateexcav'
    end
    object rm_maindt_zasexcav: TStringField
      FieldName = 'dt_zasexcav'
    end
    object rm_maindt_planexcav: TStringField
      FieldName = 'dt_planexcav'
    end
    object rm_maindateorg: TStringField
      FieldName = 'dateorg'
    end
    object rm_maindt_cheb: TStringField
      FieldName = 'dt_cheb'
    end
    object rm_maindt_asf: TStringField
      FieldName = 'dt_asf'
    end
    object rm_maindatecloseddocument: TStringField
      FieldName = 'datecloseddocument'
    end
    object rm_mainadd_inf: TStringField
      FieldName = 'add_inf'
      Size = 1000
    end
    object rm_mainnotfinished: TStringField
      FieldName = 'notfinished'
      Size = 5
    end
    object rm_mainstate: TStringField
      FieldName = 'state'
      Size = 10
    end
    object rm_maintodo: TIntegerField
      FieldName = 'todo'
    end
    object rm_maindt_zav_in: TStringField
      FieldName = 'dt_zav_in'
      Size = 17
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 16
    Top = 72
  end
  object dset: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 88
    Top = 72
  end
  object dset_revs: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 160
    Top = 72
  end
  object frDBDmain: TfrDBDataSet
    DataSet = rm_main
    Left = 16
    Top = 136
  end
end
