object dm_NGRaskop: Tdm_NGRaskop
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 452
  Top = 138
  Height = 653
  Width = 480
  object tran_Raskop: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 32
    Top = 8
  end
  object dset_Raskop: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Raskop
    ForcedRefresh = True
    AfterCancel = dset_RaskopAfterCancel
    AfterDelete = dset_RaskopAfterDelete
    AfterEdit = dset_RaskopAfterEdit
    AfterInsert = dset_RaskopAfterInsert
    AfterOpen = dset_RaskopAfterOpen
    AfterPost = dset_RaskopAfterPost
    AfterScroll = dset_RaskopAfterScroll
    BeforeDelete = dset_RaskopBeforeDelete
    BeforeInsert = dset_RaskopBeforeInsert
    BeforePost = dset_RaskopBeforePost
    OnCalcFields = dset_RaskopCalcFields
    DeleteSQL.Strings = (
      'delete from RASKOP where ID = :OLD_ID')
    InsertSQL.Strings = (
      'insert into RASKOP('
      '    ID_ZAVIN,'
      '    ID_ZAVOUT,'
      '    ID_UL1,'
      '    ID_UL2,'
      '    UL_KOD,'
      '    DOP_ADR,'
      '    ID_DOPADRES,'
      '    PEREDANO,'
      '    DT_ACT,'
      '    ID_BRACT,'
      '    NEEDWORKS, '
      '    ID_MEST,'
      '    ID_BRBLAG,'
      '    R_LEN,'
      '    R_WID,'
      '    R_DEP,'
      '    R_OGRAGD,'
      '    planDateExcav, '
      '    dateOrg,  '
      '   dateClosedDocument,'
      '   ID_BALANCEKEPPER,'
      '   ID_ORGROAD,'
      '   NUMBERROAD,'
      '   NUMBERCHEB,  '
      '   DT_CHEB, '
      '  DT_DOWNASFALT,  '
      '  DT_UPASFALT,'
      '  dt_plan_sand'
      ')'
      'values('
      '    :ID_ZAVIN,'
      '    :ID_ZAVOUT,'
      '    :ID_UL1,'
      '    :ID_UL2,'
      '    :UL_KOD,'
      '    :DOP_ADR,'
      '    :ID_DOPADRES,'
      '    :PEREDANO,'
      '    :DT_ACT,'
      '    :ID_BRACT,'
      '    :NEEDWORKS,'
      '    :ID_MEST,'
      '    :ID_BRBLAG,'
      '    :R_LEN,'
      '    :R_WID,'
      '    :R_DEP,'
      '    :R_OGRAGD,'
      '    :planDateExcav, '
      '    :dateOrg,  '
      '   :dateClosedDocument,'
      '   :ID_BALANCEKEPPER,'
      '   :ID_ORGROAD,'
      '   :NUMBERROAD,'
      '   :NUMBERCHEB,  '
      '   :DT_CHEB, '
      '  :DT_DOWNASFALT,  '
      '  :DT_UPASFALT,'
      '  :dt_plan_sand'
      ''
      ')'
      ''
      ''
      ''
      '')
    RefreshSQL.Strings = (
      'select'
      '    r.ID,'
      '    r.ID_ZAVIN,'
      '    r.ID_ZAVOUT,'
      '    r.ID_UL1,'
      '    r.ID_UL2,'
      '    r.UL_KOD,'
      '    r.DOP_ADR,'
      '    r.ID_DOPADRES,'
      '    r.PEREDANO,'
      '    r.DT_ACT,'
      '    r.ID_BRACT,'
      '    r.NEEDWORKS,'
      '    r.ID_MEST,'
      '    ( select adres from'
      '    get_adres(r.id_ul1, r.id_ul2,'
      '    r.ul_kod, r.dop_adr, r.id_dopadres ) ) ADRES,'
      '    sm.NAME_R as MEST,  r.ID_BRBLAG,'
      '    r.R_LEN, r.R_WID, r.R_DEP, r.R_OGRAGD,'
      '   r.planDateExcav, r.dateOrg, r.dateClosedDocument,'
      '   r.ID_BALANCEKEPPER, r.ID_ORGROAD, r.NUMBERROAD,'
      '  r.NUMBERCHEB,  r.DT_CHEB, '
      ' r.DT_DOWNASFALT,  r.DT_UPASFALT,r. dt_plan_sand'
      'from RASKOP r'
      'left join S_MEST sm on sm.ID = r.ID_MEST'
      'where r.ID_ZAVIN = :pZavID'
      'order by r.ID')
    SelectSQL.Strings = (
      'select'
      '    r.ID,'
      '    r.ID_ZAVIN,'
      '    r.ID_ZAVOUT,'
      '    r.ID_UL1,'
      '    r.ID_UL2,'
      '    r.UL_KOD,'
      '    r.DOP_ADR,'
      '    r.ID_DOPADRES,'
      '    r.PEREDANO,'
      '    r.DT_ACT,'
      '    r.ID_BRACT,'
      '    r.NEEDWORKS,'
      '    r.ID_MEST,'
      '    ( select adres from'
      '    get_adres(r.id_ul1, r.id_ul2,'
      '    r.ul_kod, r.dop_adr, r.id_dopadres ) ) ADRES,'
      '    sm.NAME_R as MEST,  r.ID_BRBLAG,'
      '    r.R_LEN, r.R_WID, r.R_DEP, r.R_OGRAGD,'
      '   r.planDateExcav, r.dateOrg, r.dateClosedDocument,'
      '   r.ID_BALANCEKEPPER, r.ID_ORGROAD, r.NUMBERROAD,'
      '  r.NUMBERCHEB,  r.DT_CHEB, '
      ' r.DT_DOWNASFALT,  r.DT_UPASFALT, r.dt_plan_sand'
      'from RASKOP r'
      'left join S_MEST sm on sm.ID = r.ID_MEST'
      'where r.ID_ZAVIN = :pZavID'
      'order by r.ID')
    ModifySQL.Strings = (
      'update RASKOP set'
      '    ID_ZAVIN = :ID_ZAVIN,'
      '    ID_ZAVOUT = :ID_ZAVOUT,'
      '    ID_UL1 = :ID_UL1,'
      '    ID_UL2 = :ID_UL2,'
      '    UL_KOD = :UL_KOD,'
      '    DOP_ADR = :DOP_ADR,'
      '    ID_DOPADRES = :ID_DOPADRES,'
      '    PEREDANO = :PEREDANO,'
      '    DT_ACT = :DT_ACT,'
      '    ID_BRACT = :ID_BRACT,'
      '    NEEDWORKS = :NEEDWORKS,'
      '    ID_MEST = :ID_MEST,'
      '    ID_BRBLAG =:ID_BRBLAG,'
      '    R_LEN =:R_LEN,'
      '    R_WID =:R_WID,'
      '    R_DEP =:R_DEP,'
      '    R_OGRAGD =:R_OGRAGD,'
      '    planDateExcav = :planDateExcav,'
      '   dateOrg =:dateOrg,'
      '   dateClosedDocument =:dateClosedDocument,'
      '    ID_BALANCEKEPPER = :ID_BALANCEKEPPER,'
      '   ID_ORGROAD =:ID_ORGROAD,'
      '   NUMBERROAD =:NUMBERROAD,'
      '   NUMBERCHEB = :NUMBERCHEB ,  '
      '   DT_CHEB =:DT_CHEB, '
      '  DT_DOWNASFALT =:DT_DOWNASFALT,  '
      '  DT_UPASFALT =:DT_UPASFALT,'
      '  dt_plan_sand=:dt_plan_sand'
      'where ID = :ID'
      '')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_RASKOP'
    GeneratorField.ApplyEvent = gamOnServer
    OnFilterRecord = dset_RaskopFilterRecord
    Left = 32
    Top = 80
    object dset_RaskopID: TIntegerField
      FieldName = 'ID'
      Origin = 'RASKOP.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_RaskopID_ZAVIN: TIntegerField
      FieldName = 'ID_ZAVIN'
      Origin = 'RASKOP.ID_ZAVIN'
    end
    object dset_RaskopID_ZAVOUT: TIntegerField
      FieldName = 'ID_ZAVOUT'
      Origin = 'RASKOP.ID_ZAVOUT'
    end
    object dset_RaskopID_UL1: TIntegerField
      FieldName = 'ID_UL1'
      Origin = 'RASKOP.ID_UL1'
    end
    object dset_RaskopID_UL2: TIBStringField
      FieldName = 'ID_UL2'
      Origin = 'RASKOP.ID_UL2'
      OnGetText = dset_RaskopID_UL2GetText
      FixedChar = True
      Size = 10
    end
    object dset_RaskopUL_KOD: TIntegerField
      FieldName = 'UL_KOD'
      Origin = 'RASKOP.UL_KOD'
    end
    object dset_RaskopDOP_ADR: TIBStringField
      FieldName = 'DOP_ADR'
      Origin = 'RASKOP.DOP_ADR'
      OnGetText = dset_RaskopID_UL2GetText
      FixedChar = True
    end
    object dset_RaskopID_DOPADRES: TIntegerField
      FieldName = 'ID_DOPADRES'
      Origin = 'RASKOP.ID_DOPADRES'
    end
    object dset_RaskopPEREDANO: TIBStringField
      FieldName = 'PEREDANO'
      Origin = 'RASKOP.PEREDANO'
      OnGetText = dset_RaskopID_UL2GetText
      FixedChar = True
    end
    object dset_RaskopDT_ACT: TDateTimeField
      FieldName = 'DT_ACT'
      Origin = 'RASKOP.DT_ACT'
    end
    object dset_RaskopID_BRACT: TIntegerField
      FieldName = 'ID_BRACT'
      Origin = 'RASKOP.ID_BRACT'
    end
    object dset_RaskopNEEDWORKS: TIBStringField
      FieldName = 'NEEDWORKS'
      Origin = 'RASKOP.NEEDWORKS'
      OnGetText = dset_RaskopID_UL2GetText
      Size = 150
    end
    object dset_RaskopID_MEST: TIntegerField
      FieldName = 'ID_MEST'
      Origin = 'RASKOP.ID_MEST'
    end
    object dset_RaskopADRES: TIBStringField
      FieldName = 'ADRES'
      ProviderFlags = []
      Size = 150
    end
    object dset_RaskopMEST: TIBStringField
      FieldName = 'MEST'
      Origin = 'S_MEST.NAME_R'
      FixedChar = True
      Size = 40
    end
    object dset_Raskopclc_RASKOP_INFO: TStringField
      FieldKind = fkCalculated
      FieldName = 'clc_RASKOP_INFO'
      Size = 200
      Calculated = True
    end
    object dset_RaskopID_BRBLAG: TIntegerField
      FieldName = 'ID_BRBLAG'
      Origin = 'RASKOP.ID_BRBLAG'
    end
    object dset_RaskopR_LEN: TIBBCDField
      FieldName = 'R_LEN'
      Origin = 'RASKOP.R_LEN'
      Precision = 4
      Size = 1
    end
    object dset_RaskopR_WID: TIBBCDField
      FieldName = 'R_WID'
      Origin = 'RASKOP.R_WID'
      Precision = 4
      Size = 1
    end
    object dset_RaskopR_DEP: TIBBCDField
      FieldName = 'R_DEP'
      Origin = 'RASKOP.R_DEP'
      Precision = 4
      Size = 1
    end
    object dset_RaskopR_OGRAGD: TIBStringField
      FieldName = 'R_OGRAGD'
      Origin = 'RASKOP.R_OGRAGD'
      Size = 60
    end
    object dset_RaskopPLANDATEEXCAV: TDateTimeField
      FieldName = 'PLANDATEEXCAV'
      Origin = 'RASKOP.PLANDATEEXCAV'
    end
    object dset_RaskopDATEORG: TDateTimeField
      FieldName = 'DATEORG'
      Origin = 'RASKOP.DATEORG'
    end
    object dset_RaskopDATECLOSEDDOCUMENT: TDateTimeField
      FieldName = 'DATECLOSEDDOCUMENT'
      Origin = 'RASKOP.DATECLOSEDDOCUMENT'
    end
    object dset_RaskopID_BALANCEKEPPER: TIntegerField
      FieldName = 'ID_BALANCEKEPPER'
      Origin = 'RASKOP.ID_BALANCEKEPPER'
    end
    object dset_RaskopID_ORGROAD: TIntegerField
      FieldName = 'ID_ORGROAD'
      Origin = 'RASKOP.ID_ORGROAD'
    end
    object dset_RaskopNUMBERROAD: TIBStringField
      FieldName = 'NUMBERROAD'
      Origin = 'RASKOP.NUMBERROAD'
      Size = 10
    end
    object dset_RaskopNUMBERCHEB: TIBStringField
      FieldName = 'NUMBERCHEB'
      Origin = 'RASKOP.NUMBERCHEB'
      Size = 10
    end
    object dset_RaskopDT_CHEB: TDateTimeField
      FieldName = 'DT_CHEB'
      Origin = 'RASKOP.DT_CHEB'
    end
    object dset_RaskopDT_DOWNASFALT: TDateTimeField
      FieldName = 'DT_DOWNASFALT'
      Origin = 'RASKOP.DT_DOWNASFALT'
    end
    object dset_RaskopDT_UPASFALT: TDateTimeField
      FieldName = 'DT_UPASFALT'
      Origin = 'RASKOP.DT_UPASFALT'
    end
    object dset_RaskopDT_PLAN_SAND: TDateTimeField
      FieldName = 'DT_PLAN_SAND'
      Origin = 'RASKOP.DT_PLAN_SAND'
    end
  end
  object dset_S_Ulic1: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    SelectSQL.Strings = (
      'select u.id id,'
      
        'rtrim( u.name_r )||'#39' '#39'||rtrim( v.name_r ) as name_r, u.del, id_r' +
        'ayon'
      'from s_ulic u,s_vidul v'
      'where( u.id_vidul > -2) and ( u.id_vidul = v.id )'
      'order by 2')
    OnFilterRecord = SprFilterRecord
    Left = 328
    Top = 24
    object dset_S_Ulic1ID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_ULIC.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_S_Ulic1NAME_R: TIBStringField
      FieldName = 'NAME_R'
      ProviderFlags = []
      Size = 161
    end
    object dset_S_Ulic1DEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_ULIC.DEL'
      FixedChar = True
      Size = 1
    end
  end
  object dset_S_Ulic2: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    SelectSQL.Strings = (
      'select u.id id,'
      
        'rtrim( u.name_r )||'#39' '#39'||rtrim( v.name_r ) as name_r, u.del, id_r' +
        'ayon'
      'from s_ulic u,s_vidul v'
      'where( u.id_vidul > -2) and ( u.id_vidul = v.id )'
      'order by 2')
    OnFilterRecord = SprFilterRecord
    Left = 320
    Top = 96
    object dset_S_Ulic2ID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_ULIC.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_S_Ulic2NAME_R: TIBStringField
      FieldName = 'NAME_R'
      ProviderFlags = []
      Size = 161
    end
    object dset_S_Ulic2DEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_ULIC.DEL'
      FixedChar = True
      Size = 1
    end
  end
  object dset_tadr: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    SelectSQL.Strings = (
      'select ID, NAME_R'
      'from TADR')
    Left = 328
    Top = 176
    object dset_tadrID: TIntegerField
      FieldName = 'ID'
      Origin = 'TADR.ID'
    end
    object dset_tadrNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'TADR.NAME_R'
      FixedChar = True
    end
  end
  object tran_Spr: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 248
    Top = 16
  end
  object dset_S_DopAdres: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    SelectSQL.Strings = (
      'select ID, NAME_R, DEL'
      'from S_DOPADRES'
      'order by NAME_R')
    OnFilterRecord = SprFilterRecord
    Left = 328
    Top = 240
    object dset_S_DopAdresID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_DOPADRES.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_S_DopAdresNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_DOPADRES.NAME_R'
      FixedChar = True
      Size = 50
    end
    object dset_S_DopAdresDEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_DOPADRES.DEL'
      FixedChar = True
      Size = 1
    end
  end
  object dset_S_Brig_Act: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    SelectSQL.Strings = (
      'select id, rtrim(name_r)||"  ["||rtrim(dolgn)||"]" name_r, del'
      'from s_brig'
      'order by name_r')
    OnFilterRecord = SprFilterRecord
    Left = 328
    Top = 304
    object dset_S_Brig_ActID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_BRIG.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_S_Brig_ActNAME_R: TIBStringField
      FieldName = 'NAME_R'
      ProviderFlags = []
      Size = 164
    end
    object dset_S_Brig_ActDEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_BRIG.DEL'
      FixedChar = True
      Size = 1
    end
  end
  object dset_GetMaxRaskopID: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Raskop
    SelectSQL.Strings = (
      'select max(ID) MAX_ID'
      'from RASKOP'
      'where ID_ZAVIN = :pZavID')
    Left = 48
    Top = 176
  end
  object sql_tmp: TIBSQL
    Database = DM_main.IBDatabase
    Transaction = tran_tmp
    Left = 56
    Top = 288
  end
  object tran_tmp: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 136
    Top = 280
  end
  object dset_S_Mest: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    SelectSQL.Strings = (
      'select id, name_r, del'
      'from s_mest'
      'order by name_r')
    OnFilterRecord = SprFilterRecord
    Left = 328
    Top = 392
    object dset_S_MestID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_MEST.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_S_MestNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_MEST.NAME_R'
      FixedChar = True
      Size = 40
    end
    object dset_S_MestDEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_MEST.DEL'
      FixedChar = True
      Size = 1
    end
  end
  object dset_S_Ogragd: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    SelectSQL.Strings = (
      'select id, rtrim(name_r) name_r, del'
      'from s_ogragd'
      'order by name_r')
    OnFilterRecord = SprFilterRecord
    Left = 328
    Top = 448
    object IntegerField1: TIntegerField
      FieldName = 'ID'
      Origin = 'S_BRIG.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object IBStringField1: TIBStringField
      FieldName = 'NAME_R'
      ProviderFlags = []
      Size = 164
    end
    object IBStringField2: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_BRIG.DEL'
      FixedChar = True
      Size = 1
    end
  end
  object dset_s_orgRoad: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    SelectSQL.Strings = (
      'select id, name, del from s_orgroad s order by name')
    Left = 328
    Top = 520
    object dset_s_orgRoadID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_ORGROAD.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_s_orgRoadNAME: TIBStringField
      FieldName = 'NAME'
      Origin = 'S_ORGROAD.NAME'
      Size = 50
    end
    object dset_s_orgRoadDEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_ORGROAD.DEL'
      FixedChar = True
      Size = 1
    end
  end
  object dset_s_balancekeeper: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    SelectSQL.Strings = (
      'select id, name, del from s_balancekeeper ss order by name')
    Left = 200
    Top = 520
    object dset_s_balancekeeperID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_BALANCEKEEPER.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_s_balancekeeperNAME: TIBStringField
      FieldName = 'NAME'
      Origin = 'S_BALANCEKEEPER.NAME'
      Size = 50
    end
    object dset_s_balancekeeperDEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_BALANCEKEEPER.DEL'
      FixedChar = True
      Size = 1
    end
  end
  object dset_id_rayon: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Raskop
    Left = 72
    Top = 432
  end
end
