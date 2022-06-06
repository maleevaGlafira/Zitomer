inherited dm_BWork: Tdm_BWork
  OldCreateOrder = True
  object dset_BWork: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Main
    AfterCancel = dset_BWorkAfterCancel
    AfterEdit = dset_BWorkAfterEdit
    AfterInsert = dset_BWorkAfterInsert
    AfterPost = dset_BWorkAfterPost
    AfterScroll = dset_BWorkAfterScroll
    DeleteSQL.Strings = (
      'delete from %s where id=:old_id')
    InsertSQL.Strings = (
      'insert into %s('
      '    id,'
      '    id_zav,'
      '    id_nar,'
      '    id_bwork )'
      'values('
      '    :id,'
      '    :id_zav,'
      '    :id_nar,'
      '    :id_bwork )')
    RefreshSQL.Strings = (
      'select bw.id, bw.id_zav, bw.id_nar, bw.id_bwork'
      'from %s bw'
      'left join s_bwork sbw on sbw.id = bw.id_bwork'
      'where bw.id = :id')
    SelectSQL.Strings = (
      'select bw.id, bw.id_zav, bw.id_nar, bw.id_bwork'
      'from %s bw'
      'left join s_bwork sbw on sbw.id = bw.id_bwork'
      'where ( bw.id_zav = :pZavID ) and'
      '( bw.id_nar = :pNarID )'
      'order by sbw.name_r')
    ModifySQL.Strings = (
      'update %s set'
      '    id_bwork = :id_bwork'
      'where id = :id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_BWORKS_ID'
    Left = 128
    Top = 16
    object dset_BWorkID: TIntegerField
      FieldName = 'ID'
      Origin = 'BWORKS.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_BWorkID_ZAV: TIntegerField
      FieldName = 'ID_ZAV'
      Origin = 'BWORKS.ID_ZAV'
    end
    object dset_BWorkID_NAR: TIntegerField
      FieldName = 'ID_NAR'
      Origin = 'BWORKS.ID_NAR'
    end
    object dset_BWorkID_BWORK: TIntegerField
      FieldName = 'ID_BWORK'
      Origin = 'BWORKS.ID_BWORK'
    end
    object dset_BWorklp_BWork: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_BWork'
      LookupDataSet = dset_S_BWork
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_BWORK'
      Lookup = True
    end
  end
  object dset_S_BWork: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    SelectSQL.Strings = (
      'select id, name_r, del'
      'from s_bwork'
      'order by name_r')
    Left = 128
    Top = 96
    object dset_S_BWorkID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_BWORK.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_S_BWorkNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_BWORK.NAME_R'
      Size = 40
    end
    object dset_S_BWorkDEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_BWORK.DEL'
      FixedChar = True
      Size = 1
    end
  end
end
