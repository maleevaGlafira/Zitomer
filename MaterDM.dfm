inherited dm_Mater: Tdm_Mater
  Left = 418
  Top = 235
  Height = 432
  Width = 374
  object dset_Mater: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Main
    AfterCancel = dset_MaterAfterCancel
    AfterEdit = dset_MaterAfterEdit
    AfterInsert = dset_MaterAfterInsert
    AfterPost = dset_MaterAfterPost
    DeleteSQL.Strings = (
      'delete from %s where id = :old_id')
    InsertSQL.Strings = (
      'insert into %s('
      'id,'
      'id_zav,'
      'id_nar,'
      'id_mat,'
      'kol_mat,'
      'id_diam)'
      'values('
      ':id,'
      ':id_zav,'
      ':id_nar,'
      ':id_mat,'
      ':kol_mat,'
      ':id_diam)')
    RefreshSQL.Strings = (
      'select m.id, m.id_zav, m.id_nar,'
      'm.id_mat, m.kol_mat, m.id_diam,'
      'm.bworks_id'
      'from %s m'
      'left join s_mat sm on sm.id = m.id_mat'
      'left join s_diam sd on sd.id = m.id_diam'
      'where m.id = :id')
    SelectSQL.Strings = (
      'select m.id, m.id_zav, m.id_nar,'
      'm.id_mat,m.kol_mat, m.id_diam,'
      'm.bworks_id'
      'from %s m'
      'left join s_mat sm on sm.id = m.id_mat'
      'left join s_diam sd on sd.id = m.id_diam'
      'where (m.id_zav = :pZavID) and (m.id_nar = :pNarID)'
      'order by sm.name_r, sd.diam')
    ModifySQL.Strings = (
      'update %s set'
      'id_mat = :id_mat,'
      'kol_mat = :kol_mat,'
      'id_diam = :id_diam'
      'where id = :id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_MATERS'
    OnFilterRecord = MainFilterRecord
    Left = 144
    Top = 16
    object dset_MaterID: TIntegerField
      FieldName = 'ID'
      Origin = 'MATERS.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MaterID_ZAV: TIntegerField
      FieldName = 'ID_ZAV'
      Origin = 'MATERS.ID_ZAV'
    end
    object dset_MaterID_NAR: TIntegerField
      FieldName = 'ID_NAR'
      Origin = 'MATERS.ID_NAR'
    end
    object dset_MaterID_MAT: TIntegerField
      FieldName = 'ID_MAT'
      Origin = 'MATERS.ID_MAT'
    end
    object dset_MaterKOL_MAT: TFloatField
      FieldName = 'KOL_MAT'
      Origin = 'MATERS.KOL_MAT'
    end
    object dset_MaterID_DIAM: TIntegerField
      FieldName = 'ID_DIAM'
      Origin = 'MATERS.ID_DIAM'
    end
    object dset_MaterBWORKS_ID: TIntegerField
      FieldName = 'BWORKS_ID'
      Origin = 'MATERS.BWORKS_ID'
    end
    object dset_Materlp_Mat: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_Mat'
      LookupDataSet = dset_S_Mat
      LookupKeyFields = 'ID'
      LookupResultField = 'clc_FullName'
      KeyFields = 'ID_MAT'
      Lookup = True
    end
    object dset_Materlp_Diam: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_Diam'
      LookupDataSet = dset_S_Diam
      LookupKeyFields = 'ID'
      LookupResultField = 'clc_Diam'
      KeyFields = 'ID_DIAM'
      Lookup = True
    end
  end
  object dset_S_Mat: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    OnCalcFields = dset_S_MatCalcFields
    SelectSQL.Strings = (
      'select id, name_r, ed_izm, del'
      'from s_mat'
      'order by name_r, ed_izm')
    OnFilterRecord = SprFilterRecord
    Left = 144
    Top = 88
    object dset_S_MatID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_MAT.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_S_MatNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_MAT.NAME_R'
      FixedChar = True
    end
    object dset_S_MatED_IZM: TIBStringField
      FieldName = 'ED_IZM'
      Origin = 'S_MAT.ED_IZM'
      FixedChar = True
      Size = 10
    end
    object dset_S_MatDEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_MAT.DEL'
      FixedChar = True
      Size = 1
    end
    object dset_S_Matclc_FullName: TStringField
      FieldKind = fkCalculated
      FieldName = 'clc_FullName'
      Size = 30
      Calculated = True
    end
  end
  object dset_S_Diam: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    OnCalcFields = dset_S_DiamCalcFields
    SelectSQL.Strings = (
      'select id, diam, del'
      'from s_diam'
      'order by diam')
    OnFilterRecord = SprFilterRecord
    Left = 144
    Top = 152
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
    object dset_S_Diamclc_Diam: TStringField
      FieldKind = fkCalculated
      FieldName = 'clc_Diam'
      Size = 10
      Calculated = True
    end
  end
  object dset_tmp: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Main
    Left = 40
    Top = 256
  end
  object sql_InsertMater: TIBSQL
    Database = DM_main.IBDatabase
    SQL.Strings = (
      'insert into %s('
      'id_zav,'
      'id_nar,'
      'id_mat,'
      'kol_mat,'
      'id_diam,'
      'bworks_id)'
      'values('
      ':id_zav,'
      ':id_nar,'
      ':id_mat,'
      ':kol_mat,'
      ':id_diam,'
      ':bworks_id)')
    Transaction = tran_Main
    Left = 136
    Top = 272
  end
  object IBSQL: TIBSQL
    Database = DM_main.IBDatabase
    Transaction = tran_Main
    Left = 272
    Top = 264
  end
end
