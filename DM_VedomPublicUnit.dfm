object DM_VedomPublic: TDM_VedomPublic
  OldCreateOrder = False
  Left = 248
  Top = 118
  Height = 390
  Width = 317
  object frOLEExcelExport1: TfrOLEExcelExport
    ShowDialog = False
    OpenExcelAfterExport = True
    Left = 24
    Top = 16
  end
  object SD_Excel: TSaveDialog
    Filter = '*.xls|*.xls'
    Title = #1059#1082#1072#1078#1080#1090#1077' '#1080#1084#1103' '#1089#1086#1093#1088#1072#1085#1103#1077#1084#1086#1075#1086' '#1092#1072#1081#1083#1072' Excel'
    Left = 112
    Top = 16
  end
  object Qry_tmp: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 32
    Top = 88
  end
  object Qry_Zadv: TQuery
    OnCalcFields = Qry_ZadvCalcFields
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select '
      ' (select rtrim(u.name_r)||" "||rtrim(v.name_r)'
      '  from s_ulic u,s_vidul v'
      
        '  where (u.del in ('#39'-'#39','#39'd'#39')) and (u.id_vidul=v.id) and (u.id=zad' +
        'v.id_ul1)) as ul1,'
      'id_ul2,ul_kod,dop_adr, id_dopadres,'
      
        '    (select name_r from s_brig where s_brig.id=zadv.id_brin) bri' +
        'g_in,'
      
        '    (select name_r from s_brig where s_brig.id=zadv.id_brout) br' +
        'ig_out,'
      '    (select diam from s_diam where s_diam.id=zadv.id_diam) diam,'
      '    dt_in,dt_out, id_brin,id_brout'
      
        '    , (select name_r from s_object where id=zadv.id_object) objn' +
        'ame'
      
        '    , (select name_r from s_soorug where id=zadv.id_soorug) soor' +
        'ugname'
      
        '    , (select name_r from s_objobor where id=zadv.id_objobor) ob' +
        'joborname'
      '    , id_ul1, id_object, id_objobor'
      'from zadv'
      'where (id_zavin=:id_zav) or (id_zavout=:id_zav)')
    Left = 88
    Top = 88
    ParamData = <
      item
        DataType = ftInteger
        Name = 'id_zav'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'id_zav'
        ParamType = ptInput
      end>
    object Qry_Zadvaddr: TStringField
      FieldKind = fkCalculated
      FieldName = 'addr'
      Size = 255
      Calculated = True
    end
    object Qry_ZadvBRIG_IN: TStringField
      FieldName = 'BRIG_IN'
      FixedChar = True
      Size = 25
    end
    object Qry_ZadvBRIG_OUT: TStringField
      FieldName = 'BRIG_OUT'
      FixedChar = True
      Size = 25
    end
    object Qry_ZadvDT_IN: TDateTimeField
      FieldName = 'DT_IN'
    end
    object Qry_ZadvDT_OUT: TDateTimeField
      FieldName = 'DT_OUT'
    end
    object Qry_ZadvID_UL2: TStringField
      FieldName = 'ID_UL2'
      FixedChar = True
      Size = 10
    end
    object Qry_ZadvUL_KOD: TIntegerField
      FieldName = 'UL_KOD'
    end
    object Qry_ZadvDOP_ADR: TStringField
      FieldName = 'DOP_ADR'
      FixedChar = True
    end
    object Qry_ZadvUL1: TStringField
      FieldName = 'UL1'
      FixedChar = True
      Size = 80
    end
    object Qry_ZadvID_DOPADRES: TIntegerField
      FieldName = 'ID_DOPADRES'
    end
    object Qry_ZadvOBJNAME: TStringField
      FieldName = 'OBJNAME'
      Size = 40
    end
    object Qry_ZadvSOORUGNAME: TStringField
      FieldName = 'SOORUGNAME'
      FixedChar = True
      Size = 64
    end
    object Qry_ZadvOBJOBORNAME: TStringField
      FieldName = 'OBJOBORNAME'
      Size = 40
    end
    object Qry_Zadvcalc_ObjSoor: TStringField
      FieldKind = fkCalculated
      FieldName = 'calc_ObjSoor'
      Size = 120
      Calculated = True
    end
    object Qry_ZadvDIAM: TIntegerField
      FieldName = 'DIAM'
    end
    object Qry_ZadvID_UL1: TIntegerField
      FieldName = 'ID_UL1'
    end
    object Qry_ZadvID_OBJECT: TIntegerField
      FieldName = 'ID_OBJECT'
    end
    object Qry_ZadvID_BRIN: TIntegerField
      FieldName = 'ID_BRIN'
    end
    object Qry_ZadvID_BROUT: TIntegerField
      FieldName = 'ID_BROUT'
    end
    object Qry_ZadvID_OBJOBOR: TIntegerField
      FieldName = 'ID_OBJOBOR'
    end
  end
  object Qry_Raskop: TQuery
    OnCalcFields = Qry_ZadvCalcFields
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select '
      
        '    (select name_r from s_brig where s_brig.id=raskop.id_brin) b' +
        'rig_in,'
      
        '    (select name_r from s_brig where s_brig.id=raskop.id_brout) ' +
        'brig_out,'
      
        '    (select name_r from s_brig where s_brig.id=raskop.id_brrec) ' +
        'brrec,'
      '    dt_in,dt_out,dt_rec'
      'from raskop'
      'where (id_zavin=:id_zav) or (id_zavout=:id_zav)'
      'order by dt_in')
    Left = 152
    Top = 88
    ParamData = <
      item
        DataType = ftInteger
        Name = 'id_zav'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'id_zav'
        ParamType = ptInput
      end>
    object Qry_RaskopBRIG_IN: TStringField
      FieldName = 'BRIG_IN'
      FixedChar = True
      Size = 25
    end
    object Qry_RaskopBRIG_OUT: TStringField
      FieldName = 'BRIG_OUT'
      FixedChar = True
      Size = 25
    end
    object Qry_RaskopBRREC: TStringField
      FieldName = 'BRREC'
      FixedChar = True
      Size = 25
    end
    object Qry_RaskopDT_IN: TDateTimeField
      FieldName = 'DT_IN'
    end
    object Qry_RaskopDT_OUT: TDateTimeField
      FieldName = 'DT_OUT'
    end
    object Qry_RaskopDT_REC: TDateTimeField
      FieldName = 'DT_REC'
    end
  end
  object Qry_Peoples: TQuery
    OnCalcFields = Qry_ZadvCalcFields
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select s_brig.name_r brig_name, s_brig.dolgn brig_dolzhn'
      '  from nnarad nn'
      '    full join s_brig b on'
      '     (nn.id_zav in (select op.id_zav from ord_people op'
      
        '                where ((op.id_zav=:id_zav) and (op.add_people=b.' +
        'id))'
      '                 or (nn.id_brig=b.id)) )'
      'where (b.id>-1) and (nn.id_zav=:id_zav)'
      ''
      'union'
      ''
      'select s_brig.name_r brig_name, s_brig.dolgn brig_dolzhn'
      '  from narad n'
      '    full join s_brig b on'
      '     (n.id_zav in (select op.id_zav from ord_people op'
      
        '                where ((op.id_zav=:id_zav) and (op.add_people=b.' +
        'id))'
      '                 or (n.id_brig=b.id)) )'
      'where (b.id>-1) and (n.id_zav=:id_zav)')
    Left = 96
    Top = 144
    ParamData = <
      item
        DataType = ftInteger
        Name = 'id_zav'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'id_zav'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'id_zav'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'id_zav'
        ParamType = ptInput
      end>
    object Qry_PeoplesBRIG_NAME: TStringField
      FieldName = 'BRIG_NAME'
      FixedChar = True
      Size = 25
    end
    object Qry_PeoplesBRIG_DOLZHN: TStringField
      FieldName = 'BRIG_DOLZHN'
      FixedChar = True
    end
  end
  object Qry_Mats: TQuery
    OnCalcFields = Qry_ZadvCalcFields
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select sm.name_r MAT_NAME,'
      '  sm.ed_izm, m.KOL_MAT'
      'from MATERS m'
      ' left join S_MAT sm on (sm.id=m.id_mat)'
      'where (sm.id>-1) and (m.ID_ZAV=:id_zav)')
    Left = 32
    Top = 144
    ParamData = <
      item
        DataType = ftInteger
        Name = 'id_zav'
        ParamType = ptInput
      end>
    object Qry_MatsMAT_NAME: TStringField
      FieldName = 'MAT_NAME'
      FixedChar = True
    end
    object Qry_MatsED_IZM: TStringField
      FieldName = 'ED_IZM'
      FixedChar = True
      Size = 10
    end
    object Qry_MatsKOL_MAT: TFloatField
      FieldName = 'KOL_MAT'
    end
  end
  object Qry_Mexan: TQuery
    OnCalcFields = Qry_ZadvCalcFields
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select so.name_r'
      'from s_obor so, obors o'
      'where (so.id>-1) and (o.id_obor=so.id) and (o.id_zav=:id_zav)')
    Left = 152
    Top = 144
    ParamData = <
      item
        DataType = ftInteger
        Name = 'id_zav'
        ParamType = ptInput
      end>
    object Qry_MexanNAME_R: TStringField
      FieldName = 'NAME_R'
      FixedChar = True
      Size = 25
    end
  end
  object Qry_FirstViezdZadv: TQuery
    OnCalcFields = Qry_FirstViezdZadvCalcFields
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select '
      ' (select rtrim(u.name_r)||" "||rtrim(v.name_r)'
      '  from s_ulic u,s_vidul v'
      
        '  where (u.del in ('#39'-'#39','#39'd'#39')) and (u.id_vidul=v.id) and (u.id=zad' +
        'v.id_ul1)) as ul1,'
      'id_ul2,ul_kod,dop_adr, id_dopadres,'
      
        '    (select name_r from s_brig where s_brig.id=zadv.id_brin) bri' +
        'g_in,'
      
        '    (select name_r from s_brig where s_brig.id=zadv.id_brout) br' +
        'ig_out,'
      '    (select diam from s_diam where s_diam.id=zadv.id_diam) diam,'
      '    id_brout,'
      '    dt_in,dt_out'
      'from zadv'
      'where ((id_zavin=:pID_Zav) or (id_zavout=:pID_Zav))'
      'and Is_Pervich_Viezd=1'
      '')
    Left = 48
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pID_Zav'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'pID_Zav'
        ParamType = ptUnknown
      end>
    object Qry_FirstViezdZadvUL1: TStringField
      FieldName = 'UL1'
      Size = 161
    end
    object Qry_FirstViezdZadvID_UL2: TStringField
      FieldName = 'ID_UL2'
      FixedChar = True
      Size = 10
    end
    object Qry_FirstViezdZadvUL_KOD: TIntegerField
      FieldName = 'UL_KOD'
    end
    object Qry_FirstViezdZadvDOP_ADR: TStringField
      FieldName = 'DOP_ADR'
      FixedChar = True
    end
    object Qry_FirstViezdZadvBRIG_IN: TStringField
      FieldName = 'BRIG_IN'
      FixedChar = True
      Size = 25
    end
    object Qry_FirstViezdZadvBRIG_OUT: TStringField
      FieldName = 'BRIG_OUT'
      FixedChar = True
      Size = 25
    end
    object Qry_FirstViezdZadvDT_IN: TDateTimeField
      FieldName = 'DT_IN'
    end
    object Qry_FirstViezdZadvDT_OUT: TDateTimeField
      FieldName = 'DT_OUT'
    end
    object Qry_FirstViezdZadvadres: TStringField
      DisplayWidth = 100
      FieldKind = fkCalculated
      FieldName = 'adres'
      Size = 100
      Calculated = True
    end
    object Qry_FirstViezdZadvID_BROUT: TIntegerField
      FieldName = 'ID_BROUT'
    end
    object Qry_FirstViezdZadvdiam: TIntegerField
      FieldName = 'diam'
    end
    object Qry_FirstViezdZadvID_DOPADRES: TIntegerField
      FieldName = 'ID_DOPADRES'
    end
  end
  object Qry_NotFirstViezdZadv: TQuery
    OnCalcFields = Qry_FirstViezdZadvCalcFields
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select '
      ' (select rtrim(u.name_r)||" "||rtrim(v.name_r)'
      '  from s_ulic u,s_vidul v'
      
        '  where (u.del in ('#39'-'#39','#39'd'#39')) and (u.id_vidul=v.id) and (u.id=zad' +
        'v.id_ul1)) as ul1,'
      'id_ul2,ul_kod,dop_adr,id_dopadres,'
      
        '    (select name_r from s_brig where s_brig.id=zadv.id_brin) bri' +
        'g_in,'
      
        '    (select name_r from s_brig where s_brig.id=zadv.id_brout) br' +
        'ig_out,'
      '    (select diam from s_diam where s_diam.id=zadv.id_diam) diam,'
      '    id_brout,'
      '    dt_in,dt_out'
      'from zadv'
      'where ((id_zavin=:pID_Zav) or (id_zavout=:pID_Zav))'
      'and ((Is_Pervich_Viezd<>1) or (Is_Pervich_Viezd is null))')
    Left = 176
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pID_Zav'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'pID_Zav'
        ParamType = ptUnknown
      end>
    object StringField1: TStringField
      FieldName = 'UL1'
      Size = 161
    end
    object StringField2: TStringField
      FieldName = 'ID_UL2'
      FixedChar = True
      Size = 10
    end
    object IntegerField1: TIntegerField
      FieldName = 'UL_KOD'
    end
    object StringField3: TStringField
      FieldName = 'DOP_ADR'
      FixedChar = True
    end
    object StringField4: TStringField
      FieldName = 'BRIG_IN'
      FixedChar = True
      Size = 25
    end
    object StringField5: TStringField
      FieldName = 'BRIG_OUT'
      FixedChar = True
      Size = 25
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'DT_IN'
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'DT_OUT'
    end
    object StringField6: TStringField
      DisplayWidth = 100
      FieldKind = fkCalculated
      FieldName = 'adres'
      Size = 100
      Calculated = True
    end
    object IntegerField2: TIntegerField
      FieldName = 'ID_BROUT'
    end
    object Qry_NotFirstViezdZadvdiam: TIntegerField
      FieldName = 'diam'
    end
    object Qry_NotFirstViezdZadvid_dopadres: TIntegerField
      FieldName = 'id_dopadres'
    end
  end
  object Qry_narad: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select n.id,n.nomer,n.dt_in,n.dt_out,n.dop_inf ,'
      'n.id_brig , sb.name_r,sb.dolgn'
      'from narad n left  join s_brig  sb on sb.id=n.id_brig'
      '   where n.id_zav =:id_zav'
      'union '
      'select n.id,n.nomer,n.dt_in,n.dt_out,n.dop_inf,'
      'n.id_brig, sb.name_r,sb.dolgn'
      'from nnarad n  left  join s_brig  sb on sb.id=n.id_brig'
      ' where n.id_zav =:id_zav')
    Left = 40
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id_zav'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id_zav'
        ParamType = ptUnknown
      end>
  end
  object QryMaters: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'select sm.name_r, m.kol_mat, sm.ed_izm,m.id_diam, sd.diam from m' +
        'aters m left join s_mat sm on sm.id=m.id_mat'
      'left join s_diam sd on sd.id=m.id_diam'
      ' where m.id_nar=:id_nar')
    Left = 104
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id_nar'
        ParamType = ptUnknown
      end>
  end
  object QryWorks: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'select sw.name_r from works w left join s_work sw on sw.id=w.id_' +
        'work'
      ' where w.id_nar=:id_nar')
    Left = 160
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id_nar'
        ParamType = ptUnknown
      end>
  end
  object QryObor: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        ' select so.NAME_R_AND_FIO name_r from OBORS o left join mexan so' +
        ' on so.id=o.id_obor'
      ' where o.id_nar=:id_nar')
    Left = 208
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id_nar'
        ParamType = ptUnknown
      end>
  end
end
