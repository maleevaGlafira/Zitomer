object DM_Zavv: TDM_Zavv
  OldCreateOrder = False
  Left = 396
  Top = 125
  Height = 597
  Width = 592
  object Qry_LastViezdCloseDate: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select max(dt_in) max_dt_in,'
      ' max(dt_out) max_dt_out,'
      ' max(dt_dep) max_dt_dep'
      'from nnarad'
      'where id_zav=:id_zav')
    Left = 44
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id_zav'
        ParamType = ptUnknown
      end>
  end
  object s_matpipe: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT s.id, s.name_r, s.del'
      'FROM s_matpipe s'
      '/*WHERE s.id > 0*/'
      'ORDER BY s.name_r')
    Left = 424
    Top = 320
  end
  object DS_zav: TDataSource
    DataSet = Qry_zav
    Left = 134
    Top = 182
  end
  object Qry_zav: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r '
      'from s_zav '
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r')
    Left = 126
    Top = 178
  end
  object Qry_Zajav: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 424
    Top = 384
  end
  object DS_ul2: TDataSource
    DataSet = Qry_ul2
    Left = 240
    Top = 92
  end
  object Qry_ul2: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'select u.id id, rtrim(u.name_r)||" "||rtrim(v.name_r) as name_r,' +
        'u.orint  ,ID_RAYON'
      'from s_ulic u,s_vidul v'
      'where u.del in ('#39'-'#39','#39'd'#39') and (u.id_vidul=v.id)'
      'or ((u.id_vidul=-1) and (u.id_vidul=v.id))'
      'order by u.name_r')
    Left = 224
    Top = 80
  end
  object DS_ul1: TDataSource
    DataSet = Qry_ul1
    Left = 184
    Top = 88
  end
  object Qry_ul1: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'select u.id id, rtrim(u.name_r)||" "||rtrim(v.name_r) as name_r,' +
        'u.orint  ,ID_RAYON'
      'from s_ulic u,s_vidul v'
      'where u.del in ('#39'-'#39','#39'd'#39') and (u.id_vidul=v.id)'
      'or ((u.id_vidul=-1) and (u.id_vidul=v.id))'
      'order by u.name_r')
    Left = 172
    Top = 80
  end
  object DS_tzav: TDataSource
    DataSet = Qry_tzav
    Left = 188
    Top = 184
  end
  object Qry_tzav: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r,isviezd '
      'from s_tzav '
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r')
    Left = 180
    Top = 176
  end
  object Qry_tmp2: TQuery
    DatabaseName = 'DBN_AVAR'
    RequestLive = True
    Left = 84
    Top = 500
  end
  object Qry_tmp: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 16
    Top = 500
  end
  object DS_sod: TDataSource
    DataSet = Qry_sod
    Left = 432
    Top = 24
  end
  object Qry_sod: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id, name_r, diampresent'
      'from s_sod'
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r')
    Left = 420
    Top = 12
  end
  object DS_raon: TDataSource
    DataSet = Qry_Raon
    Left = 132
    Top = 88
  end
  object Qry_Raon: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r '
      'from s_rayon '
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r'
      '')
    Left = 120
    Top = 76
  end
  object DS_place: TDataSource
    DataSet = Qry_place
    Left = 436
    Top = 273
  end
  object Qry_place: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r '
      'from s_place  '
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r')
    Left = 428
    Top = 268
  end
  object DS_owner: TDataSource
    DataSet = Qry_owner
    Left = 436
    Top = 84
  end
  object Qry_owner: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select * '
      'from s_owner'
      'where del in ('#39'-'#39','#39'd'#39')'
      'and (attach=1 or attach=100)'
      'order by name_r')
    Left = 424
    Top = 76
  end
  object DS_mest: TDataSource
    DataSet = Qry_mest
    Left = 424
    Top = 137
  end
  object Qry_mest: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r,VOSST_POKRYT '
      'from s_mest  '
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r')
    Left = 436
    Top = 144
  end
  object DS_diamZ: TDataSource
    DataSet = Qry_diamZ
    Left = 494
    Top = 330
  end
  object Qry_diamZ: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT d.id, d.diam, cast(diam as char(5)) as diam_str, d.del'
      'FROM s_diam d'
      'WHERE d.del in ('#39'-'#39','#39'd'#39')'
      'ORDER BY d.diam')
    Left = 485
    Top = 322
  end
  object DS_Damg: TDataSource
    DataSet = Qry_Damg
    Left = 436
    Top = 212
  end
  object Qry_Damg: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r '
      'from s_damg '
      'where del in ('#39'-'#39','#39'd'#39') '
      'and ((place_type=:place_type) or (:place_type <= 0))'
      'order by name_r')
    Left = 424
    Top = 200
    ParamData = <
      item
        DataType = ftInteger
        Name = 'place_type'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'place_type'
        ParamType = ptInput
      end>
  end
  object DS_comment: TDataSource
    DataSet = Qry_comment
    Left = 270
    Top = 22
  end
  object Qry_comment: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r , ID_OBORTYPEGLOB'
      'from s_sod'
      'where (del in ('#39'-'#39','#39'd'#39')) '
      'order by name_r')
    Left = 262
    Top = 10
  end
  object Qry_Brig1: TQuery
    DatabaseName = 'dbn_avar'
    SQL.Strings = (
      'select id,name_r,name_r||" "||dolgn name '
      'from s_brig'
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r')
    Left = 192
    Top = 12
  end
  object DS_Brig: TDataSource
    DataSet = Qry_Brig
    Left = 136
    Top = 8
  end
  object Qry_Brig: TQuery
    DatabaseName = 'dbn_avar'
    SQL.Strings = (
      'select id,name_r,name_r||" "||dolgn name '
      'from s_brig'
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r')
    Left = 152
    Top = 20
  end
  object ds_matpipe: TDataSource
    DataSet = s_matpipe
    Left = 436
    Top = 334
  end
  object Qry_Map: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 16
    Top = 192
  end
  object Qry_sdal: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,rtrim(name_r)||"  ["||rtrim(dolgn)||"]" name_r  '
      'from s_brig'
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r'
      ''
      '')
    Left = 16
    Top = 256
  end
  object ds_sdal: TDataSource
    DataSet = Qry_sdal
    Left = 24
    Top = 280
  end
  object Qry_poluch: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,rtrim(name_r)||"  ["||rtrim(dolgn)||"]" name_r  '
      'from s_brig'
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r'
      ''
      ''
      '')
    Left = 16
    Top = 336
  end
  object ds_poluch: TDataSource
    DataSet = Qry_poluch
    Left = 32
    Top = 352
  end
  object Qry_revs: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r '
      'from s_revs '
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r'
      ''
      '')
    Left = 20
    Top = 60
  end
  object ds_revs: TDataSource
    DataSet = Qry_revs
    Left = 36
    Top = 72
  end
  object qry_vrk: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      '/*select vrk.id,'
      'cast('
      '(select rtrim(u.name_r)||" "||rtrim(vid.name_r)||", "||'
      '    rtrim(vrk.num_dom)'
      'from s_ulic u'
      'left join s_vidul vid on vid.id=u.id_vidul'
      'where u.id=vrk.id_ulic)||"("||rtrim(sy.name_r)||")"'
      'as varchar(100)) name_r'
      'from vrk'
      'left join s_yesno sy on sy.id=vrk.oplacheno'
      'where vrk.del in ('#39'-'#39', '#39'd'#39')'
      'order by 2'
      '*/'
      ''
      'select vrk.id,'
      'cast('
      ' ('
      
        '  select rtrim(u.name_r)||" "||rtrim(vid.name_r)||", "||rtrim(vr' +
        'k.num_dom)||'
      '    "("||rtrim(vrk.n_vrk)||")"'
      '    from s_ulic u'
      '  left join s_vidul vid on vid.id=u.id_vidul'
      '  where u.id=vrk.id_ulic)'
      '  as varchar(100)'
      ' ) name_r'
      'from vrk'
      'order by 2')
    Left = 16
    Top = 120
  end
  object ds_vrk: TDataSource
    DataSet = qry_vrk
    Left = 24
    Top = 136
  end
  object qry_DopAdres: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r '
      'from s_DopAdres '
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r'
      '')
    Left = 280
    Top = 80
  end
  object ds_DopAdres: TDataSource
    DataSet = qry_DopAdres
    Left = 296
    Top = 96
  end
  object ds_Object: TDataSource
    DataSet = qry_Object
    Left = 136
    Top = 248
  end
  object qry_Object: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id, name_r'
      'from s_object'
      'where ( del in ('#39'-'#39','#39'd'#39') )'
      'and ( id_attach = :pAttachID )'
      'order by name_r')
    Left = 120
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pAttachID'
        ParamType = ptUnknown
      end>
  end
  object ds_soorug: TDataSource
    DataSet = qry_soorug
    Left = 208
    Top = 248
  end
  object qry_soorug: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id, name_r, id_object'
      'from s_soorug'
      'where ( del = '#39'-'#39' )'
      'and (  id_object = :pObjectID or ( id = -1 ))'
      'order by name_r')
    Left = 192
    Top = 232
    ParamData = <
      item
        DataType = ftInteger
        Name = 'pObjectID'
        ParamType = ptInput
      end>
  end
  object IBQ_tmp: TIBQuery
    Database = DM_main.IBDatabase
    Transaction = IBTransaction1
    Left = 176
    Top = 480
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Left = 248
    Top = 480
  end
  object Qry_podpor: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      ' select id, name, del from s_podpor ')
    Left = 440
    Top = 448
  end
  object ds_podpor: TDataSource
    DataSet = Qry_podpor
    Left = 440
    Top = 472
  end
  object qry_settlers: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'select  id, name_s from s_setlers  where del in ('#39'-'#39') order by n' +
        'ame_s')
    Left = 168
    Top = 392
  end
  object ds_settlers: TDataSource
    DataSet = qry_settlers
    Left = 216
    Top = 416
  end
end
