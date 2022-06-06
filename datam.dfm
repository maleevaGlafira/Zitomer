object DM1: TDM1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 139
  Top = 53
  Height = 726
  Width = 1209
  object S_Diam_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT d.id, d.diam, cast(diam as char(5)) as diam_str, d.del'
      'FROM s_diam d'
      'WHERE d.del in ('#39'-'#39','#39'd'#39')  and d.id > 0'
      'ORDER BY d.diam')
    UpdateObject = S_Diam_upd
    Left = 200
    Top = 104
  end
  object S_Diam_sur: TDataSource
    DataSet = S_Diam_q
    Left = 208
    Top = 120
  end
  object Db_Avar: TDatabase
    AliasName = 'AVARZHYTOMYR'
    DatabaseName = 'DBN_AVAR'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=SYSDBA'
      'PASSWORD=masterkey'
      'LANGDRIVER=Pdox ANSI Cyrillic'
      'defaultHoldable=true')
    SessionName = 'Default'
    AfterConnect = Db_AvarAfterConnect
    Left = 8
    Top = 17
  end
  object S_Brig_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    SQL.Strings = (
      'SELECT br.id, br.Name_r, br.dolgn, br.uid, br.prava, br.del'
      'FROM s_brig br'
      'WHERE br.id > 0'
      'ORDER BY br.Name_r, br.dolgn')
    UpdateObject = S_Brig_upd
    Left = 72
    Top = 8
  end
  object S_Brig_sur: TDataSource
    DataSet = S_Brig_q
    Left = 80
    Top = 24
  end
  object tempQr_q: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 24
    Top = 65
  end
  object S_Alien_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_alien s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    UpdateObject = S_Alien_upd
    Left = 136
    Top = 8
  end
  object S_Alien_sur: TDataSource
    DataSet = S_Alien_q
    Left = 144
    Top = 24
  end
  object S_Damg_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del, s.place_type, pl.name_r as place'
      'FROM s_damg s LEFT JOIN s_place pl'
      '            ON (s.place_type = pl.id)'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r,pl.name_r')
    UpdateObject = S_Damg_upd
    Left = 200
    Top = 8
    object S_Damg_qID: TIntegerField
      FieldName = 'ID'
    end
    object S_Damg_qNAME_R: TStringField
      DisplayWidth = 40
      FieldName = 'NAME_R'
      FixedChar = True
      Size = 40
    end
    object S_Damg_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object S_Damg_qPLACE_TYPE: TIntegerField
      FieldName = 'PLACE_TYPE'
    end
    object S_Damg_qPLACE: TStringField
      FieldName = 'PLACE'
      FixedChar = True
    end
    object S_Damg_qlist_PLACE: TStringField
      FieldKind = fkLookup
      FieldName = 'list_PLACE'
      LookupDataSet = S_Place_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'PLACE_TYPE'
      Size = 30
      Lookup = True
    end
  end
  object S_Damg_sur: TDataSource
    DataSet = S_Damg_q
    Left = 216
    Top = 24
  end
  object S_Brig_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_Brig'
      'SET name_r = :name_r,'
      '       dolgn = :dolgn,'
      '       prava = :prava,'
      '       del = :del'
      'WHERE id = :id'
      '')
    InsertSQL.Strings = (
      'INSERT INTO S_Brig (name_r, dolgn, uid, prava)'
      'VALUES (:name_r, :dolgn, :uid, :prava)'
      '')
    DeleteSQL.Strings = (
      'DELETE FROM S_Brig'
      'WHERE id = :OLD_ID'
      '')
    Left = 88
    Top = 40
  end
  object S_Alien_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_Alien'
      'SET name_r = :name_r, del = :del'
      'WHERE id = :id'
      ''
      '')
    InsertSQL.Strings = (
      'INSERT INTO S_Alien (name_r)'
      'VALUES (:name_r)'
      ''
      '')
    DeleteSQL.Strings = (
      'DELETE FROM S_Alien'
      'WHERE id = :OLD_ID'
      ''
      '')
    Left = 152
    Top = 40
  end
  object S_Damg_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_Damg'
      'SET name_r = :name_r, del = :del, place_type=:place_type'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_Damg (name_r,place_type)'
      'VALUES (:name_r,:place_type)')
    DeleteSQL.Strings = (
      'DELETE FROM S_Damg'
      'WHERE id = :OLD_ID')
    Left = 224
    Top = 40
  end
  object S_Sod_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT sod.id, sod.Name_r, sod.ftype, sod.Sah,'
      '              sah.Name_r, sod.diampresent, tz.name_r, sod.del,'
      
        '              sz.id as sz_id, place_type, sod.zayavl, sod.ID_OBO' +
        'RTYPEGLOB'
      'FROM s_sod sod LEFT JOIN s_sah sah'
      
        '    ON (sod.sah = sah.id) left join s_tzav tz on (sod.ftype=tz.i' +
        'd)'
      '  LEFT JOIN s_zayavl sz'
      '  ON (sz.id=sod.zayavl)'
      '  LEFT JOIN s_place sp'
      '  ON (sp.id=place_type)'
      'WHERE sod.id > 0'
      'ORDER BY sod.Name_r, sah.Name_r')
    UpdateObject = S_Sod_upd
    Left = 264
    Top = 8
    object S_Sod_qID: TIntegerField
      FieldName = 'ID'
    end
    object S_Sod_qNAME_R: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
      Size = 40
    end
    object S_Sod_qTYPE: TIntegerField
      FieldName = 'FTYPE'
    end
    object S_Sod_qSAH: TIntegerField
      FieldName = 'SAH'
    end
    object S_Sod_qNAME_R_1: TStringField
      FieldName = 'NAME_R_1'
      FixedChar = True
    end
    object S_Sod_qList_SAH: TStringField
      FieldKind = fkLookup
      FieldName = 'List_SAH'
      LookupDataSet = S_Sah_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'SAH'
      Size = 30
      Lookup = True
    end
    object S_Sod_qDIAMPRESENT: TIntegerField
      FieldName = 'DIAMPRESENT'
    end
    object S_Sod_qListDIAMPRESENT: TStringField
      FieldKind = fkLookup
      FieldName = 'ListDIAMPRESENT'
      LookupDataSet = TBL_const_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'DIAMPRESENT'
      Lookup = True
    end
    object S_Sod_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object S_Sod_qlistTYPE: TStringField
      FieldKind = fkLookup
      FieldName = 'listTYPE'
      LookupDataSet = S_Fulltzav_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'FTYPE'
      Lookup = True
    end
    object S_Sod_qSZ_ID: TIntegerField
      FieldName = 'SZ_ID'
    end
    object S_Sod_qlistZAYAVL: TStringField
      FieldKind = fkLookup
      FieldName = 'listZAYAVL'
      LookupDataSet = qry_ObjAtt12
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ZAYAVL'
      Size = 15
      Lookup = True
    end
    object S_Sod_qPLACE_TYPE: TIntegerField
      FieldName = 'PLACE_TYPE'
    end
    object S_Sod_qlistPLACE: TStringField
      FieldKind = fkLookup
      FieldName = 'listPLACE'
      LookupDataSet = S_Place_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'PLACE_TYPE'
      Lookup = True
    end
    object S_Sod_qZAYAVL: TIntegerField
      FieldName = 'ZAYAVL'
      Visible = False
    end
    object S_Sod_qID_OBORTYPE: TIntegerField
      FieldName = 'ID_OBORTYPEGLOB'
    end
    object S_Sod_qlook_obortype: TStringField
      FieldKind = fkLookup
      FieldName = 'look_obortypeglob'
      LookupDataSet = s_obortypeglob_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_OBORTYPEGLOB'
      Size = 25
      Lookup = True
    end
  end
  object S_Sod_sur: TDataSource
    DataSet = S_Sod_q
    Left = 272
    Top = 24
  end
  object S_Sod_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_Sod'
      'SET ftype = :ftype,'
      '        name_r = :name_r,'
      '        sah = :sah,'
      '        diampresent = :diampresent,'
      '        del = :del,'
      '        place_type=:place_type,'
      '        zayavl=:zayavl,'
      '        id_obortypeglob=:id_obortypeglob'
      'WHERE id = :id')
    InsertSQL.Strings = (
      
        'INSERT INTO S_Sod (ftype, name_r, sah, diampresent,place_type,za' +
        'yavl,id_obortypeglob)'
      
        'VALUES (:ftype, :name_r, :sah, :diampresent,:place_type,:zayavl,' +
        ':id_obortypeglob)')
    DeleteSQL.Strings = (
      'DELETE FROM S_Sod'
      'WHERE id = :OLD_ID')
    Left = 288
    Top = 40
  end
  object S_Sah_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_sah s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    UpdateObject = S_Sah_upd
    Left = 336
    Top = 8
  end
  object S_Sah_sur: TDataSource
    DataSet = S_Sah_q
    Left = 344
    Top = 24
  end
  object S_Sah_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_Sah'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_Sah (name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_Sah'
      'WHERE id = :OLD_ID')
    Left = 352
    Top = 40
  end
  object S_Revs_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_revs s'
      'WHERE s.id > 0'
      ' and del='#39'-'#39
      'ORDER BY s.Name_r')
    UpdateObject = S_Revs_upd
    Left = 408
    Top = 8
  end
  object S_Revs_sur: TDataSource
    DataSet = S_Revs_q
    Left = 416
    Top = 24
  end
  object S_Revs_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_Revs'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_Revs (name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_Revs'
      'WHERE id = :OLD_ID')
    Left = 424
    Top = 40
  end
  object S_Work_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      
        'SELECT wk.id, wk.Name_r, wk.ed_izm, wk.ftype, pl.name_r as place' +
        ', wk.del,'
      'rtrim(wk.name_r)||'#39' ['#39'||rtrim(pl.name_r)||'#39']'#39' as full_name,'
      'id_work_type, wk.id_obortype'
      'FROM s_work wk LEFT JOIN s_place pl'
      '            ON (wk.ftype = pl.id)'
      'WHERE wk.del in ('#39'-'#39','#39'd'#39') and wk.id > 0'
      'ORDER BY wk.Name_r, pl.name_r')
    UpdateObject = S_Work_upd
    Left = 464
    Top = 8
    object S_Work_qID: TIntegerField
      FieldName = 'ID'
    end
    object S_Work_qNAME_R: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
      Size = 50
    end
    object S_Work_qED_IZM: TStringField
      FieldName = 'ED_IZM'
      FixedChar = True
      Size = 10
    end
    object S_Work_qTYPE: TIntegerField
      FieldName = 'FTYPE'
    end
    object S_Work_qPLACE: TStringField
      FieldName = 'PLACE'
      FixedChar = True
    end
    object S_Work_qList_Place: TStringField
      FieldKind = fkLookup
      FieldName = 'List_Place'
      LookupDataSet = S_Place_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'FTYPE'
      Size = 30
      Lookup = True
    end
    object S_Work_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object S_Work_qFULL_NAME: TStringField
      DisplayWidth = 193
      FieldName = 'FULL_NAME'
      Size = 193
    end
    object S_Work_qID_WORK_TYPE: TIntegerField
      FieldName = 'ID_WORK_TYPE'
    end
    object S_Work_qlist_WORK_TYPE: TStringField
      FieldKind = fkLookup
      FieldName = 'list_WORK_TYPE'
      LookupDataSet = s_work_type_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_WORK_TYPE'
      Size = 40
      Lookup = True
    end
    object S_Work_qID_OBORTYPE: TIntegerField
      FieldName = 'ID_OBORTYPE'
    end
    object S_Work_qlook_obortypeglob: TStringField
      FieldKind = fkLookup
      FieldName = 'look_obortypeglob'
      LookupDataSet = s_obortypeglob_look
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_OBORTYPE'
      Size = 30
      Lookup = True
    end
  end
  object S_Work_sur: TDataSource
    DataSet = S_Work_q
    Left = 480
    Top = 16
  end
  object S_Work_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_Work'
      'SET  name_r = :name_r,'
      '         ed_izm = :ed_izm,'
      '         ftype = :ftype, '
      '         id_work_type = :id_work_type,'
      '         id_obortype=:id_obortype,'
      '         del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      
        'INSERT INTO S_Work (name_r, ed_izm, ftype, id_work_type, id_obor' +
        'type)'
      'VALUES (:name_r, :ed_izm, :ftype, :id_work_type,:id_obortype)')
    DeleteSQL.Strings = (
      'DELETE FROM S_Work'
      'WHERE id = :OLD_ID')
    Left = 496
    Top = 48
  end
  object S_Place_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_place s'
      'WHERE s.del in ('#39'-'#39','#39'd'#39') and  s.id > 0'
      'ORDER BY s.Name_r')
    UpdateObject = S_Place_upd
    Left = 552
    Top = 8
  end
  object S_Place_sur: TDataSource
    DataSet = S_Place_q
    Left = 560
    Top = 24
  end
  object S_Place_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_Place'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_Place (name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_Place'
      'WHERE id = :OLD_ID')
    Left = 568
    Top = 40
  end
  object S_mat_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.ed_izm, s.diampresent, s.del'
      'FROM s_mat s'
      'WHERE s.del in ('#39'-'#39','#39'd'#39') and s.id > 0'
      'ORDER BY s.Name_r, s.ed_izm')
    UpdateObject = S_mat_upd
    Left = 72
    Top = 104
    object S_mat_qID: TIntegerField
      FieldName = 'ID'
    end
    object S_mat_qNAME_R: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
    end
    object S_mat_qED_IZM: TStringField
      FieldName = 'ED_IZM'
      FixedChar = True
      Size = 10
    end
    object S_mat_qDIAMPRESENT: TIntegerField
      FieldName = 'DIAMPRESENT'
    end
    object S_mat_qListDIAMPRESENT: TStringField
      FieldKind = fkLookup
      FieldName = 'ListDIAMPRESENT'
      LookupDataSet = TBL_const_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'DIAMPRESENT'
      Lookup = True
    end
    object S_mat_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
  end
  object S_mat_sur: TDataSource
    DataSet = S_mat_q
    Left = 80
    Top = 120
  end
  object S_mat_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_Mat'
      'SET  name_r = :name_r,'
      '         ed_izm = :ed_izm,'
      '         diampresent = :diampresent, '
      '         del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_Mat (name_r, ed_izm, diampresent)'
      'VALUES (:name_r, :ed_izm, :diampresent)')
    DeleteSQL.Strings = (
      'DELETE FROM S_Mat'
      'WHERE id = :OLD_ID')
    Left = 88
    Top = 136
  end
  object S_runw_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_runw s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    UpdateObject = S_runw_upd
    Left = 136
    Top = 104
  end
  object S_runw_sur: TDataSource
    DataSet = S_runw_q
    Left = 144
    Top = 120
  end
  object S_runw_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_Runw'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_Runw (name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_runw'
      'WHERE id = :OLD_ID')
    Left = 152
    Top = 136
  end
  object S_Diam_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_diam'
      'SET  diam = :diam, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_diam (diam)'
      'VALUES (:diam)')
    DeleteSQL.Strings = (
      'DELETE FROM S_diam'
      'WHERE id = :OLD_ID')
    Left = 216
    Top = 136
  end
  object S_Mest_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.name_r, s.VOSST_POKRYT,s.del'
      'FROM s_mest s'
      'WHERE s.id > 0'
      'ORDER BY s.name_r')
    UpdateObject = S_Mest_upd
    Left = 264
    Top = 104
    object S_Mest_qID: TIntegerField
      FieldName = 'ID'
    end
    object S_Mest_qNAME_R: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
    end
    object S_Mest_qVOSST_POKRYT: TStringField
      FieldName = 'VOSST_POKRYT'
      FixedChar = True
      Size = 8
    end
    object S_Mest_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
  end
  object S_Mest_sur: TDataSource
    DataSet = S_Mest_q
    Left = 272
    Top = 120
  end
  object S_Mest_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_mest'
      'SET  name_r = :name_r, del = :del, VOSST_POKRYT=:VOSST_POKRYT'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_mest (name_r,VOSST_POKRYT)'
      'VALUES (:name_r,:VOSST_POKRYT)')
    DeleteSQL.Strings = (
      'DELETE FROM S_mest'
      'WHERE id = :OLD_ID')
    Left = 280
    Top = 136
  end
  object S_zav_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT s.id, s.name_r, s.del'
      'FROM s_zav s'
      'WHERE s.id > 0'
      'ORDER BY s.name_r')
    UpdateObject = S_zav_upd
    Left = 336
    Top = 104
  end
  object S_zav_sur: TDataSource
    DataSet = S_zav_q
    Left = 344
    Top = 120
  end
  object S_zav_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_zav'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_zav (name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_zav'
      'WHERE id = :OLD_ID')
    Left = 352
    Top = 136
  end
  object S_Obor_sur: TDataSource
    DataSet = S_Obor_q
    Left = 416
    Top = 120
  end
  object S_Obor_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_obor'
      'SET  name_r = :name_r,'
      '         fio = :fio, '
      '         del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_obor (name_r, fio)'
      'VALUES (:name_r, :fio)')
    DeleteSQL.Strings = (
      'DELETE FROM S_obor'
      'WHERE id = :OLD_ID')
    Left = 424
    Top = 136
  end
  object S_tzav_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.name_r, s.isviezd, s.del'
      'FROM s_tzav s'
      'WHERE s.id > 0'
      'ORDER BY s.name_r, s.isviezd')
    Left = 472
    Top = 104
  end
  object S_tzav_sur: TDataSource
    DataSet = S_tzav_q
    Left = 480
    Top = 120
  end
  object S_tzav_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_tzav'
      'SET  name_r = :name_r,'
      '         isviezd = :isviezd, '
      '         del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_tzav (name_r, isviezd)'
      'VALUES (:name_r, :isviezd)')
    DeleteSQL.Strings = (
      'DELETE FROM S_tzav'
      'WHERE id = :OLD_ID')
    Left = 488
    Top = 136
  end
  object TBL_const_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT id, name'
      'FROM TBL_const'
      'WHERE id > 0'
      'ORDER BY name')
    Left = 544
    Top = 104
  end
  object TBL_const_sur: TDataSource
    DataSet = TBL_const_q
    Left = 552
    Top = 120
  end
  object TableLog_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    SQL.Strings = (
      'SELECT id, ftype, idobj, user_name, old_value, new_value, '
      '                  date_change'
      'FROM TableLog'
      'WHERE id > 0'
      'ORDER BY date_change desc, ftype, idobj')
    Left = 608
    Top = 104
    object TableLog_qID: TIntegerField
      FieldName = 'ID'
    end
    object TableLog_qTYPE: TIntegerField
      FieldName = 'FTYPE'
    end
    object TableLog_qIDOBJ: TIntegerField
      FieldName = 'IDOBJ'
    end
    object TableLog_qUSER_NAME: TStringField
      FieldName = 'USER_NAME'
      FixedChar = True
      Size = 25
    end
    object TableLog_qOLD_VALUE: TStringField
      FieldName = 'OLD_VALUE'
      FixedChar = True
      Size = 100
    end
    object TableLog_qNEW_VALUE: TStringField
      FieldName = 'NEW_VALUE'
      FixedChar = True
      Size = 100
    end
    object TableLog_qDATE_CHANGE: TDateTimeField
      FieldName = 'DATE_CHANGE'
    end
    object TableLog_qDEL: TStringField
      FieldKind = fkCalculated
      FieldName = 'DEL'
      Calculated = True
    end
  end
  object TableLog_sur: TDataSource
    DataSet = TableLog_q
    Left = 616
    Top = 120
  end
  object TableLog_upd: TUpdateSQL
    ModifySQL.Strings = (
      '')
    InsertSQL.Strings = (
      
        'INSERT INTO TableLog (ftype, idobj, user_name, old_value, new_va' +
        'lue)'
      'VALUES (:ftype, :idobj, :user_name, :old_value, :new_value)'
      '')
    DeleteSQL.Strings = (
      'DELETE FROM TableLog'
      'WHERE id = :OLD_ID'
      '')
    Left = 560
    Top = 136
  end
  object Users_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    SQL.Strings = (
      'SELECT br.id, br.Name_r, br.dolgn, br.uid, br.prava'
      'FROM s_brig br'
      'WHERE (br.id > 0)and(uid is not null)'
      'ORDER BY br.Name_r, br.dolgn')
    UpdateObject = TableLog_upd
    Left = 8
    Top = 200
  end
  object Users_sur: TDataSource
    DataSet = Users_q
    Left = 16
    Top = 216
  end
  object s_rayons_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_rayon s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    UpdateObject = s_rayons_upd
    Left = 64
    Top = 200
  end
  object s_rayons_sur: TDataSource
    DataSet = s_rayons_q
    Left = 72
    Top = 216
  end
  object s_rayons_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_Rayon'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_Rayon (name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_Rayon'
      'WHERE id = :OLD_ID')
    Left = 80
    Top = 232
  end
  object s_vidul_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_vidul s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    UpdateObject = s_vidul_upd
    Left = 128
    Top = 200
  end
  object s_vidul_sur: TDataSource
    DataSet = s_vidul_q
    Left = 136
    Top = 216
  end
  object s_vidul_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_vidul'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_vidul (name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_vidul'
      'WHERE id = :OLD_ID')
    Left = 144
    Top = 232
  end
  object s_ulic_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      
        'SELECT wk.id, wk.Name_r, wk.id_vidul, pl.name_r as vidname_r, wk' +
        '.id_rayon ,sr.name_r rayon, wk.del,'
      'rtrim(wk.Name_r)||'#39' '#39'||rtrim(pl.name_r) as ul_vidul'
      'FROM s_ulic wk LEFT JOIN s_vidul pl'
      '            ON (wk.id_vidul = pl.id)'
      '            left join  s_rayon sr on sr.id=wk.id_rayon'
      'WHERE wk.del in ('#39'-'#39','#39'd'#39') and wk.id > 0 and wk.id_vidul>-2'
      'ORDER BY sr.id,wk.Name_r, pl.name_r')
    UpdateObject = s_ulic_upd
    Left = 200
    Top = 200
    object s_ulic_qid: TIntegerField
      FieldName = 'ID'
    end
    object s_ulic_qname_r: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
      Size = 30
    end
    object s_ulic_qlist_place: TStringField
      FieldKind = fkLookup
      FieldName = 'List_Place'
      LookupDataSet = s_vidul_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_VIDUL'
      Size = 30
      Lookup = True
    end
    object s_ulic_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object s_ulic_qID_VIDUL: TIntegerField
      FieldName = 'ID_VIDUL'
    end
    object s_ulic_qVIDNAME_R: TStringField
      FieldName = 'VIDNAME_R'
      FixedChar = True
    end
    object s_ulic_qUL_VIDUL: TStringField
      FieldName = 'UL_VIDUL'
      Size = 162
    end
    object s_ulic_qID_RAYON: TIntegerField
      FieldName = 'ID_RAYON'
    end
    object s_ulic_qRAYON: TStringField
      FieldName = 'RAYON'
      FixedChar = True
    end
    object s_ulic_qList_Rayon: TStringField
      FieldKind = fkLookup
      FieldName = 'List_Rayon'
      LookupDataSet = s_rayons_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_RAYON'
      Size = 25
      Lookup = True
    end
  end
  object s_ulic_sur: TDataSource
    DataSet = s_ulic_q
    Left = 208
    Top = 216
  end
  object s_ulic_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_ulic'
      'SET  name_r = :name_r,'
      '         id_vidul = :id_vidul,'
      '         id_rayon=:id_rayon,'
      '        del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_ulic (name_r, id_vidul, id_rayon)'
      'VALUES (:name_r, :id_vidul,:id_rayon)')
    DeleteSQL.Strings = (
      'DELETE FROM S_ulic'
      'WHERE id = :OLD_ID')
    Left = 216
    Top = 232
  end
  object s_leak_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_leak s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    UpdateObject = s_leak_upd
    Left = 264
    Top = 200
  end
  object s_leak_sur: TDataSource
    DataSet = s_leak_q
    Left = 272
    Top = 216
  end
  object s_leak_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_leak'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_leak (name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_leak'
      'WHERE id = :OLD_ID')
    Left = 280
    Top = 232
  end
  object s_clog_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_clog s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    UpdateObject = s_clog_upd
    Left = 328
    Top = 200
  end
  object s_clog_sur: TDataSource
    DataSet = s_clog_q
    Left = 336
    Top = 216
  end
  object s_clog_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_clog'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_clog (name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_clog'
      'WHERE id = :OLD_ID')
    Left = 344
    Top = 232
  end
  object s_fill_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_fill s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    UpdateObject = s_fill_upd
    Left = 392
    Top = 200
  end
  object s_fill_sur: TDataSource
    DataSet = s_fill_q
    Left = 400
    Top = 216
  end
  object s_fill_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_fill'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_fill (name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_fill'
      'WHERE id = :OLD_ID')
    Left = 408
    Top = 232
  end
  object s_net_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_net s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    UpdateObject = s_net_upd
    Left = 456
    Top = 200
  end
  object s_net_sur: TDataSource
    DataSet = s_net_q
    Left = 464
    Top = 216
  end
  object s_net_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_net'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_net(name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_net'
      'WHERE id = :OLD_ID')
    Left = 472
    Top = 232
  end
  object s_local_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_local s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    UpdateObject = s_local_upd
    Left = 528
    Top = 200
  end
  object s_local_sur: TDataSource
    DataSet = s_local_q
    Left = 536
    Top = 216
  end
  object s_local_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_local'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_local(name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_local'
      'WHERE id = :OLD_ID')
    Left = 544
    Top = 232
  end
  object s_killclog_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_killclog s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    UpdateObject = s_killclog_upd
    Left = 16
    Top = 288
  end
  object s_killclog_sur: TDataSource
    DataSet = s_killclog_q
    Left = 24
    Top = 304
  end
  object s_killclog_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_killclog'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_killclog(name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_killclog'
      'WHERE id = :OLD_ID')
    Left = 32
    Top = 320
  end
  object s_pump_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del, s.otv, s.tel_otv'
      'FROM s_pump s'
      'WHERE s.id > 0'
      'ORDER BY id')
    UpdateObject = s_pump_upd
    Left = 88
    Top = 288
  end
  object s_pump_sur: TDataSource
    DataSet = s_pump_q
    Left = 96
    Top = 304
  end
  object s_pump_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_pump'
      'SET  name_r = :name_r, del = :del,otv=:otv, tel_otv=:tel_otv'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_pump(name_r,otv, tel_otv)'
      'VALUES (:name_r,:otv, :tel_otv)')
    DeleteSQL.Strings = (
      'DELETE FROM S_pump'
      'WHERE id = :OLD_ID')
    Left = 104
    Top = 320
  end
  object s_pes_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_pes s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    UpdateObject = s_pes_upd
    Left = 160
    Top = 288
  end
  object s_pes_sur: TDataSource
    DataSet = s_pes_q
    Left = 168
    Top = 304
  end
  object s_pes_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_pes'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_pes(name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_pes'
      'WHERE id = :OLD_ID')
    Left = 176
    Top = 320
  end
  object s_owner_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.owner_type, s.for_vedom, s.del'
      'FROM s_owner s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    Left = 296
    Top = 288
    object s_owner_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_owner_qNAME_R: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
    end
    object s_owner_qOWNER_TYPE: TSmallintField
      FieldName = 'OWNER_TYPE'
    end
    object s_owner_qFOR_VEDOM: TStringField
      FieldName = 'FOR_VEDOM'
      FixedChar = True
      Size = 40
    end
    object s_owner_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object s_owner_qlist_OWNER_TYPE: TStringField
      FieldKind = fkLookup
      FieldName = 'list_OWNER_TYPE'
      LookupDataSet = s_owner_type
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'OWNER_TYPE'
      Lookup = True
    end
  end
  object s_owner_sur: TDataSource
    DataSet = s_owner_q
    Left = 312
    Top = 304
  end
  object s_owner_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_owner'
      'SET  name_r = :name_r, del = :del,'
      'owner_type=:owner_type, for_vedom=:for_vedom'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_owner(name_r,owner_type, for_vedom)'
      'VALUES (:name_r,:owner_type, :for_vedom)')
    DeleteSQL.Strings = (
      'DELETE FROM S_owner'
      'WHERE id = :OLD_ID')
    Left = 328
    Top = 320
  end
  object s_comment_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_comment s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    UpdateObject = s_comment_upd
    Left = 224
    Top = 288
  end
  object s_comment_sur: TDataSource
    DataSet = s_comment_q
    Left = 240
    Top = 304
  end
  object s_comment_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_comment'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_comment(name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_comment'
      'WHERE id = :OLD_ID')
    Left = 248
    Top = 320
  end
  object s_matpipe: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT s.id, s.name_r, s.del'
      'FROM s_matpipe s'
      'WHERE s.id > 0'
      'ORDER BY s.name_r')
    UpdateObject = s_matpipe_upd
    Left = 640
    Top = 296
  end
  object s_matpipe_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_matpipe'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_matpipe(name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_matpipe'
      'WHERE id = :OLD_ID')
    Left = 665
    Top = 309
  end
  object ds_matpipe: TDataSource
    DataSet = s_matpipe
    Left = 676
    Top = 334
  end
  object S_Obor_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    RequestLive = True
    SQL.Strings = (
      ''
      'SELECT *'
      'FROM MEXAN s'
      'WHERE s.del in ('#39'-'#39','#39'd'#39') and s.id > 0'
      'ORDER BY s.name_r,s.fio'
      ''
      '/*select * from MEXAN where del = '#39'-'#39'*/')
    UpdateObject = S_Obor_upd
    Left = 408
    Top = 104
    object StringField1: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
      Size = 25
    end
    object StringField2: TStringField
      DisplayWidth = 15
      FieldName = 'FIO'
      FixedChar = True
      Size = 25
    end
    object IntegerField1: TIntegerField
      FieldName = 'ID'
    end
    object StringField3: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object S_Obor_qNAME_R_AND_FIO: TStringField
      FieldName = 'NAME_R_AND_FIO'
      FixedChar = True
      Size = 52
    end
  end
  object s_zayavl_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT sz.id, sz.Name_r'
      'FROM s_zayavl sz'
      'WHERE sz.id > 0'
      'ORDER BY sz.Name_r')
    UpdateObject = s_zayavl_upd
    Left = 232
    Top = 396
    object IntegerField2: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object StringField4: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
    end
  end
  object s_zayavl_sur: TDataSource
    DataSet = s_zayavl_q
    Left = 240
    Top = 412
  end
  object s_zayavl_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_Zayavl'
      'SET  name_r = :name_r'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_Zayavl(name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_Zayavl'
      'WHERE id = :OLD_ID')
    Left = 228
    Top = 428
  end
  object S_Fulltzav_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT s.id, s.name_r, s.isviezd, s.del'
      'FROM s_tzav s'
      'ORDER BY s.name_r, s.isviezd')
    Left = 488
    Top = 152
  end
  object S_FullPlace_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_place s'
      'WHERE s.del in ('#39'-'#39','#39'd'#39') '
      'ORDER BY s.Name_r')
    Left = 608
    Top = 8
  end
  object s_remont_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.id_remont_type, s.del'
      'FROM s_remont s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    Left = 312
    Top = 392
    object s_remont_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_remont_qNAME_R: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
      Size = 40
    end
    object s_remont_qID_REMONT_TYPE: TIntegerField
      FieldName = 'ID_REMONT_TYPE'
    end
    object s_remont_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object s_remont_qlp_REMONT_TYPE: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_REMONT_TYPE'
      LookupDataSet = s_remont_type_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_REMONT_TYPE'
      Lookup = True
    end
  end
  object s_remont_sur: TDataSource
    DataSet = s_remont_q
    Left = 320
    Top = 408
  end
  object s_remont_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_Remont SET'
      'name_r = :name_r,'
      'id_remont_type = :id_remont_type,'
      'del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_Remont (name_r, id_remont_type)'
      'VALUES (:name_r, :id_remont_type)')
    DeleteSQL.Strings = (
      'DELETE FROM S_Remont'
      'WHERE id = :OLD_ID')
    Left = 328
    Top = 424
  end
  object s_owner_type: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT so.id, so.Name_r'
      'FROM s_owner_type so'
      'WHERE so.id > 0'
      'ORDER BY so.Name_r')
    Left = 368
    Top = 288
  end
  object tmp_Qry_ul: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select u.id id, rtrim(u.name_r)||" "||rtrim(v.name_r) as name_ul'
      'from s_ulic u,s_vidul v'
      
        'where (u.del in ('#39'-'#39','#39'd'#39')) and (u.id_vidul=v.id)  and (u.id=:id_' +
        'ul)')
    Left = 480
    Top = 432
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id_ul'
        ParamType = ptUnknown
      end>
  end
  object S_PlanObor_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT s.id, s.name_r, s.del'
      'FROM s_PlanObor s'
      'WHERE s.del in ('#39'-'#39','#39'd'#39') and s.id > 0'
      'ORDER BY s.name_r')
    UpdateObject = S_PlanObor_upd
    Left = 448
    Top = 336
    object S_PlanObor_qID: TIntegerField
      FieldName = 'ID'
    end
    object S_PlanObor_qNAME_R: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
      Size = 25
    end
    object S_PlanObor_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
  end
  object S_PlanObor_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_PlanObor'
      'SET  name_r = :name_r,'
      '         del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_PlanObor (name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_PlanObor'
      'WHERE id = :OLD_ID')
    Left = 464
    Top = 352
  end
  object s_PlanObor_sur: TDataSource
    DataSet = S_PlanObor_q
    Left = 472
    Top = 368
  end
  object s_vrk_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'select vrk.id, vrk.id_ulic, vrk.num_dom,'
      'vrk.id_tvrk, vrk.oplacheno, vrk.del,vrk.n_vrk,'
      ''
      '(select rtrim(u.name_r)||" "||rtrim(vid.name_r)'
      'from s_ulic u'
      'left join s_vidul vid on vid.id=u.id_vidul'
      'where u.id=vrk.id_ulic) ulic'
      ''
      'from vrk'
      'where vrk.del in ('#39'-'#39', '#39'd'#39') and vrk.id>0'
      'order by 8')
    UpdateObject = s_vrk_upd
    Left = 16
    Top = 380
    object s_vrk_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_vrk_qID_ULIC: TIntegerField
      FieldName = 'ID_ULIC'
    end
    object s_vrk_qULIC: TStringField
      FieldName = 'ULIC'
      Size = 161
    end
    object s_vrk_qNUM_DOM: TStringField
      FieldName = 'NUM_DOM'
      FixedChar = True
      Size = 10
    end
    object s_vrk_qID_TVRK: TIntegerField
      FieldName = 'ID_TVRK'
    end
    object s_vrk_qOPLACHENO: TIntegerField
      FieldName = 'OPLACHENO'
    end
    object s_vrk_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object s_vrk_qlistULIC: TStringField
      FieldKind = fkLookup
      FieldName = 'listULIC'
      LookupDataSet = s_ulic_q
      LookupKeyFields = 'ID'
      LookupResultField = 'UL_VIDUL'
      KeyFields = 'ID_ULIC'
      Lookup = True
    end
    object s_vrk_qlistTVRK: TStringField
      FieldKind = fkLookup
      FieldName = 'listTVRK'
      LookupDataSet = s_tvrk_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_TVRK'
      Lookup = True
    end
    object s_vrk_qlistOPLACHENO: TStringField
      FieldKind = fkLookup
      FieldName = 'listOPLACHENO'
      LookupDataSet = s_yesno_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'OPLACHENO'
      Lookup = True
    end
    object s_vrk_qN_VRK: TStringField
      FieldName = 'N_VRK'
      FixedChar = True
      Size = 4
    end
  end
  object s_vrk_sur: TDataSource
    DataSet = s_vrk_q
    Left = 28
    Top = 400
  end
  object s_vrk_upd: TUpdateSQL
    ModifySQL.Strings = (
      'update vrk set'
      'id_ulic=:id_ulic,'
      'num_dom=:num_dom,'
      'id_tvrk=:id_tvrk,'
      'oplacheno=:oplacheno,'
      'del=:del,'
      'n_vrk=:n_vrk'
      'where id=:id ')
    InsertSQL.Strings = (
      'insert into vrk(id_ulic,  num_dom, id_tvrk, oplacheno,n_vrk)'
      'values(:id_ulic, :num_dom,:id_tvrk, :oplacheno,:n_vrk)')
    DeleteSQL.Strings = (
      'delete from vrk where id=:old_id')
    Left = 32
    Top = 420
  end
  object s_yesno_q: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id, name_r'
      'from s_yesno'
      'order by name_r')
    Left = 96
    Top = 376
    object s_yesno_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_yesno_qNAME_R: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
      Size = 10
    end
  end
  object s_tvrk_q: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id, name_r'
      'from s_tvrk'
      'order by name_r')
    Left = 96
    Top = 428
    object s_tvrk_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_tvrk_qNAME_R: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
    end
  end
  object s_dopadres_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.name_r, s.del'
      'FROM s_dopadres s'
      'WHERE s.id > 0'
      'ORDER BY s.name_r'
      '')
    UpdateObject = s_dopadres_upd
    Left = 608
    Top = 200
  end
  object s_dopadres_sur: TDataSource
    DataSet = s_dopadres_q
    Left = 616
    Top = 216
  end
  object s_dopadres_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_dopadres'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id'
      '')
    InsertSQL.Strings = (
      'INSERT INTO S_dopadres (name_r)'
      'VALUES (:name_r)'
      '')
    DeleteSQL.Strings = (
      'DELETE FROM S_dopadres'
      'WHERE id = :OLD_ID'
      '')
    Left = 624
    Top = 232
  end
  object tmp_Qry_DopAdr: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select name_r'
      'from s_dopadres'
      'where id=:pID')
    Left = 568
    Top = 440
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pID'
        ParamType = ptUnknown
      end>
  end
  object s_MestType_q: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id, name_r'
      'from s_mesttype'
      'where id > 0'
      'order by name_r')
    Left = 96
    Top = 520
    object s_MestType_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_MestType_qNAME_R: TStringField
      FieldName = 'NAME_R'
      Size = 30
    end
  end
  object s_trudozatrat_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    RequestLive = True
    SQL.Strings = (
      'select tz.id, tz.id_work, tz.tz_summer, tz.tz_winter,'
      'tz.id_diam, tz.kol_ed, tz.id_mesttype, tz.del'
      'from s_trudozatrat tz'
      'left join s_work w on w.id = tz.id_work'
      'left join s_diam d on d.id = tz.id_diam'
      'where (tz.id > 0)'
      'order by w.name_r, d.diam')
    UpdateObject = s_trudozatrat_upd
    Left = 192
    Top = 528
    object s_trudozatrat_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_trudozatrat_qID_WORK: TIntegerField
      FieldName = 'ID_WORK'
    end
    object s_trudozatrat_qTZ_SUMMER: TBCDField
      FieldName = 'TZ_SUMMER'
      Precision = 9
      Size = 2
    end
    object s_trudozatrat_qTZ_WINTER: TBCDField
      FieldName = 'TZ_WINTER'
      Precision = 9
      Size = 2
    end
    object s_trudozatrat_qID_DIAM: TIntegerField
      FieldName = 'ID_DIAM'
    end
    object s_trudozatrat_qKOL_ED: TBCDField
      FieldName = 'KOL_ED'
      Precision = 9
      Size = 2
    end
    object s_trudozatrat_qID_MESTTYPE: TIntegerField
      FieldName = 'ID_MESTTYPE'
    end
    object s_trudozatrat_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object s_trudozatrat_qlp_WORK: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_WORK'
      LookupDataSet = S_Work_q
      LookupKeyFields = 'ID'
      LookupResultField = 'FULL_NAME'
      KeyFields = 'ID_WORK'
      Size = 50
      Lookup = True
    end
    object s_trudozatrat_qlp_MESTTYPE: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_MESTTYPE'
      LookupDataSet = s_MestType_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_MESTTYPE'
      Lookup = True
    end
    object s_trudozatrat_qlp_DIAM: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_DIAM'
      LookupDataSet = s_AllDiam_q
      LookupKeyFields = 'ID'
      LookupResultField = 'clc_Diam'
      KeyFields = 'ID_DIAM'
      Lookup = True
    end
  end
  object s_trudozatrat_upd: TUpdateSQL
    ModifySQL.Strings = (
      'update s_trudozatrat set'
      '    id_work = :id_work,'
      '    tz_summer = :tz_summer,'
      '    tz_winter = :tz_winter,'
      '    id_diam = :id_diam,'
      '    kol_ed = :kol_ed,'
      '    id_mesttype = :id_mesttype,'
      '    del = :del'
      'where id = :id')
    InsertSQL.Strings = (
      'insert into s_trudozatrat('
      '    id_work,'
      '    tz_summer,'
      '    tz_winter,'
      '    id_diam,'
      '    kol_ed,'
      '    id_mesttype)'
      'values('
      '    :id_work,'
      '    :tz_summer,'
      '    :tz_winter,'
      '    :id_diam,'
      '    :kol_ed,'
      '    :id_mesttype)')
    DeleteSQL.Strings = (
      'delete from s_trudozatrat'
      'where id = :old_id')
    Left = 200
    Top = 576
  end
  object s_trudozatrat_sur: TDataSource
    DataSet = s_trudozatrat_q
    Left = 184
    Top = 488
  end
  object s_AllDiam_q: TQuery
    OnCalcFields = s_AllDiam_qCalcFields
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id, diam, del'
      'from s_diam'
      'order by diam')
    Left = 96
    Top = 584
    object s_AllDiam_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_AllDiam_qDIAM: TIntegerField
      FieldName = 'DIAM'
    end
    object s_AllDiam_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object s_AllDiam_qclc_Diam: TStringField
      FieldKind = fkCalculated
      FieldName = 'clc_Diam'
      Size = 10
      Calculated = True
    end
  end
  object s_bwork_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    RequestLive = True
    SQL.Strings = (
      'select id, name_r, del'
      'from s_bwork'
      'where id>0'
      'order by name_r')
    UpdateObject = s_bwork_upd
    Left = 424
    Top = 536
    object s_bwork_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_bwork_qNAME_R: TStringField
      FieldName = 'NAME_R'
      Size = 40
    end
    object s_bwork_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
  end
  object s_bwork_upd: TUpdateSQL
    ModifySQL.Strings = (
      'update s_bwork set'
      '  name_r = :name_r,'
      '  del = :del'
      'where id = :id')
    InsertSQL.Strings = (
      'insert into s_bwork(name_r)'
      'values(:name_r)')
    DeleteSQL.Strings = (
      'delete from s_bwork where id = :old_id')
    Left = 472
    Top = 568
  end
  object s_bwork_sur: TDataSource
    DataSet = s_bwork_q
    Left = 440
    Top = 552
  end
  object tmp_qry_Object: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select name_r'
      'from s_object'
      'where id=:pID')
    Left = 616
    Top = 520
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pID'
        ParamType = ptUnknown
      end>
  end
  object s_instrum_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    RequestLive = True
    SQL.Strings = (
      'select id, name_r, del'
      'from s_instrum'
      'where del in ('#39'-'#39','#39'd'#39')  and (id>0)'
      'order by name_r')
    UpdateObject = s_instrum_upd
    Left = 704
    Top = 48
  end
  object s_instrum_sur: TDataSource
    DataSet = s_instrum_q
    Left = 712
    Top = 72
  end
  object s_instrum_upd: TUpdateSQL
    ModifySQL.Strings = (
      'update s_instrum set'
      'name_r = :name_r,'
      'del = :del'
      'where id = :id')
    InsertSQL.Strings = (
      'insert into s_instrum(name_r)'
      'values(:name_r)')
    DeleteSQL.Strings = (
      'delete from s_instrum where id = :old_id')
    Left = 728
    Top = 88
  end
  object s_object_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    RequestLive = True
    SQL.Strings = (
      'select id, name_r, id_attach, id_revs,del'
      'from s_object'
      'where ( id>0 )'
      'order by name_r')
    Left = 832
    Top = 248
    object s_object_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_object_qNAME_R: TStringField
      FieldName = 'NAME_R'
      Size = 40
    end
    object s_object_qID_ATTACH: TIntegerField
      FieldName = 'ID_ATTACH'
    end
    object s_object_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object s_object_qlp_ATTACH: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_ATTACH'
      LookupDataSet = qry_ObjAtt
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_ATTACH'
      Size = 25
      Lookup = True
    end
    object s_object_qID_REVS: TSmallintField
      FieldName = 'ID_REVS'
    end
    object s_object_qlook_revs: TStringField
      FieldKind = fkLookup
      FieldName = 'look_revs'
      LookupDataSet = S_Revs_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_REVS'
      Lookup = True
    end
  end
  object s_object_upd: TUpdateSQL
    ModifySQL.Strings = (
      'update s_object set'
      ' name_r = :name_r,'
      ' id_attach = :id_attach,'
      ' id_revs = :id_revs,'
      ' del = :del'
      'where id = :id')
    InsertSQL.Strings = (
      'insert into s_object( name_r, id_attach, id_revs )'
      'values( :name_r, :id_attach , :id_revs)')
    DeleteSQL.Strings = (
      'delete from s_object where id = :old_id')
    Left = 824
    Top = 208
  end
  object s_object_sur: TDataSource
    DataSet = s_object_q
    Left = 808
    Top = 168
  end
  object qry_ObjAtt: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id, name_r'
      'from s_attach'
      'where id in (4,5)'
      'order by name_r')
    Left = 896
    Top = 216
    object qry_ObjAttID: TIntegerField
      FieldName = 'ID'
    end
    object qry_ObjAttNAME_R: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
      Size = 25
    end
  end
  object s_objobor_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    RequestLive = True
    SQL.Strings = (
      
        'select id, name_r, id_object, id_obortype, id_soorug, id_diam, d' +
        'el'
      
        ', (select st.DIFFER from s_obortype st where st.id=s_objobor.id_' +
        'obortype ) DIFFER'
      
        ', (select ss.name_r from s_soorug ss where ss.id = s_objobor.id_' +
        'soorug ) soorug'
      ', id_parent, inventar'
      'from s_objobor'
      'where ( del in ('#39'-'#39','#39'd'#39') ) and  ( id > 0 )'
      'order by 2,9,10')
    UpdateObject = s_objobor_upd
    Left = 792
    Top = 368
    object s_objobor_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_objobor_qNAME_R: TStringField
      FieldName = 'NAME_R'
      Size = 40
    end
    object s_objobor_qID_OBJECT: TIntegerField
      FieldName = 'ID_OBJECT'
    end
    object s_objobor_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object s_objobor_qID_OBORTYPE: TIntegerField
      FieldName = 'ID_OBORTYPE'
    end
    object s_objobor_qID_SOORUG: TIntegerField
      FieldName = 'ID_SOORUG'
    end
    object s_objobor_qID_DIAM: TIntegerField
      FieldName = 'ID_DIAM'
    end
    object s_objobor_qlook_obortype: TStringField
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'look_obortype'
      LookupDataSet = s_obortype_lookup
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_OBORTYPE'
      Size = 40
      Lookup = True
    end
    object s_objobor_qlook_soorug: TStringField
      DisplayWidth = 35
      FieldKind = fkLookup
      FieldName = 'look_soorug'
      LookupDataSet = s_soorug_lookup
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_SOORUG'
      Size = 48
      Lookup = True
    end
    object s_objobor_qlook_diam: TIntegerField
      FieldKind = fkLookup
      FieldName = 'look_diam'
      LookupDataSet = s_AllDiam_q
      LookupKeyFields = 'ID'
      LookupResultField = 'DIAM'
      KeyFields = 'ID_DIAM'
      Lookup = True
    end
    object s_objobor_qDIFFER: TIntegerField
      FieldName = 'DIFFER'
    end
    object s_objobor_qID_PARENT: TIntegerField
      FieldName = 'ID_PARENT'
    end
    object s_objobor_qSOORUG: TStringField
      FieldName = 'SOORUG'
      FixedChar = True
      Size = 64
    end
    object s_objobor_qINVENTAR: TStringField
      FieldName = 'INVENTAR'
      FixedChar = True
    end
  end
  object s_objobor_upd: TUpdateSQL
    ModifySQL.Strings = (
      'update s_objobor set '
      'name_r = :name_r,'
      'id_object = :id_object,'
      'id_obortype = :id_obortype, '
      'id_soorug = :id_soorug, '
      'id_diam = :id_diam,'
      'id_parent = :id_parent,'
      'inventar= :inventar,'
      'del = :del'
      'where id = :id')
    InsertSQL.Strings = (
      
        'insert into s_objobor( name_r, id_object,id_obortype, id_soorug,' +
        ' id_diam, id_parent, inventar)'
      
        'values( :name_r, :id_object,:id_obortype, :id_soorug, :id_diam ,' +
        ' :id_parent, :inventar)')
    DeleteSQL.Strings = (
      'delete from s_objobor where id = :old_id')
    Left = 808
    Top = 392
  end
  object s_objobor_sur: TDataSource
    DataSet = s_objobor_q
    Left = 824
    Top = 408
  end
  object tmp_qry_Attach: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id_attach'
      'from nzavjav'
      'where id = :pZavID'
      'union all'
      'select id_attach'
      'from zavjav'
      'where id= :pZavID')
    Left = 624
    Top = 568
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pZavID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'pZavID'
        ParamType = ptUnknown
      end>
  end
  object s_remont_type_q: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id, name_r'
      'from s_remont_type'
      'order by name_r')
    Left = 328
    Top = 488
    object s_remont_type_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_remont_type_qNAME_R: TStringField
      FieldName = 'NAME_R'
    end
  end
  object s_work_type_q: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id, name_r'
      'from s_work_type'
      'order by name_r')
    Left = 688
    Top = 440
    object s_work_type_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_work_type_qNAME_R: TStringField
      FieldName = 'NAME_R'
      Size = 40
    end
  end
  object s_work_mest_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    RequestLive = True
    SQL.Strings = (
      'select swm.id, swm.id_work, swm.id_mest, swm.del'
      'from s_work_mest swm'
      'left join s_work sw on sw.id = swm.id_work'
      'left join s_mest sm on sm.id = swm.id_mest'
      'where (swm.del in ('#39'-'#39', '#39'd'#39')) and (swm.id > 0)'
      'order by sm.name_r, sw.name_r')
    UpdateObject = s_work_mest_upd
    Left = 824
    Top = 544
    object s_work_mest_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_work_mest_qID_WORK: TIntegerField
      FieldName = 'ID_WORK'
    end
    object s_work_mest_qID_MEST: TIntegerField
      FieldName = 'ID_MEST'
    end
    object s_work_mest_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object s_work_mest_qlist_MEST: TStringField
      FieldKind = fkLookup
      FieldName = 'list_MEST'
      LookupDataSet = S_Mest_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_MEST'
      Size = 50
      Lookup = True
    end
    object s_work_mest_qlistWORK: TStringField
      FieldKind = fkLookup
      FieldName = 'listWORK'
      LookupDataSet = s_BlagWork_q
      LookupKeyFields = 'ID'
      LookupResultField = 'FULL_NAME'
      KeyFields = 'ID_WORK'
      Size = 50
      Lookup = True
    end
  end
  object s_work_mest_upd: TUpdateSQL
    ModifySQL.Strings = (
      'update s_work_mest set'
      '    id_work = :id_work,'
      '    id_mest = :id_mest,'
      '    del = :del'
      'where id = :id')
    InsertSQL.Strings = (
      'insert into s_work_mest(id_work, id_mest)'
      'values(:id_work, :id_mest)')
    DeleteSQL.Strings = (
      'delete from s_work_mest where id = :old_id')
    Left = 848
    Top = 568
  end
  object s_work_mest_sur: TDataSource
    DataSet = s_work_mest_q
    Left = 872
    Top = 584
  end
  object s_BlagWork_q: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT wk.id,'
      'rtrim(wk.name_r)||'#39' ['#39'||rtrim(pl.name_r)||'#39']'#39' as full_name'
      'FROM s_work wk'
      'LEFT JOIN s_place pl ON (wk.ftype = pl.id)'
      'WHERE ( wk.del in ('#39'-'#39') ) and ( wk.id > 0 )'
      'and ( wk.id_work_type = 2 )'
      'ORDER BY wk.Name_r, pl.name_r')
    Left = 736
    Top = 520
    object s_BlagWork_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_BlagWork_qFULL_NAME: TStringField
      FieldName = 'FULL_NAME'
      Size = 163
    end
  end
  object s_ogragd_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_ogragd s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    UpdateObject = s_ogragd_upd
    Left = 731
    Top = 168
  end
  object s_ogragd_sur: TDataSource
    DataSet = s_ogragd_q
    Left = 731
    Top = 216
  end
  object s_ogragd_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_Ogragd'
      'SET  name_r = :name_r, del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_Ogragd (name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_Ogragd'
      'WHERE id = :OLD_ID')
    Left = 731
    Top = 264
  end
  object s_obortype_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r,  s.differ,  s.id_obortypeglob ,s.del'
      'FROM s_obortype s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    UpdateObject = s_obortype_upd
    Left = 35
    Top = 632
    object s_obortype_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_obortype_qNAME_R: TStringField
      DisplayWidth = 40
      FieldName = 'NAME_R'
      FixedChar = True
      Size = 40
    end
    object s_obortype_qDIFFER: TIntegerField
      FieldName = 'DIFFER'
    end
    object s_obortype_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object s_obortype_qlook_differ: TStringField
      FieldKind = fkLookup
      FieldName = 'look_differ'
      LookupDataSet = s_yesno_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'DIFFER'
      Size = 10
      Lookup = True
    end
    object s_obortype_qID_OBORTYPEGLOB: TIntegerField
      FieldName = 'ID_OBORTYPEGLOB'
    end
    object s_obortype_qlook_obortypeglobal: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'look_obortypeglobal'
      LookupDataSet = s_obortypeglob_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_OBORTYPEGLOB'
      Size = 30
      Lookup = True
    end
  end
  object s_obortype_sur: TDataSource
    DataSet = s_obortype_q
    Left = 51
    Top = 648
  end
  object s_obortype_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_obortype'
      'SET  name_r = :name_r'
      ', differ = :differ'
      ', id_obortypeglob = :id_obortypeglob'
      ', del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_obortype (name_r, differ, id_obortypeglob )'
      'VALUES (:name_r, :differ, :id_obortypeglob)')
    DeleteSQL.Strings = (
      'DELETE FROM S_obortype'
      'WHERE id = :OLD_ID')
    Left = 59
    Top = 664
  end
  object s_obortypegroup_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Obortype,  s.detail, s.del'
      'FROM s_obortypegroup s'
      'WHERE s.id > 0'
      'and obortype = :obortype'
      'ORDER BY s.Obortype')
    UpdateObject = s_obortypegroup_upd
    Left = 35
    Top = 712
    ParamData = <
      item
        DataType = ftInteger
        Name = 'obortype'
        ParamType = ptInput
      end>
    object s_obortypegroup_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_obortypegroup_qOBORTYPE: TIntegerField
      FieldName = 'OBORTYPE'
    end
    object s_obortypegroup_qDETAIL: TIntegerField
      FieldName = 'DETAIL'
    end
    object s_obortypegroup_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object s_obortypegroup_qlook_obortype: TStringField
      FieldKind = fkLookup
      FieldName = 'look_obortype'
      LookupDataSet = s_obortype_look
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'DETAIL'
      Size = 25
      Lookup = True
    end
  end
  object s_obortypegroup_sur: TDataSource
    DataSet = s_obortypegroup_q
    Left = 51
    Top = 728
  end
  object s_obortypegroup_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_obortypegroup'
      'SET  detail = :detail'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_obortypegroup ( obortype, detail )'
      'VALUES (:obortype, :detail)')
    DeleteSQL.Strings = (
      'DELETE FROM S_obortypegroup'
      'WHERE id = :OLD_ID')
    Left = 67
    Top = 744
  end
  object s_obortype_look: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filter = 'del='#39'-'#39
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r,  s.differ,s.del'
      'FROM s_obortype s'
      'WHERE s.id > 0'
      'and s.del = '#39'-'#39
      'and s.id <> :aid'
      'ORDER BY s.Name_r')
    Left = 123
    Top = 688
    ParamData = <
      item
        DataType = ftInteger
        Name = 'aid'
        ParamType = ptInput
      end>
    object IntegerField3: TIntegerField
      FieldName = 'ID'
    end
    object StringField5: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
      Size = 25
    end
    object IntegerField4: TIntegerField
      FieldName = 'DIFFER'
    end
    object StringField6: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object StringField7: TStringField
      FieldKind = fkLookup
      FieldName = 'look_differ'
      LookupDataSet = s_yesno_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'DIFFER'
      Size = 10
      Lookup = True
    end
  end
  object s_soorug_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r,  s.id_object,s.del '
      'FROM s_soorug s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    Left = 195
    Top = 648
    object s_soorug_qID: TIntegerField
      FieldName = 'ID'
    end
    object s_soorug_qNAME_R: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
      Size = 35
    end
    object s_soorug_qID_OBJECT: TIntegerField
      FieldName = 'ID_OBJECT'
    end
    object s_soorug_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object s_soorug_qlook_object: TStringField
      FieldKind = fkLookup
      FieldName = 'look_object'
      LookupDataSet = s_object_lookup
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_OBJECT'
      LookupCache = True
      Size = 40
      Lookup = True
    end
  end
  object s_soorug_sur: TDataSource
    DataSet = s_soorug_q
    Left = 219
    Top = 672
  end
  object s_soorug_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_soorug'
      'SET  name_r = :name_r'
      ', id_object = :id_object'
      ', del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_soorug (name_r, id_object )'
      'VALUES (:name_r, :id_object)')
    DeleteSQL.Strings = (
      'DELETE FROM S_soorug'
      'WHERE id = :OLD_ID')
    Left = 243
    Top = 696
  end
  object s_obortypeglob_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r,  s.del'
      'FROM s_obortypeglob s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    UpdateObject = s_obortypeglob_upd
    Left = 299
    Top = 648
  end
  object s_obortypeglob_sur: TDataSource
    DataSet = s_obortypeglob_q
    Left = 323
    Top = 672
  end
  object s_obortypeglob_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_obortypeglob'
      'SET  name_r = :name_r'
      ', del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_obortypeglob (name_r)'
      'VALUES (:name_r)')
    DeleteSQL.Strings = (
      'DELETE FROM S_obortypeglob'
      'WHERE id = :OLD_ID')
    Left = 347
    Top = 696
  end
  object s_obortype_lookup: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r,  s.differ,s.del'
      'FROM s_obortype s'
      'WHERE (s.id > 0)'
      'and (s.del = '#39'-'#39')'
      'ORDER BY s.Name_r')
    Left = 443
    Top = 648
    object IntegerField5: TIntegerField
      FieldName = 'ID'
    end
    object StringField8: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
      Size = 25
    end
    object IntegerField6: TIntegerField
      FieldName = 'DIFFER'
    end
    object StringField9: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object StringField10: TStringField
      FieldKind = fkLookup
      FieldName = 'look_differ'
      LookupDataSet = s_yesno_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'DIFFER'
      Size = 10
      Lookup = True
    end
  end
  object s_soorug_lookup: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r,  s.id_object,s.del'
      'FROM s_soorug s'
      'WHERE (s.id > 0 )'
      'and (s.del = '#39'-'#39')'
      'ORDER BY s.Name_r')
    Left = 451
    Top = 704
    object IntegerField7: TIntegerField
      FieldName = 'ID'
    end
    object StringField11: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
      Size = 35
    end
    object IntegerField8: TIntegerField
      FieldName = 'ID_OBJECT'
    end
    object StringField12: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object StringField13: TStringField
      FieldKind = fkLookup
      FieldName = 'look_object'
      LookupDataSet = s_object_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_OBJECT'
      Size = 40
      Lookup = True
    end
  end
  object S_OTGlob_fields_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT     ID,'
      '    ID_OTG,'
      '    Name_r,'
      '    MEASURE,'
      '    DEL'
      'FROM S_OTGLOB_FIELDS '
      'WHERE id > 0'
      'ORDER BY Name_r')
    UpdateObject = S_OTGlob_fields_upd
    Left = 578
    Top = 648
    object S_OTGlob_fields_qID: TIntegerField
      FieldName = 'ID'
    end
    object S_OTGlob_fields_qID_OTG: TIntegerField
      FieldName = 'ID_OTG'
    end
    object S_OTGlob_fields_qNAME_R: TStringField
      FieldName = 'NAME_R'
      Size = 32
    end
    object S_OTGlob_fields_qMEASURE: TStringField
      FieldName = 'MEASURE'
      Size = 10
    end
    object S_OTGlob_fields_qDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
  end
  object S_OTGlob_fields_sur: TDataSource
    DataSet = S_OTGlob_fields_q
    Left = 602
    Top = 672
  end
  object S_OTGlob_fields_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_OTGLOB_FIELDS'
      'SET  '
      '    ID_OTG = :ID_OTG,'
      '    Name_r =:Name_r,'
      '    MEASURE = :MEASURE,'
      '    DEL =:DEL'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_OTGLOB_FIELDS ('
      '    ID_OTG,'
      '    Name_r,'
      '    MEASURE'
      ')'
      'VALUES ('
      '    :ID_OTG,'
      '    :Name_r,'
      '    :MEASURE'
      ')')
    DeleteSQL.Strings = (
      'DELETE FROM S_OTGLOB_FIELDS'
      'WHERE id = :OLD_ID')
    Left = 626
    Top = 696
  end
  object S_OT_Params_q: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT'
      '     ID,'
      '    NAME_R,'
      '    ID_OBORTYPE,'
      '    ID_FIELD,'
      '    DEL'
      'FROM S_OT_PARAMS'
      'WHERE id > 0'
      'ORDER BY Name_r')
    UpdateObject = S_OT_Params_upd
    Left = 714
    Top = 640
  end
  object S_OT_Params_sur: TDataSource
    DataSet = S_OT_Params_q
    Left = 738
    Top = 664
  end
  object S_OT_Params_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_OT_PARAMS'
      'SET'
      '    NAME_R = :NAME_R,'
      '    ID_OBORTYPE = :ID_OBORTYPE,'
      '    ID_FIELD = :ID_FIELD,'
      '    del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_OT_PARAMS (   '
      ' NAME_R ,'
      ' ID_OBORTYPE ,'
      ' ID_FIELD,'
      ')'
      'VALUES ('
      ':NAME_R, '
      ':ID_OBORTYPE, '
      ':ID_FIELD'
      ')')
    DeleteSQL.Strings = (
      'DELETE FROM S_OT_PARAMS'
      'WHERE id = :OLD_ID')
    Left = 762
    Top = 688
  end
  object s_obortypeglob_look: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.del'
      'FROM s_obortypeglob s'
      'WHERE s.id > 0'
      'and s.del = '#39'-'#39
      'ORDER BY s.Name_r')
    Left = 347
    Top = 744
    object s_obortypeglob_lookID: TIntegerField
      FieldName = 'ID'
    end
    object s_obortypeglob_lookNAME_R: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
      Size = 30
    end
    object s_obortypeglob_lookDEL: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
  end
  object s_object_lookup: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    RequestLive = True
    SQL.Strings = (
      'select id, name_r, id_attach, id_revs,del'
      'from s_object'
      'where ( id>0 )'
      'order by name_r')
    Left = 184
    Top = 744
    object IntegerField9: TIntegerField
      FieldName = 'ID'
    end
    object StringField14: TStringField
      FieldName = 'NAME_R'
      Size = 40
    end
    object IntegerField10: TIntegerField
      FieldName = 'ID_ATTACH'
    end
    object StringField15: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
    object StringField16: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_ATTACH'
      LookupDataSet = qry_ObjAtt
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_ATTACH'
      Size = 25
      Lookup = True
    end
    object SmallintField1: TSmallintField
      FieldName = 'ID_REVS'
    end
    object StringField17: TStringField
      FieldKind = fkLookup
      FieldName = 'look_revs'
      LookupDataSet = S_Revs_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_REVS'
      Lookup = True
    end
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 880
    Top = 64
  end
  object ibds_soorug: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = IBTransaction1
    AfterEdit = ibds_soorugAfterEdit
    DeleteSQL.Strings = (
      'DELETE FROM S_soorug'
      'WHERE id = :OLD_ID')
    InsertSQL.Strings = (
      'INSERT INTO S_soorug (name_r, id_object )'
      'VALUES (:name_r, :id_object)')
    SelectSQL.Strings = (
      'SELECT s.id, s.Name_r,  s.id_object,s.del '
      ', (select name_r from s_object where id = s.id_object ) name_o'
      'FROM s_soorug s'
      'WHERE s.id > 0'
      'ORDER BY s.Name_r')
    ModifySQL.Strings = (
      'UPDATE S_soorug'
      'SET  name_r = :name_r'
      ', id_object = :id_object'
      ', del = :del'
      'WHERE id = :id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_SOORUG'
    Left = 880
    Top = 112
    object ibds_soorugID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_SOORUG.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ibds_soorugNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_SOORUG.NAME_R'
      FixedChar = True
      Size = 64
    end
    object ibds_soorugID_OBJECT: TIntegerField
      FieldName = 'ID_OBJECT'
      Origin = 'S_SOORUG.ID_OBJECT'
    end
    object ibds_soorugDEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_SOORUG.DEL'
      FixedChar = True
      Size = 1
    end
    object ibds_soorugNAME_O: TIBStringField
      FieldName = 'NAME_O'
      ProviderFlags = []
      Size = 40
    end
    object ibds_sooruglook_object: TStringField
      FieldKind = fkLookup
      FieldName = 'look_object'
      LookupDataSet = s_object_lookup
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_OBJECT'
      Size = 60
      Lookup = True
    end
  end
  object ibdset_tmp: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = IBTransaction1
    Left = 808
    Top = 8
  end
  object qry_ObjAtt12: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id, name_r'
      'from s_attach'
      'where id in (1,2)'
      'order by name_r')
    Left = 920
    Top = 288
    object IntegerField11: TIntegerField
      FieldName = 'ID'
    end
    object StringField18: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
      Size = 25
    end
  end
  object s_mat_column: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    Filtered = True
    RequestLive = True
    SQL.Strings = (
      'SELECT s.id, s.Name_r, s.ed_izm, s.diampresent, s.del'
      'FROM s_mat s'
      'WHERE s.del in ('#39'-'#39','#39'd'#39') and s.id > 0'
      'ORDER BY s.Name_r, s.ed_izm')
    UpdateObject = s_mat_column_upd
    Left = 1000
    Top = 112
    object IntegerField12: TIntegerField
      FieldName = 'ID'
    end
    object StringField19: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
    end
    object StringField20: TStringField
      FieldName = 'ED_IZM'
      FixedChar = True
      Size = 10
    end
    object IntegerField13: TIntegerField
      FieldName = 'DIAMPRESENT'
    end
    object StringField21: TStringField
      FieldKind = fkLookup
      FieldName = 'ListDIAMPRESENT'
      LookupDataSet = TBL_const_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'DIAMPRESENT'
      Lookup = True
    end
    object StringField22: TStringField
      FieldName = 'DEL'
      FixedChar = True
      Size = 1
    end
  end
  object s_mat_column_sur: TDataSource
    DataSet = s_mat_column
    Left = 1008
    Top = 128
  end
  object s_mat_column_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE S_Mat'
      'SET  name_r = :name_r,'
      '         ed_izm = :ed_izm,'
      '         diampresent = :diampresent, '
      '         del = :del'
      'WHERE id = :id')
    InsertSQL.Strings = (
      'INSERT INTO S_Mat (name_r, ed_izm, diampresent)'
      'VALUES (:name_r, :ed_izm, :diampresent)')
    DeleteSQL.Strings = (
      'DELETE FROM S_Mat'
      'WHERE id = :OLD_ID')
    Left = 1016
    Top = 144
  end
end
