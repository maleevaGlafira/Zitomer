object dm_OtlNaradList: Tdm_OtlNaradList
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Left = 308
  Top = 241
  Height = 246
  Width = 316
  object tran: TIBTransaction
    Active = True
    DefaultDatabase = DM_main.IBDatabase
    Left = 16
    Top = 8
  end
  object IBSQL_main: TIBSQL
    Database = DM_main.IBDatabase
    SQL.Strings = (
      
        ' insert into  LINKOTLORDER (id_zavjav,id_otlzavjav)  values (:id' +
        '_zav, :id_otlnar)')
    Transaction = tran
    Left = 32
    Top = 88
  end
  object dset: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select z.nomer,   z.dt_in, z.id ,z.id_revs ,'
      
        '(select trim(sr.name_r) from  s_revs sr where sr.id=z.id_revs) r' +
        'ev ,'
      
        '(select adres  from get_adres(z.id_ul1,z.id_ul2, z.kod_ul, z.dop' +
        '_adr, z.id_dopadres) ) adres,'
      '(select sp.name_r from s_place sp where sp.id=z.id_place) place'
      ' from nzavjav z where z.id_attach =:id_atach'
      ' and z.is_otl=1 and z.id<>:id_zav'
      ' order by z.id_revs, adres')
    Left = 72
    Top = 8
    object dsetID: TIntegerField
      FieldName = 'ID'
      Origin = 'NZAVJAV.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dsetNOMER: TIntegerField
      FieldName = 'NOMER'
      Origin = 'NZAVJAV.NOMER'
    end
    object dsetDT_IN: TDateTimeField
      FieldName = 'DT_IN'
      Origin = 'NZAVJAV.DT_IN'
    end
    object dsetREV: TIBStringField
      FieldName = 'REV'
      ProviderFlags = []
      Size = 25
    end
    object dsetADRES: TIBStringField
      FieldName = 'ADRES'
      ProviderFlags = []
      Size = 150
    end
    object dsetPLACE: TIBStringField
      FieldName = 'PLACE'
      ProviderFlags = []
      FixedChar = True
    end
    object dsetID_REVS: TIntegerField
      FieldName = 'ID_REVS'
      Origin = 'NZAVJAV.ID_REVS'
    end
  end
  object dset_linkorder: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      
        ' select id_otlzavjav  from LINKOTLORDER    where id_zavjav=:id_z' +
        'av'
      'and isactual is not null')
    Left = 144
    Top = 24
  end
  object memmain: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'nomer'
        DataType = ftInteger
      end
      item
        Name = 'DT_IN'
        DataType = ftDateTime
      end
      item
        Name = 'REV'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'adres'
        DataType = ftString
        Size = 300
      end
      item
        Name = 'place'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 144
    Top = 128
    object memmainid: TIntegerField
      FieldName = 'id'
    end
    object memmainmoner: TIntegerField
      FieldName = 'nomer'
    end
    object memmainDT_IN: TDateTimeField
      FieldName = 'DT_IN'
    end
    object memmainREV: TStringField
      FieldName = 'REV'
    end
    object memmainadres: TStringField
      FieldName = 'adres'
      Size = 300
    end
    object memmainplace: TStringField
      FieldName = 'place'
      Size = 50
    end
    object memmainid_revs: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'id_revs'
      Calculated = True
    end
  end
  object ibsql_del: TIBSQL
    Database = DM_main.IBDatabase
    SQL.Strings = (
      'delete from linkotlorder lo where lo.id_zavjav=:id_zav')
    Transaction = tran
    Left = 104
    Top = 88
  end
end
