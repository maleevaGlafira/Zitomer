object dm_Shift: Tdm_Shift
  OldCreateOrder = False
  Left = 192
  Top = 124
  Height = 511
  Width = 648
  object dset_shift: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      
        'select  id, SHIFTNAME,SHIFTDATE, SHIFTNUMBER, trim(SHIFTTYPE) SH' +
        'IFTTYPE from SERVANTTABLE where activity is null')
    Left = 64
    Top = 32
  end
  object dset_shiftnum: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      
        'select z.nomer, z.dt_in,sa.name_r  from narad n join  zavjav z o' +
        'n n.id_zav=z.id'
      
        'join s_attach sa on  sa.id=z.id_alien where n.dt_in>:dat and  n.' +
        'dt_in<:dat+1 and n.dt_out is null'
      'and z.id_attach in (:ida1,:ida2)'
      'union'
      
        'select z.nomer, z.dt_in,sa.name_r  from nnarad n join  nzavjav z' +
        ' on n.id_zav=z.id'
      
        'join s_attach sa on sa.id=z.id_alien where n.dt_in>:dat and  n.d' +
        't_in<:dat+1 and n.dt_out is null'
      'and z.id_attach in (:ida1,:ida2)')
    Left = 136
    Top = 32
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 368
    Top = 72
  end
  object dsetShifts: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      
        'select trim(shiftname) shiftname,id from servanttable where acti' +
        'vity is null ')
    Left = 184
    Top = 160
  end
  object dset_idshiftZav: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      
        'select sr.id_shift id_shift from zavjav z join s_revs sr on sr.i' +
        'd=z.id_revs'
      'where z.id=:id_zav'
      'union'
      
        'select sr.id_shift id_shift from nzavjav z join s_revs sr on sr.' +
        'id=z.id_revs'
      'where z.id=:id_zav')
    Left = 352
    Top = 272
  end
  object dset_shiftRevs: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select id_shift from s_revs sr where sr.id=:id_revs')
    Left = 440
    Top = 280
  end
end
