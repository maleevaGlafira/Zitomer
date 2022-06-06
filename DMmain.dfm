object DM_main: TDM_main
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Left = 529
  Top = 278
  Height = 326
  Width = 388
  object IBDatabase: TIBDatabase
    DatabaseName = 'E:\homework\zitomer\base\'#1077'210727\AVARZHYTOMYR.GDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    SQLDialect = 1
    Left = 16
    Top = 16
  end
  object IBDB_AvrImage: TIBDatabase
    LoginPrompt = False
    SQLDialect = 1
    Left = 24
    Top = 120
  end
  object dset_ZavAdres: TIBDataSet
    SelectSQL.Strings = (
      'select adres      '
      'from get_zav_adres( :pZavID )')
    Left = 32
    Top = 208
  end
  object ds_count: TIBDataSet
    Database = IBDB_AvrImage
    Transaction = IBTran_image
    Left = 112
    Top = 208
  end
  object IBTran_image: TIBTransaction
    DefaultDatabase = IBDB_AvrImage
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 104
    Top = 120
  end
  object dset_shift: TIBDataSet
    Database = IBDatabase
    SelectSQL.Strings = (
      'select SHIFTDATE, SHIFTNUMBER, SHIFTTYPE from SERVANTTABLE')
    Left = 200
    Top = 208
  end
  object dset_shiftnum: TIBDataSet
    Database = IBDatabase
    SelectSQL.Strings = (
      
        'select z.nomer, z.dt_in,sa.name_r  from narad n join  zavjav z o' +
        'n n.id_zav=z.id'
      
        'join s_attach sa on  sa.id=z.id_alien where n.dt_in>:d-1 and  n.' +
        'dt_in<:d and n.dt_out is null'
      'and z.id_attach in (:ida1,:ida2)'
      'union'
      
        'select z.nomer, z.dt_in,sa.name_r  from nnarad n join  nzavjav z' +
        ' on n.id_zav=z.id'
      
        'join s_attach sa on sa.id=z.id_alien where n.dt_in>:d-1 and  n.d' +
        't_in<:d and n.dt_out is null'
      'and z.id_attach in (:ida1,:ida2)')
    Left = 304
    Top = 200
  end
  object dset_DateTime: TIBDataSet
    Database = IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select current_Timestamp curTime from rdb$database')
    Left = 264
    Top = 72
  end
  object tran: TIBTransaction
    DefaultDatabase = IBDatabase
    Left = 184
    Top = 40
  end
  object dset_users: TIBDataSet
    Database = IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      
        'select  name_r from s_brig b where b.uid is not null and b.prava' +
        ' is not null and b.sys_password is not null'
      'order by name_r')
    Left = 240
    Top = 144
  end
end
