inherited dm_DiskondRepGroup: Tdm_DiskondRepGroup
  inherited frReport: TfrReport
    Dataset = frDBDataSet1
    ReportForm = {19000000}
  end
  object rmmain: TRxMemoryData
    FieldDefs = <>
    Left = 184
    Top = 16
    object rmmainid_wwater: TIntegerField
      FieldName = 'id_wwater'
    end
    object rmmainid_rayon: TIntegerField
      FieldName = 'id_rayon'
    end
    object rmmainregion: TStringField
      FieldName = 'region'
    end
    object rmmainid: TIntegerField
      FieldName = 'id'
    end
    object rmmainstreet_disc: TStringField
      FieldName = 'street_disc'
      Size = 40
    end
    object rmmainadress_disc: TStringField
      FieldName = 'adress_disc'
      Size = 2000
    end
    object rmmaindt_discon: TDateField
      FieldName = 'dt_discon'
    end
    object rmmaintm_discon: TTimeField
      FieldName = 'tm_discon'
    end
    object rmmaindt_con: TDateField
      FieldName = 'dt_con'
    end
    object rmmaintm_con: TTimeField
      FieldName = 'tm_con'
    end
    object rmmainhours_water: TFloatField
      FieldName = 'hours_water'
    end
    object rmmainnomer1: TIntegerField
      FieldName = 'nomer1'
    end
    object rmmainadres1: TStringField
      FieldName = 'adres1'
      Size = 200
    end
    object rmmaindt_zav: TStringField
      FieldName = 'dt_zav'
    end
    object rmmaindt_in: TStringField
      FieldName = 'dt_in'
    end
    object rmmaincoment: TStringField
      FieldName = 'coment'
      Size = 2000
    end
    object rmmainminute_water: TFloatField
      FieldName = 'minute_water'
    end
    object rmmaindttm_con: TStringField
      FieldName = 'dttm_con'
      Size = 30
    end
    object rmmaindttm_discon: TStringField
      FieldName = 'dttm_discon'
      Size = 30
    end
    object rmmainempty: TStringField
      FieldName = 'empty'
      Size = 1
    end
    object rmmainkodPerv: TStringField
      FieldName = 'kodPerv'
      Size = 4
    end
    object rmmainkod06: TStringField
      FieldName = 'kod06'
      Size = 2
    end
    object rmmainkod07: TStringField
      FieldName = 'kod07'
      Size = 2
    end
    object rmmainkod08: TStringField
      FieldName = 'kod08'
      Size = 2
    end
    object rmmainkod09: TStringField
      FieldName = 'kod09'
      Size = 2
    end
    object rmmainkod10: TStringField
      FieldName = 'kod10'
      Size = 2
    end
    object rmmainlongminute: TStringField
      FieldName = 'longminute'
      Size = 10
    end
    object rmmainNOMER_DISCON: TIntegerField
      FieldName = 'NOMER_DISCON'
    end
    object rmmainrevs: TStringField
      FieldName = 'revs'
      Size = 100
    end
    object rmmainsetlers: TStringField
      FieldName = 'setlers'
      Size = 100
    end
  end
  object dset_main: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 104
    Top = 120
  end
  object dset_kod: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select ss.kod from s_pererv ss where ss.pername is not null')
    Left = 168
    Top = 112
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = rmmain
    Left = 88
    Top = 16
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Left = 40
    Top = 120
  end
end
