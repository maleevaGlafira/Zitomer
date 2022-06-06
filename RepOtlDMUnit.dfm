inherited dm_OtlReport: Tdm_OtlReport
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Left = 584
  Top = 265
  Height = 332
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  inherited md_res: TRxMemoryData
    OnCalcFields = md_resCalcFields
    object md_reslinkedzav: TStringField
      FieldName = 'linkedzav'
      Size = 500
    end
    object md_reslist_zav: TStringField
      FieldName = 'list_zav'
      Size = 2000
    end
    object md_reslist_count: TIntegerField
      FieldName = 'list_count'
    end
    object md_resinvers_Count: TIntegerField
      FieldName = 'invers_list_count'
    end
    object md_resinvers_nomer: TIntegerField
      FieldName = 'invers_nomer'
    end
    object md_resinvers_dt_in: TFloatField
      FieldName = 'invers_dt_in'
    end
    object md_resinvers_adres: TStringField
      FieldName = 'invers_adres'
      Size = 100
    end
    object md_resinvers_dt_out: TDateTimeField
      FieldName = 'invers_dt_out'
    end
  end
  object MD_RESGROUP: TRxMemoryData
    FieldDefs = <>
    Left = 272
    Top = 144
    object MD_RESGROUPID: TIntegerField
      FieldName = 'ID'
    end
    object MD_RESGROUPnomer: TIntegerField
      FieldName = 'nomer'
    end
    object MD_RESGROUPrev: TStringField
      FieldName = 'revs'
      Size = 30
    end
    object MD_RESGROUPattach: TStringField
      FieldName = 'attach'
      Size = 50
    end
    object MD_RESGROUPadres: TStringField
      FieldName = 'adres'
      Size = 300
    end
    object MD_RESGROUPsod: TStringField
      FieldName = 'sod'
      Size = 30
    end
    object MD_RESGROUPdt_in: TDateTimeField
      FieldName = 'dt_in'
    end
  end
  object md_resall: TRxMemoryData
    FieldDefs = <>
    Left = 272
    Top = 224
    object IntegerField1: TIntegerField
      FieldName = 'main_gr'
    end
    object StringField1: TStringField
      FieldName = 'zav_type_name'
      Size = 50
    end
    object IntegerField2: TIntegerField
      FieldName = 'id'
    end
    object IntegerField3: TIntegerField
      FieldName = 'nomer'
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'dt_in'
    end
    object IntegerField4: TIntegerField
      FieldName = 'id_attach'
    end
    object IntegerField5: TIntegerField
      FieldName = 'id_revs'
    end
    object StringField2: TStringField
      FieldName = 'revs'
      Size = 50
    end
    object StringField3: TStringField
      FieldName = 'attach'
    end
    object StringField4: TStringField
      FieldName = 'adres'
      Size = 100
    end
    object StringField5: TStringField
      FieldName = 'sod'
      Size = 50
    end
    object StringField6: TStringField
      FieldName = 'vrabote'
    end
    object StringField7: TStringField
      FieldName = 'primech'
      Size = 500
    end
    object StringField8: TStringField
      FieldName = 'vipol'
    end
    object StringField9: TStringField
      FieldName = 'wwater_list'
      Size = 1000
    end
    object StringField10: TStringField
      FieldName = 'object'
      Size = 120
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'dt_out'
    end
    object StringField11: TStringField
      FieldName = 'linkedzav'
      Size = 500
    end
    object md_resallid_link: TIntegerField
      FieldName = 'id_link'
    end
    object md_resallnomer_link: TIntegerField
      FieldName = 'nomer_link'
    end
    object md_resallrevs_link: TStringField
      FieldName = 'revs_link'
      Size = 50
    end
    object md_resallattach_link: TStringField
      FieldName = 'attach_link'
      Size = 50
    end
    object md_resallsod_link: TStringField
      FieldName = 'sod_link'
      Size = 50
    end
    object md_resalldt_out_link: TDateTimeField
      FieldName = 'dt_out_link'
    end
  end
end
