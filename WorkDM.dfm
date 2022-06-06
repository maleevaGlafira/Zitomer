inherited dm_Work: Tdm_Work
  Left = 285
  Top = 233
  Height = 491
  Width = 603
  object dset_Works: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Main
    AfterCancel = dset_WorksAfterCancel
    AfterEdit = dset_WorksAfterEdit
    AfterInsert = dset_WorksAfterInsert
    AfterPost = dset_WorksAfterPost
    OnCalcFields = dset_WorksCalcFields
    DeleteSQL.Strings = (
      'delete from %s where id = :old_id')
    InsertSQL.Strings = (
      'insert into %s('
      'id, id_zav, id_nar, id_work,'
      'kol_work, id_diam, id_place,'
      'id_killclog, id_pump, id_pes,'
      'tz_trudozatrat, tz_kol_ed, id_raskop)'
      'values('
      ':id, :id_zav, :id_nar, :id_work,'
      ':kol_work, :id_diam, :id_place,'
      ':id_killclog, :id_pump, :id_pes,'
      ':tz_trudozatrat, :tz_kol_ed, :id_raskop)')
    RefreshSQL.Strings = (
      'select w.id, w.id_zav, w.id_nar, w.id_work,'
      'w.kol_work, w.id_diam, w.id_place,'
      'w.id_killclog, w.id_pump, w.id_pes,'
      'w.tz_trudozatrat, w.tz_kol_ed,'
      'w.bworks_id, w.id_raskop'
      'from %s w'
      'left join s_work sw on sw.id = w.id_work'
      'left join s_diam sd on sd.id = w.id_diam'
      'where w.id = :id')
    SelectSQL.Strings = (
      'select w.id, w.id_zav, w.id_nar, w.id_work,'
      'w.kol_work, w.id_diam, w.id_place,'
      'w.id_killclog, w.id_pump, w.id_pes,'
      'w.tz_trudozatrat, w.tz_kol_ed,'
      'w.bworks_id, w.id_raskop'
      'from %s w'
      'left join s_work sw on sw.id = w.id_work'
      'left join s_diam sd on sd.id = w.id_diam'
      'where ( id_zav = :pZavID ) and'
      '( id_nar = :pNarID )'
      'order by w.id')
    ModifySQL.Strings = (
      'update %s set'
      'id_zav = :id_zav,'
      'id_nar = :id_nar,'
      'id_work = :id_work,'
      'kol_work = :kol_work,'
      'id_diam = :id_diam,'
      'id_place = :id_place,'
      'id_killclog = :id_killclog,'
      'id_pump = :id_pump,'
      'id_pes = :id_pes,'
      'tz_trudozatrat = :tz_trudozatrat,  '
      'tz_kol_ed = :tz_kol_ed,'
      'id_raskop =:id_raskop'
      'where id = :id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_WORKS'
    OnFilterRecord = MainFilterRecord
    Left = 136
    Top = 8
    object dset_WorksID: TIntegerField
      FieldName = 'ID'
      Origin = 'WORKS.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_WorksID_ZAV: TIntegerField
      FieldName = 'ID_ZAV'
      Origin = 'WORKS.ID_ZAV'
    end
    object dset_WorksID_NAR: TIntegerField
      FieldName = 'ID_NAR'
      Origin = 'WORKS.ID_NAR'
    end
    object dset_WorksID_WORK: TIntegerField
      FieldName = 'ID_WORK'
      Origin = 'WORKS.ID_WORK'
    end
    object dset_WorksKOL_WORK: TFloatField
      FieldName = 'KOL_WORK'
      Origin = 'WORKS.KOL_WORK'
    end
    object dset_WorksID_DIAM: TIntegerField
      FieldName = 'ID_DIAM'
      Origin = 'WORKS.ID_DIAM'
    end
    object dset_WorksID_PLACE: TIntegerField
      FieldName = 'ID_PLACE'
      Origin = 'WORKS.ID_PLACE'
    end
    object dset_WorksID_KILLCLOG: TIntegerField
      FieldName = 'ID_KILLCLOG'
      Origin = 'WORKS.ID_KILLCLOG'
    end
    object dset_WorksID_PUMP: TIntegerField
      FieldName = 'ID_PUMP'
      Origin = 'WORKS.ID_PUMP'
    end
    object dset_WorksID_PES: TIntegerField
      FieldName = 'ID_PES'
      Origin = 'WORKS.ID_PES'
    end
    object dset_WorksTZ_TRUDOZATRAT: TIBBCDField
      FieldName = 'TZ_TRUDOZATRAT'
      Origin = 'WORKS.TZ_TRUDOZATRAT'
      OnGetText = dset_WorksTZ_KOL_EDGetText
      Precision = 9
      Size = 2
    end
    object dset_WorksTZ_KOL_ED: TIBBCDField
      FieldName = 'TZ_KOL_ED'
      Origin = 'WORKS.TZ_KOL_ED'
      OnGetText = dset_WorksTZ_KOL_EDGetText
      Precision = 9
      Size = 2
    end
    object dset_WorksID_RASKOP: TIntegerField
      FieldName = 'ID_RASKOP'
      Origin = 'WORKS.ID_RASKOP'
    end
    object dset_WorksBWORKS_ID: TIntegerField
      FieldName = 'BWORKS_ID'
      Origin = 'WORKS.BWORKS_ID'
    end
    object dset_WorkslpWORK: TStringField
      FieldKind = fkLookup
      FieldName = 'lpWORK'
      LookupDataSet = dset_S_Work
      LookupKeyFields = 'ID'
      LookupResultField = 'clcFULL_NAME'
      KeyFields = 'ID_WORK'
      Size = 50
      Lookup = True
    end
    object dset_WorkslpPLACE: TStringField
      FieldKind = fkLookup
      FieldName = 'lpPLACE'
      LookupDataSet = dset_S_Place
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_PLACE'
      Lookup = True
    end
    object dset_WorkslpDIAM: TIntegerField
      FieldKind = fkLookup
      FieldName = 'lpDIAM'
      LookupDataSet = dset_S_Diam
      LookupKeyFields = 'ID'
      LookupResultField = 'DIAM'
      KeyFields = 'ID_DIAM'
      OnGetText = dset_WorkslpDIAMGetText
      Lookup = True
    end
    object dset_WorkslpKILLCLOG: TStringField
      FieldKind = fkLookup
      FieldName = 'lpKILLCLOG'
      LookupDataSet = dset_S_KillClog
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_KILLCLOG'
      Lookup = True
    end
    object dset_WorkslpPUMP: TStringField
      FieldKind = fkLookup
      FieldName = 'lpPUMP'
      LookupDataSet = dset_S_Pump
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_PUMP'
      Lookup = True
    end
    object dset_WorkslpPES: TStringField
      FieldKind = fkLookup
      FieldName = 'lpPES'
      LookupDataSet = dset_S_Pes
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_PES'
      Size = 50
      Lookup = True
    end
    object dset_WorksclcTRUDOZATRAT: TStringField
      FieldKind = fkCalculated
      FieldName = 'clcTRUDOZATRAT'
      Size = 50
      Calculated = True
    end
    object dset_WorksclcTOTAL_TZ: TStringField
      FieldKind = fkCalculated
      FieldName = 'clcTOTAL_TZ'
      Size = 10
      Calculated = True
    end
  end
  object dset_S_Work: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    OnCalcFields = dset_S_WorkCalcFields
    SelectSQL.Strings = (
      'select id, name_r, ed_izm, ftype id_place,'
      'id_work_type, del'
      'from s_work'
      'order by name_r')
    OnFilterRecord = SprFilterRecord
    Left = 136
    Top = 80
    object dset_S_WorkID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_WORK.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_S_WorkNAME_R: TIBStringField
      DisplayWidth = 50
      FieldName = 'NAME_R'
      Origin = 'S_WORK.NAME_R'
      FixedChar = True
      Size = 50
    end
    object dset_S_WorkED_IZM: TIBStringField
      FieldName = 'ED_IZM'
      Origin = 'S_WORK.ED_IZM'
      FixedChar = True
      Size = 10
    end
    object dset_S_WorkID_PLACE: TIntegerField
      FieldName = 'ID_PLACE'
      Origin = 'S_WORK.FTYPE'
    end
    object dset_S_WorkID_WORK_TYPE: TIntegerField
      FieldName = 'ID_WORK_TYPE'
      Origin = 'S_WORK.ID_WORK_TYPE'
    end
    object dset_S_WorkDEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_WORK.DEL'
      FixedChar = True
      Size = 1
    end
    object dset_S_WorkclcFULL_NAME: TStringField
      FieldKind = fkCalculated
      FieldName = 'clcFULL_NAME'
      Size = 30
      Calculated = True
    end
  end
  object dset_S_Place: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    SelectSQL.Strings = (
      'select id, name_r, del'
      'from s_place'
      'order by name_r')
    OnFilterRecord = SprFilterRecord
    Left = 136
    Top = 128
    object dset_S_PlaceID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_PLACE.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_S_PlaceNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_PLACE.NAME_R'
      FixedChar = True
    end
    object dset_S_PlaceDEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_PLACE.DEL'
      FixedChar = True
      Size = 1
    end
  end
  object dset_S_Diam: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    SelectSQL.Strings = (
      'select id, diam, del'
      'from s_diam'
      'order by diam')
    OnFilterRecord = SprFilterRecord
    Left = 136
    Top = 176
    object dset_S_DiamID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_DIAM.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_S_DiamDIAM: TIntegerField
      FieldName = 'DIAM'
      Origin = 'S_DIAM.DIAM'
    end
    object dset_S_DiamDEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_DIAM.DEL'
      FixedChar = True
      Size = 1
    end
  end
  object dset_S_KillClog: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    SelectSQL.Strings = (
      'select id, name_r, del'
      'from s_killclog'
      'order by name_r')
    OnFilterRecord = SprFilterRecord
    Left = 136
    Top = 232
    object dset_S_KillClogID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_KILLCLOG.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_S_KillClogNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_KILLCLOG.NAME_R'
      FixedChar = True
      Size = 39
    end
    object dset_S_KillClogDEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_KILLCLOG.DEL'
      FixedChar = True
      Size = 1
    end
  end
  object dset_S_Pump: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    SelectSQL.Strings = (
      'select id, name_r, del'
      'from s_pump'
      'order by id')
    OnFilterRecord = SprFilterRecord
    Left = 136
    Top = 280
    object dset_S_PumpID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_PUMP.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_S_PumpNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_PUMP.NAME_R'
      FixedChar = True
      Size = 100
    end
    object dset_S_PumpDEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_PUMP.DEL'
      FixedChar = True
      Size = 1
    end
  end
  object dset_S_Pes: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    SelectSQL.Strings = (
      'select id, name_r, del'
      'from s_pes'
      'order by name_r')
    OnFilterRecord = SprFilterRecord
    Left = 136
    Top = 328
    object dset_S_PesID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_PES.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_S_PesNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_PES.NAME_R'
      FixedChar = True
      Size = 50
    end
    object dset_S_PesDEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_PES.DEL'
      FixedChar = True
      Size = 1
    end
  end
  object ds_Place: TDataSource
    DataSet = dset_S_Place
    Left = 216
    Top = 80
  end
  object dset_S_WorkDetail: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    OnCalcFields = dset_S_WorkCalcFields
    SelectSQL.Strings = (
      'select id, name_r, ed_izm, ftype id_place, '
      'id_work_type, del'
      'from s_work'
      'where ( ftype = :id ) and ( del = '#39'-'#39' )'
      '%s'
      'order by name_r')
    DataSource = ds_Place
    Left = 304
    Top = 80
    object IntegerField1: TIntegerField
      FieldName = 'ID'
      Origin = 'S_WORK.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object IBStringField1: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_WORK.NAME_R'
      FixedChar = True
      Size = 50
    end
    object IBStringField2: TIBStringField
      FieldName = 'ED_IZM'
      Origin = 'S_WORK.ED_IZM'
      FixedChar = True
      Size = 10
    end
    object IntegerField2: TIntegerField
      FieldName = 'ID_PLACE'
      Origin = 'S_WORK.FTYPE'
    end
    object IBStringField3: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_WORK.DEL'
      FixedChar = True
      Size = 1
    end
    object dset_S_WorkDetailID_WORK_TYPE: TIntegerField
      FieldName = 'ID_WORK_TYPE'
      Origin = 'S_WORK.ID_WORK_TYPE'
    end
    object StringField1: TStringField
      FieldKind = fkCalculated
      FieldName = 'clcFULL_NAME'
      Size = 60
      Calculated = True
    end
  end
  object dset_SearchTZ: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Main
    SelectSQL.Strings = (
      'select tz_summer, tz_winter, kol_ed'
      'from s_trudozatrat'
      'where'
      '(id_work = :pWorkID) and'
      '(id_diam = :pDiamID) and'
      '(id_mesttype = :pMestTypeID)')
    Left = 232
    Top = 8
    object dset_SearchTZTZ_SUMMER: TIBBCDField
      FieldName = 'TZ_SUMMER'
      Origin = 'S_TRUDOZATRAT.TZ_SUMMER'
      Precision = 9
      Size = 2
    end
    object dset_SearchTZTZ_WINTER: TIBBCDField
      FieldName = 'TZ_WINTER'
      Origin = 'S_TRUDOZATRAT.TZ_WINTER'
      Precision = 9
      Size = 2
    end
    object dset_SearchTZKOL_ED: TIBBCDField
      FieldName = 'KOL_ED'
      Origin = 'S_TRUDOZATRAT.KOL_ED'
      Precision = 9
      Size = 2
    end
  end
  object dset_tmp: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Main
    Left = 352
    Top = 248
  end
  object sql_InsertWork: TIBSQL
    Database = DM_main.IBDatabase
    SQL.Strings = (
      'insert into %s('
      '    id_zav,'
      '    id_nar,'
      '    id_work,'
      '    kol_work,'
      '    id_diam,'
      '    id_place,'
      '    tz_trudozatrat,'
      '    tz_kol_ed,'
      '    bworks_id)'
      'values('
      '    :id_zav,'
      '    :id_nar,'
      '    :id_work,'
      '    :kol_work,'
      '    :id_diam,'
      '    :id_place,'
      '    :tz_trudozatrat,'
      '    :tz_kol_ed,'
      '    :bworks_id)')
    Transaction = tran_Main
    Left = 344
    Top = 328
  end
  object IBSQL: TIBSQL
    Database = DM_main.IBDatabase
    Transaction = tran_Main
    Left = 440
    Top = 328
  end
  object dset_GetWorkType: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Main
    SelectSQL.Strings = (
      'select ID_WORK_TYPE'
      'from S_WORK'
      'where ID = :pWorkID')
    Left = 448
    Top = 248
  end
end
