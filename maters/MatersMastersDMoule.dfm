object dm_MatersMasters: Tdm_MatersMasters
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 577
  Top = 171
  Height = 631
  Width = 533
  object mem_main: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'num_year'
        DataType = ftInteger
      end
      item
        Name = 'num_month'
        DataType = ftInteger
      end
      item
        Name = 'kod'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'name'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Units'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'price'
        DataType = ftFloat
      end
      item
        Name = 'left'
        DataType = ftFloat
        Precision = 2
      end
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'info'
        DataType = ftMemo
        Size = 1000
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
    AfterScroll = mem_mainAfterScroll
    Left = 40
    Top = 32
    object mem_mainnum_year: TIntegerField
      FieldName = 'num_year'
    end
    object mem_mainnum_month: TIntegerField
      FieldName = 'num_month'
    end
    object mem_mainkod: TStringField
      FieldName = 'kod'
      Size = 15
    end
    object mem_mainname: TStringField
      FieldName = 'name'
      Size = 100
    end
    object mem_mainUnits: TStringField
      FieldName = 'Units'
      Size = 10
    end
    object mem_mainprice: TFloatField
      FieldName = 'price'
    end
    object mem_mainleft: TFloatField
      FieldName = 'left'
    end
    object mem_mainid: TIntegerField
      FieldName = 'id'
    end
    object mem_maininfo: TMemoField
      FieldName = 'info'
      BlobType = ftMemo
      Size = 1000
    end
    object mem_mainall_q: TFloatField
      FieldName = 'all_q'
    end
    object mem_mainis_storage: TBooleanField
      FieldName = 'is_storage'
    end
    object mem_mainfk_column: TIntegerField
      FieldName = 'fk_column'
    end
    object mem_mainname_col: TStringField
      FieldName = 'name_col'
      Size = 10
    end
  end
  object dset_reports: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_main
    OnCalcFields = dset_reportsCalcFields
    DeleteSQL.Strings = (
      'delete from matreports where id=:id')
    InsertSQL.Strings = (
      
        'insert into matreports (id,fk_id_brig, num_year, num_month,filen' +
        'ame) '
      'values (:id,:fk_id_brig,:num_year, :num_month,:filename)')
    RefreshSQL.Strings = (
      
        'select id, fk_id_brig, num_year, num_month, filename from matrep' +
        'orts'
      'where fk_id_brig=:id_brig'
      'order by num_year, num_month desc')
    SelectSQL.Strings = (
      
        'select id, fk_id_brig, num_year, num_month, filename from matrep' +
        'orts'
      'where fk_id_brig=:id_brig'
      'order by num_year, num_month desc')
    Filtered = True
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'gen_matrEPORTS'
    GeneratorField.ApplyEvent = gamOnPost
    Left = 216
    Top = 168
    object dset_reportsID: TIntegerField
      FieldName = 'ID'
      Origin = 'MATREPORTS.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_reportsFK_ID_BRIG: TIntegerField
      FieldName = 'FK_ID_BRIG'
      Origin = 'MATREPORTS.FK_ID_BRIG'
      Required = True
    end
    object dset_reportsNUM_YEAR: TSmallintField
      FieldName = 'NUM_YEAR'
      Origin = 'MATREPORTS.NUM_YEAR'
      Required = True
    end
    object dset_reportsNUM_MONTH: TSmallintField
      FieldName = 'NUM_MONTH'
      Origin = 'MATREPORTS.NUM_MONTH'
      Required = True
    end
    object dset_reportsFILENAME: TIBStringField
      FieldName = 'FILENAME'
      Origin = 'MATREPORTS.FILENAME'
      Size = 200
    end
    object dset_reportsshow_title: TStringField
      FieldKind = fkCalculated
      FieldName = 'show_title'
      Size = 100
      Calculated = True
    end
  end
  object dset_brigs: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_s
    SelectSQL.Strings = (
      
        'select id, trim(name_r)||'#39' ('#39'||trim(dolgn)||'#39')'#39', name_r  from s_' +
        'brig order by name_r ')
    Left = 192
    Top = 104
    object dset_brigsID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_BRIG.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_brigsCONCATENATION: TIBStringField
      FieldName = 'CONCATENATION'
      ProviderFlags = []
      Size = 203
    end
    object dset_brigsNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_BRIG.NAME_R'
      Size = 100
    end
  end
  object tran_main: TIBTransaction
    Active = True
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 120
    Top = 176
  end
  object dset_report_mats2: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_main
    DeleteSQL.Strings = (
      '')
    InsertSQL.Strings = (
      
        'insert into report_mats2 (id,fk_id_report, fk_id_mater, all_q, l' +
        'eft_q)'
      'values (:id,:fk_id_report, :fk_id_mater, :all_q, :left_q)')
    SelectSQL.Strings = (
      
        'select r.id, r.fk_id_report, r.fk_id_mater, all_q, left_q, sm.na' +
        'me_r, sm.kod,'
      
        'sm.units, sm.price, is_storage, r.fk_column, scol.name_r name_co' +
        'l'
      ' from report_mats2  r join s_mat2 sm on sm.id =r.fk_id_mater'
      'left join s_mat2_coumn scol on scol.id = r.fk_column'
      '  where fk_id_report=:id_report order by 6')
    ModifySQL.Strings = (
      'update report_mats2 set all_q=:all_q, left_q=left_q '
      'where id=:id and fk_id_mater=:fk_id_mater'
      '')
    Filtered = True
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'gen_rePORT_MATS2'
    GeneratorField.ApplyEvent = gamOnPost
    Left = 320
    Top = 176
    object dset_report_mats2ID: TIntegerField
      FieldName = 'ID'
      Origin = 'REPORT_MATS2.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_report_mats2FK_ID_REPORT: TIntegerField
      FieldName = 'FK_ID_REPORT'
      Origin = 'REPORT_MATS2.FK_ID_REPORT'
      Required = True
    end
    object dset_report_mats2FK_ID_MATER: TIntegerField
      FieldName = 'FK_ID_MATER'
      Origin = 'REPORT_MATS2.FK_ID_MATER'
      Required = True
    end
    object dset_report_mats2ALL_Q: TIBBCDField
      FieldName = 'ALL_Q'
      Origin = 'REPORT_MATS2.ALL_Q'
      Required = True
      Precision = 9
      Size = 3
    end
    object dset_report_mats2LEFT_Q: TIBBCDField
      FieldName = 'LEFT_Q'
      Origin = 'REPORT_MATS2.LEFT_Q'
      Precision = 9
      Size = 3
    end
    object dset_report_mats2NAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_MAT2.NAME_R'
      Size = 100
    end
    object dset_report_mats2KOD: TIBStringField
      FieldName = 'KOD'
      Origin = 'S_MAT2.KOD'
      Required = True
      Size = 15
    end
    object dset_report_mats2UNITS: TIBStringField
      FieldName = 'UNITS'
      Origin = 'S_MAT2.UNITS'
      Size = 10
    end
    object dset_report_mats2PRICE: TIBBCDField
      FieldName = 'PRICE'
      Origin = 'S_MAT2.PRICE'
      Required = True
      Precision = 9
      Size = 2
    end
    object dset_report_mats2IS_STORAGE: TSmallintField
      FieldName = 'IS_STORAGE'
      Origin = 'REPORT_MATS2.IS_STORAGE'
    end
    object dset_report_mats2FK_COLUMN: TIntegerField
      FieldName = 'FK_COLUMN'
      Origin = 'S_MAT2.FK_COLUMN'
    end
    object dset_report_mats2NAME_COL: TIBStringField
      FieldName = 'NAME_COL'
      Origin = 'S_MAT2_COUMN.NAME_R'
      Size = 15
    end
  end
  object tran_s: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Left = 112
    Top = 104
  end
  object tran_delete: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Left = 120
    Top = 232
  end
  object IBSQL_delete: TIBSQL
    Database = DM_main.IBDatabase
    Transaction = tran_delete
    Left = 208
    Top = 224
  end
  object IBSQL_add_row: TIBSQL
    Database = DM_main.IBDatabase
    SQL.Strings = (
      
        'execute procedure ADDROWMATERROPORT(:fk_id_report, :name_r, :kod' +
        ', :units, :price, :all_q, :is_storage,:fk_column)')
    Transaction = tran_main
    Left = 432
    Top = 168
  end
  object dset_deps: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_main
    Left = 216
    Top = 320
  end
  object mem_deps: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
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
    AfterScroll = mem_depsAfterScroll
    Left = 56
    Top = 320
    object mem_depsidn: TIntegerField
      FieldName = 'idn'
    end
    object mem_depsidz: TIntegerField
      FieldName = 'idz'
    end
    object mem_depsdt: TStringField
      FieldName = 'dt'
      Size = 40
    end
    object mem_depsaddress: TStringField
      FieldName = 'address'
      Size = 100
    end
    object mem_depsnomer: TStringField
      FieldName = 'nomer'
      Size = 14
    end
    object mem_depsdop_inf: TStringField
      FieldName = 'dop_inf'
      Size = 2000
    end
    object mem_depsnnomwe: TIntegerField
      FieldName = 'nnomer'
    end
    object mem_depsid_attach: TIntegerField
      FieldName = 'id_attach'
    end
  end
  object dep_depmater: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_main
    Left = 216
    Top = 416
  end
  object mem_depmaters: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
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
    Left = 40
    Top = 440
    object IntegerField1: TIntegerField
      FieldName = 'idn'
    end
    object StringField3: TStringField
      FieldName = 'nomer'
      Size = 14
    end
    object mem_depmaterskod: TStringField
      FieldName = 'kod'
      Size = 15
    end
    object mem_depmatersid_mater: TIntegerField
      FieldName = 'id_repmater'
    end
    object mem_depmatersname: TStringField
      FieldName = 'name'
      Size = 50
    end
    object mem_depmatersall_q: TFloatField
      FieldName = 'all_q'
    end
    object mem_depmatersid_report_mater: TIntegerField
      FieldName = 'id_report_mater'
    end
    object mem_depmatersid: TIntegerField
      FieldName = 'id'
    end
    object mem_depmatersid_zav: TIntegerField
      FieldName = 'id_zav'
    end
    object mem_depmatersprice: TFloatField
      FieldName = 'price'
    end
    object mem_depmatersunits: TStringField
      FieldName = 'units'
      Size = 10
    end
    object mem_depmatersreport_name: TStringField
      FieldName = 'report_name'
    end
    object mem_depmatersreport_our_name: TStringField
      FieldName = 'report_out_name'
    end
    object mem_depmatersis_his: TBooleanField
      FieldName = 'is_his'
    end
    object mem_depmatersFK_ID_REPORT: TIntegerField
      FieldName = 'FK_ID_REPORT'
    end
  end
  object tran_deps: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Left = 320
    Top = 424
  end
  object ibs_addmater: TIBSQL
    Database = DM_main.IBDatabase
    Transaction = tran_deps
    Left = 272
    Top = 504
  end
  object mem_materdep: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'id_mater'
        DataType = ftInteger
      end
      item
        Name = 'idn'
        DataType = ftInteger
      end
      item
        Name = 'nomer'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'nnomer'
        DataType = ftString
        Size = 10
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
    Left = 48
    Top = 520
    object mem_materdepid_mater: TIntegerField
      FieldName = 'id_mater'
    end
    object mem_materdepidn: TIntegerField
      FieldName = 'idn'
    end
    object mem_materdepnomer: TStringField
      FieldName = 'nomer'
    end
    object mem_materdepnnomer: TStringField
      FieldName = 'nnomer'
      Size = 10
    end
    object mem_materdepaddress: TStringField
      FieldName = 'address'
      Size = 100
    end
    object mem_materdepstartdt: TDateTimeField
      FieldName = 'startdt'
    end
    object mem_materdependdate: TDateTimeField
      FieldName = 'enddate'
    end
    object mem_materdepshowdate: TStringField
      FieldName = 'showdate'
      Size = 40
    end
  end
  object dset_materdep: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_main
    Left = 152
    Top = 520
  end
  object dset_brigs2: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_s
    AfterScroll = dset_brigs2AfterScroll
    SelectSQL.Strings = (
      
        'select id, trim(name_r)||'#39' ('#39'||trim(dolgn)||'#39')'#39', name_r  from s_' +
        'brig order by name_r ')
    Left = 304
    Top = 104
    object IntegerField2: TIntegerField
      FieldName = 'ID'
      Origin = 'S_BRIG.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object IBStringField1: TIBStringField
      FieldName = 'CONCATENATION'
      ProviderFlags = []
      Size = 203
    end
    object IBStringField2: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_BRIG.NAME_R'
      Size = 100
    end
  end
  object dset_out_reports: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_out_reports
    OnCalcFields = dset_out_reportsCalcFields
    InsertSQL.Strings = (
      
        ' insert into Out_MaterReports (id,fk_id_brig, num_year, num_mont' +
        'h) '
      'values (:id,:fk_id_brig, :num_year, :num_month)')
    SelectSQL.Strings = (
      
        'select outr.id, outr.fk_id_brig, outr.num_year, outr.num_month f' +
        'rom Out_MaterReports outr'
      '  where fk_id_brig=:id_brig or id=-1'
      '  order by num_year, num_month desc')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_OUT_MATERREPORTS'
    GeneratorField.ApplyEvent = gamOnPost
    Left = 440
    Top = 288
    object dset_out_reportsID: TIntegerField
      FieldName = 'ID'
      Origin = 'OUT_MATERREPORTS.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_out_reportsFK_ID_BRIG: TIntegerField
      FieldName = 'FK_ID_BRIG'
      Origin = 'OUT_MATERREPORTS.FK_ID_BRIG'
      Required = True
    end
    object dset_out_reportsNUM_YEAR: TSmallintField
      FieldName = 'NUM_YEAR'
      Origin = 'OUT_MATERREPORTS.NUM_YEAR'
    end
    object dset_out_reportsNUM_MONTH: TSmallintField
      FieldName = 'NUM_MONTH'
      Origin = 'OUT_MATERREPORTS.NUM_MONTH'
    end
    object dset_out_reportsshow_title: TStringField
      FieldKind = fkCalculated
      FieldName = 'show_title'
      Calculated = True
    end
  end
  object tran_out_reports: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Left = 360
    Top = 288
  end
  object dset_s_mat2: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_main
    SelectSQL.Strings = (
      'select sm.id,  sm.kod, sm.name_r, sm.units, sm.price'
      'from s_mat2 sm order by kod')
    Left = 416
    Top = 104
    object dset_s_mat2ID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_MAT2.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_s_mat2KOD: TIBStringField
      FieldName = 'KOD'
      Origin = 'S_MAT2.KOD'
      Required = True
      Size = 15
    end
    object dset_s_mat2NAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_MAT2.NAME_R'
      Size = 100
    end
    object dset_s_mat2UNITS: TIBStringField
      FieldName = 'UNITS'
      Origin = 'S_MAT2.UNITS'
      Size = 10
    end
    object dset_s_mat2PRICE: TIBBCDField
      FieldName = 'PRICE'
      Origin = 'S_MAT2.PRICE'
      Required = True
      Precision = 9
      Size = 2
    end
  end
  object tran_s_mat2: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 424
    Top = 48
  end
  object dset_S_MAT2_COUMN: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_s
    SelectSQL.Strings = (
      'select id, name_r,del from S_MAT2_COUMN     order by 2')
    Left = 416
    Top = 408
    object dset_S_MAT2_COUMNID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_MAT2_COUMN.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_S_MAT2_COUMNNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_MAT2_COUMN.NAME_R'
      Required = True
      Size = 15
    end
    object dset_S_MAT2_COUMNDEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_MAT2_COUMN.DEL'
      FixedChar = True
      Size = 1
    end
  end
end
