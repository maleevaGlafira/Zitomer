object DM_VedManager: TDM_VedManager
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 475
  Top = 319
  Height = 292
  Width = 322
  object frReportVed: TfrReport
    Dataset = frDBDataSet1
    InitialZoom = pzDefault
    ModalPreview = False
    ModifyPrepared = False
    PreviewButtons = [pbZoom, pbPrint, pbFind, pbExit]
    RebuildPrinter = False
    OnGetValue = frReportVedGetValue
    Left = 24
    Top = 8
    ReportForm = {19000000}
  end
  object Qry_tmp: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select  z.nomer, r.ul_kod kod_ul,z.dt_in z_dt_in,'
      '(select name_r from s_owner'
      ' where z.id_alien=s_owner.id) as own,'
      ' z.id_alien, r.id_ul1, r.id_ul2,'
      ' sd.name_r xar_povr,dm.diam dm_diam,'
      ' (select rtrim(u.name_r)||" "||rtrim(v.name_r)'
      '  from s_ulic u,s_vidul v'
      
        '  where (u.del in ('#39'-'#39','#39'd'#39')) and (u.id_vidul>-2) and (u.id_vidul' +
        '=v.id)'
      '   and (u.id=r.id_ul1)) as ul1,'
      '  dop_adr, id_dopadres,'
      '  r.dt_in r_dt_in, r.dt_out r_dt_out, r.dt_rec r_dt_rec'
      '  from nzavjav z,s_diam dm, s_sod sd, raskop r'
      '  where (delz=0) and (z.id=r.id_zavin) and (dm.id=z.id_diam) and'
      
        '  (z.dt_in>='#39'01.01.2005 00:24:56'#39') and (z.dt_out<='#39'25.07.2005 10' +
        ':24:56'#39') and'
      '  (z.id_sod=sd.id)'
      ''
      'union'
      ''
      '    select z.nomer, r.ul_kod kod_ul,z.dt_in z_dt_in,'
      '    (select name_r from s_owner'
      '     where z.id_alien=s_owner.id) as own,'
      '     z.id_alien, r.id_ul1, r.id_ul2,'
      '     sd.name_r xar_povr,dm.diam dm_diam,'
      '     (select rtrim(u.name_r)||" "||rtrim(v.name_r)'
      '      from s_ulic u,s_vidul v'
      
        '      where (u.del in ('#39'-'#39','#39'd'#39')) and (u.id_vidul>-2) and (u.id_v' +
        'idul=v.id)'
      '       and (u.id=r.id_ul1)) as ul1,'
      '      dop_adr, id_dopadres,'
      '      r.dt_in r_dt_in, r.dt_out r_dt_out, r.dt_rec r_dt_rec'
      '      from zavjav z,s_diam dm, s_sod sd, raskop r'
      
        '      where (delz=0) and (z.id=r.id_zavin) and (dm.id=z.id_diam)' +
        ' and'
      
        '      (z.dt_in>='#39'01.01.2005 00:24:56'#39') and (z.dt_out<='#39'25.07.200' +
        '5 10:24:56'#39') and'
      '      (z.id_sod=sd.id)'
      ''
      'order by 4,1,3')
    Left = 152
    Top = 8
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = dset_tmp
    Left = 96
    Top = 8
  end
  object Qry_Tmp_Sub: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id from s_owner')
    Left = 176
    Top = 56
  end
  object frDBDataSet2: TfrDBDataSet
    DataSet = Qry_Tmp_Sub
    Left = 96
    Top = 56
  end
  object Qry_Ul2: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select rtrim(u.name_r)||" "||rtrim(v.name_r)  as ul2'
      ' from s_ulic u,s_vidul v'
      
        ' where (u.del in ('#39'-'#39','#39'd'#39')) and (u.id_vidul>-2) and (u.id_vidul=' +
        'v.id)'
      ' and (u.id=:id_ul2)')
    Left = 200
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id_ul2'
        ParamType = ptUnknown
      end>
  end
  object dset_tmp: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select  z.nomer, r.ul_kod kod_ul,z.dt_in z_dt_in,'
      '(select name_r from s_owner'
      ' where z.id_alien=s_owner.id) as own,'
      ' z.id_alien, r.id_ul1, r.id_ul2,'
      ' sd.name_r xar_povr,dm.diam dm_diam,'
      ' (select rtrim(u.name_r)||" "||rtrim(v.name_r)'
      '  from s_ulic u,s_vidul v'
      
        '  where (u.del in ('#39'-'#39','#39'd'#39')) and (u.id_vidul>-2) and (u.id_vidul' +
        '=v.id)'
      '   and (u.id=r.id_ul1)) as ul1,'
      '  dop_adr, id_dopadres,'
      '  r.dt_in r_dt_in, r.dt_out r_dt_out, r.dt_rec r_dt_rec'
      '  from nzavjav z,s_diam dm, s_sod sd, raskop r'
      '  where (delz=0) and (z.id=r.id_zavin) and (dm.id=z.id_diam) and'
      
        '  (z.dt_in>='#39'01.01.2005 00:24:56'#39') and (z.dt_out<='#39'25.07.2005 10' +
        ':24:56'#39') and'
      '  (z.id_sod=sd.id)'
      ''
      'union'
      ''
      '    select z.nomer, r.ul_kod kod_ul,z.dt_in z_dt_in,'
      '    (select name_r from s_owner'
      '     where z.id_alien=s_owner.id) as own,'
      '     z.id_alien, r.id_ul1, r.id_ul2,'
      '     sd.name_r xar_povr,dm.diam dm_diam,'
      '     (select rtrim(u.name_r)||" "||rtrim(v.name_r)'
      '      from s_ulic u,s_vidul v'
      
        '      where (u.del in ('#39'-'#39','#39'd'#39')) and (u.id_vidul>-2) and (u.id_v' +
        'idul=v.id)'
      '       and (u.id=r.id_ul1)) as ul1,'
      '      dop_adr, id_dopadres,'
      '      r.dt_in r_dt_in, r.dt_out r_dt_out, r.dt_rec r_dt_rec'
      '      from zavjav z,s_diam dm, s_sod sd, raskop r'
      
        '      where (delz=0) and (z.id=r.id_zavin) and (dm.id=z.id_diam)' +
        ' and'
      
        '      (z.dt_in>='#39'01.01.2005 00:24:56'#39') and (z.dt_out<='#39'25.07.200' +
        '5 10:24:56'#39') and'
      '      (z.id_sod=sd.id)'
      ''
      'order by 4,1,3')
    Left = 72
    Top = 128
  end
  object tran: TIBTransaction
    Active = True
    DefaultDatabase = DM_main.IBDatabase
    Left = 16
    Top = 128
  end
  object dset_ul2: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select rtrim(u.name_r)||" "||rtrim(v.name_r)  as ul2'
      ' from s_ulic u,s_vidul v'
      
        ' where (u.del in ('#39'-'#39','#39'd'#39')) and (u.id_vidul>-2) and (u.id_vidul=' +
        'v.id)'
      ' and (u.id=:id_ul2)')
    Left = 128
    Top = 128
  end
  object dset_Tmp_Sub: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select id from s_owner')
    Left = 80
    Top = 192
  end
end
