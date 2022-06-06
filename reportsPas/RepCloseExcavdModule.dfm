inherited dm_RepCloseExcav: Tdm_RepCloseExcav
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Left = 16
    Top = 136
  end
  object dset: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 80
    Top = 136
  end
  object dset_regions: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 160
    Top = 136
  end
  object rm_main: TRxMemoryData
    FieldDefs = <>
    Left = 80
    Top = 80
    object rm_mainzavnumber: TIntegerField
      FieldName = 'zavnumber'
    end
    object rm_mainzavyear: TIntegerField
      FieldName = 'zavyear'
    end
    object rm_maindt_zav: TDateTimeField
      FieldName = 'dt_zav'
    end
    object rm_mainexcavAdress: TStringField
      FieldName = 'excavAdress'
      Size = 400
    end
    object rm_mainAbout: TStringField
      FieldName = 'About'
      Size = 40
    end
    object rm_maindiam: TIntegerField
      FieldName = 'diam'
    end
    object rm_mainworks: TStringField
      FieldName = 'works'
      Size = 2000
    end
    object rm_maindt_closeZav: TDateTimeField
      FieldName = 'dtOutZav'
    end
    object rm_maindtStartExcav: TDateTimeField
      FieldName = 'dtStartExcav'
    end
    object rm_maindt_plan_sand: TDateTimeField
      FieldName = 'dt_plan_sand'
    end
    object rm_maindateorg: TDateField
      FieldName = 'dateorg'
    end
    object rm_mainnumberroad: TStringField
      FieldName = 'numberroad'
      Size = 10
    end
    object rm_maindt_cheb: TDateField
      FieldName = 'dt_cheb'
    end
    object rm_mainnumbercheb: TStringField
      FieldName = 'numbercheb'
      Size = 10
    end
    object rm_maindt_downasfalt: TDateField
      FieldName = 'dt_downasfalt'
    end
    object rm_maindt_upasfalt: TDateField
      FieldName = 'dt_upasfalt'
    end
    object rm_maindatecloseddocument: TDateField
      FieldName = 'datecloseddocument'
    end
    object rm_mainworksList: TStringField
      FieldName = 'worksList'
      Size = 3000
    end
    object rm_mainmest: TStringField
      FieldName = 'mest'
      Size = 40
    end
    object rm_mainid_rayon: TIntegerField
      FieldName = 'id_rev'
    end
    object rm_mainid_mest: TIntegerField
      FieldName = 'id_mest'
    end
    object rm_mainid_zav: TIntegerField
      FieldName = 'id_zav'
    end
    object rm_mainnumberyear: TStringField
      DisplayWidth = 15
      FieldName = 'numberyear'
      Size = 15
    end
    object rm_mainforGroup: TSmallintField
      FieldName = 'forGroup'
    end
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = rm_main
    Left = 80
    Top = 16
  end
end
