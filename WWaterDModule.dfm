object DM_WWater: TDM_WWater
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Left = 525
  Top = 380
  Height = 236
  Width = 406
  object tran_tmp: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 16
    Top = 8
  end
  object dset_src: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_tmp
    SelectSQL.Strings = (
      'select 1 zav_type, z.id, z.dt_in, z.dt_out, z.nomer,'
      
        '(select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_ad' +
        'r,z.id_dopadres)) adres,'
      
        '(select rtrim(ss.name_r)||'#39'('#39'||rtrim(st.name_r)||'#39','#39'||rtrim(sp.n' +
        'ame_r)||'#39')'#39
      '    from s_sod ss'
      '    left join s_tzav st on (st.id=ss.ftype)'
      '    left join s_place sp on (sp.id=ss.place_type)'
      '    where ss.id=z.id_sod) sod'
      'from nzavjav z'
      'where (delz=0)'
      'and exists(select id from wwater where id_zav=z.id)'
      'and z.dt_in>:pDt1 and z.dt_in<=:pDt2'
      'and z.id_attach=:pAtt'
      'union all'
      'select 2 zav_type, z.id, z.dt_in, z.dt_out, z.nomer,'
      
        '(select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_ad' +
        'r,z.id_dopadres)) adres,'
      
        '(select rtrim(ss.name_r)||'#39'('#39'||rtrim(st.name_r)||'#39','#39'||rtrim(sp.n' +
        'ame_r)||'#39')'#39
      '    from s_sod ss'
      '    left join s_tzav st on (st.id=ss.ftype)'
      '    left join s_place sp on (sp.id=ss.place_type)'
      '    where ss.id=z.id_sod) sod'
      'from zavjav z'
      'where (delz=0)'
      'and exists(select id from wwater where id_zav=z.id)'
      'and z.dt_in>:pDt1 and z.dt_in<=:pDt2'
      'and z.id_attach=:pAtt'
      'order by 1, 3')
    Left = 16
    Top = 120
  end
  object qry_Detail: TIBQuery
    Database = DM_main.IBDatabase
    Transaction = tran_tmp
    DataSource = ds_main
    SQL.Strings = (
      'select w.comment,'
      '    (select rtrim(sul.name_r)||" "||rtrim(svul.name_r)'
      '    from s_ulic sul,s_vidul svul'
      '    where (sul.id_vidul>-2) and (sul.id_vidul=svul.id)'
      '    and (sul.id=w.id_ul))||", "||w.house ww_adres'
      'from wwater w'
      'where w.id_zav=:id')
    Left = 280
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object ds_main: TDataSource
    DataSet = md_main
    Left = 128
    Top = 16
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbPrint, pbFind, pbExit]
    RebuildPrinter = False
    Left = 8
    Top = 56
    ReportForm = {19000000}
  end
  object frDS_Main: TfrDBDataSet
    DataSet = md_main
    Left = 128
    Top = 72
  end
  object frDS_Detail: TfrDBDataSet
    DataSet = qry_Detail
    Left = 280
    Top = 72
  end
  object md_main: TRxMemoryData
    FieldDefs = <>
    Left = 192
    Top = 16
    object md_mainzav_type: TIntegerField
      FieldName = 'zav_type'
    end
    object md_mainid: TIntegerField
      FieldName = 'id'
    end
    object md_maindt_in: TDateTimeField
      FieldName = 'dt_in'
    end
    object md_maindt_out: TDateTimeField
      FieldName = 'dt_out'
    end
    object md_mainnomer: TIntegerField
      FieldName = 'nomer'
    end
    object md_mainadres: TStringField
      FieldName = 'adres'
      Size = 100
    end
    object md_mainsod: TStringField
      FieldName = 'sod'
      Size = 50
    end
    object md_mainmaingr: TIntegerField
      FieldName = 'maingr'
    end
    object md_mainwwater_time: TStringField
      FieldName = 'wwater_time'
    end
  end
  object dset_tmp: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_tmp
    Left = 136
    Top = 144
  end
end
