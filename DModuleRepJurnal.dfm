inherited dm_RepJurnal: Tdm_RepJurnal
  Height = 385
  Width = 392
  inherited frReport: TfrReport
    Dataset = frDBDataSet1
    ReportForm = {19000000}
  end
  object dset: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = IBTransaction1
    Left = 40
    Top = 240
  end
  object dset_mech: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = IBTransaction1
    SelectSQL.Strings = (
      'select    rtrim(so.name_r)||'#39' '#39'||rtrim(so.fio)  name_r  '
      
        '           from obors ob,s_obor so where ob.id_nar=:id_nar  and ' +
        'so.id=ob.id_obor')
    Left = 184
    Top = 224
  end
  object rm_execute: TRxMemoryData
    FieldDefs = <>
    Left = 24
    Top = 152
    object rm_executeid_zav: TIntegerField
      FieldName = 'id_zav'
    end
    object rm_executeid_nar: TIntegerField
      FieldName = 'id_nar'
    end
    object rm_executenumber: TIntegerField
      FieldName = 'number'
    end
    object rm_executeadress: TStringField
      FieldName = 'adress'
      Size = 200
    end
    object rm_executedateOpen: TDateTimeField
      FieldName = 'dateOpen'
    end
    object rm_executedt_in: TDateTimeField
      FieldName = 'dt_in'
    end
    object rm_executedt_out: TDateTimeField
      FieldName = 'dt_out'
    end
    object rm_executediam: TIntegerField
      FieldName = 'diam'
    end
    object rm_executenameBrig: TStringField
      FieldName = 'nameBrig'
      Size = 30
    end
    object rm_executedolgBrig: TStringField
      FieldName = 'dolgBrig'
      Size = 30
    end
    object rm_executemechanism: TStringField
      FieldName = 'mechanism'
      Size = 2000
    end
    object rm_executenote: TStringField
      FieldName = 'note'
      Size = 500
    end
    object rm_executedateclosed: TDateTimeField
      FieldName = 'dateclosed'
    end
    object rm_executenomer_dateOpen: TStringField
      FieldName = 'nomer_dateOpen'
      Size = 25
    end
    object rm_executedateExecute: TStringField
      FieldName = 'dateExecute'
      Size = 50
    end
    object rm_executeBrig: TStringField
      FieldName = 'Brig'
      Size = 70
    end
    object rm_executedateClosedString: TStringField
      FieldName = 'dateClosedString'
    end
    object rm_executeid_rev: TIntegerField
      FieldName = 'id_rev'
    end
    object rm_executename_rev: TStringField
      FieldName = 'name_rev'
      Size = 100
    end
  end
  object rm_accept: TRxMemoryData
    FieldDefs = <>
    Left = 88
    Top = 144
    object IntegerField1: TIntegerField
      FieldName = 'id_zav'
    end
    object IntegerField2: TIntegerField
      FieldName = 'id_nar'
    end
    object IntegerField3: TIntegerField
      FieldName = 'number'
    end
    object rm_acceptadress: TStringField
      FieldName = 'adress'
      Size = 200
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'dateOpen'
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'dt_in'
    end
    object DateTimeField3: TDateTimeField
      FieldName = 'dt_out'
    end
    object IntegerField4: TIntegerField
      FieldName = 'diam'
    end
    object StringField1: TStringField
      FieldName = 'nameBrig'
      Size = 30
    end
    object StringField2: TStringField
      FieldName = 'dolgBrig'
      Size = 30
    end
    object StringField3: TStringField
      FieldName = 'mechanism'
      Size = 2000
    end
    object StringField4: TStringField
      FieldName = 'note'
      Size = 500
    end
    object DateTimeField4: TDateTimeField
      FieldName = 'dateclosed'
    end
    object StringField5: TStringField
      FieldName = 'nomer_dateOpen'
      Size = 25
    end
    object StringField6: TStringField
      FieldName = 'dateExecute'
      Size = 50
    end
    object StringField7: TStringField
      FieldName = 'Brig'
      Size = 70
    end
    object rm_acceptdateClosedString: TStringField
      FieldName = 'dateClosedString'
    end
    object rm_acceptid_rev: TIntegerField
      FieldName = 'id_rev'
    end
    object rm_acceptname_rev: TStringField
      FieldName = 'name_rev'
      Size = 100
    end
  end
  object rm_finished: TRxMemoryData
    FieldDefs = <>
    Left = 208
    Top = 160
    object IntegerField5: TIntegerField
      FieldName = 'id_zav'
    end
    object IntegerField6: TIntegerField
      FieldName = 'id_nar'
    end
    object rm_finishedadress: TStringField
      FieldName = 'adress'
      Size = 200
    end
    object IntegerField7: TIntegerField
      FieldName = 'number'
    end
    object DateTimeField5: TDateTimeField
      FieldName = 'dateOpen'
    end
    object DateTimeField6: TDateTimeField
      FieldName = 'dt_in'
    end
    object DateTimeField7: TDateTimeField
      FieldName = 'dt_out'
    end
    object IntegerField8: TIntegerField
      FieldName = 'diam'
    end
    object StringField8: TStringField
      FieldName = 'nameBrig'
      Size = 30
    end
    object StringField9: TStringField
      FieldName = 'dolgBrig'
      Size = 30
    end
    object StringField10: TStringField
      FieldName = 'mechanism'
      Size = 2000
    end
    object StringField11: TStringField
      FieldName = 'note'
      Size = 500
    end
    object DateTimeField8: TDateTimeField
      FieldName = 'dateclosed'
    end
    object StringField12: TStringField
      FieldName = 'nomer_dateOpen'
      Size = 25
    end
    object StringField13: TStringField
      FieldName = 'dateExecute'
      Size = 50
    end
    object StringField14: TStringField
      FieldName = 'Brig'
      Size = 70
    end
    object rm_finisheddateClosedString: TStringField
      FieldName = 'dateClosedString'
    end
    object rm_finishedid_rev: TIntegerField
      FieldName = 'id_rev'
    end
    object rm_finishedname_rev: TStringField
      FieldName = 'name_rev'
      Size = 100
    end
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = rm_execute
    Left = 16
    Top = 88
  end
  object frDBDataSet2: TfrDBDataSet
    DataSet = rm_accept
    Left = 96
    Top = 88
  end
  object frDBDataSet3: TfrDBDataSet
    DataSet = rm_finished
    Left = 184
    Top = 88
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Left = 96
    Top = 32
  end
end
