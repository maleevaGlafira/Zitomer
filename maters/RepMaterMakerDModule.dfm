object dm_RepMaterMaker: Tdm_RepMaterMaker
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 414
  Top = 241
  Height = 439
  Width = 538
  object tran_s: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Left = 56
    Top = 24
  end
  object tran_main: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Left = 56
    Top = 96
  end
  object dset_brigs: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_s
    SelectSQL.Strings = (
      'select id, trim(name_r)||'#39' ('#39'||trim(dolgn)||'#39')'#39', name_r  '
      'from s_brig order by name_r ')
    Left = 128
    Top = 24
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
  object dset_reports_out: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_main
    OnCalcFields = dset_reports_outCalcFields
    SelectSQL.Strings = (
      'select id, fk_id_brig, num_year, num_month from out_materreports'
      'where fk_id_brig=:id_brig or id=-1'
      'order by num_year, num_month desc')
    Left = 136
    Top = 96
    object dset_reports_outID: TIntegerField
      FieldName = 'ID'
      Origin = 'MATREPORTS.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_reports_outFK_ID_BRIG: TIntegerField
      FieldName = 'FK_ID_BRIG'
      Origin = 'MATREPORTS.FK_ID_BRIG'
      Required = True
    end
    object dset_reports_outNUM_YEAR: TSmallintField
      FieldName = 'NUM_YEAR'
      Origin = 'MATREPORTS.NUM_YEAR'
      Required = True
    end
    object dset_reports_outNUM_MONTH: TSmallintField
      FieldName = 'NUM_MONTH'
      Origin = 'MATREPORTS.NUM_MONTH'
      Required = True
    end
    object dset_reports_outshow_title: TStringField
      FieldKind = fkCalculated
      FieldName = 'show_title'
      Calculated = True
    end
    object dset_reports_outmonth: TStringField
      FieldKind = fkCalculated
      FieldName = 'month'
      Size = 10
      Calculated = True
    end
  end
  object dset_deps: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_main
    Left = 128
    Top = 160
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
    Left = 56
    Top = 160
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
    object mem_depsn_col: TStringField
      FieldName = 'n_col'
    end
    object mem_depsis_mater: TBooleanField
      FieldName = 'is_mater'
    end
  end
  object dset_reportmats: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_main
    Left = 416
    Top = 168
  end
  object dset_tmp: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_main
    Left = 264
    Top = 216
  end
  object mem_maters: TkbmMemTable
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
    Left = 64
    Top = 248
    object mem_matersREPORT_MATS2id: TIntegerField
      FieldName = 'REPORT_MATS2id'
    end
    object mem_materskod: TStringField
      FieldName = 'kod'
      Size = 13
    end
    object mem_matersname: TStringField
      FieldName = 'name'
      Size = 200
    end
    object mem_matersid_MATREPORTS: TIntegerField
      FieldName = 'id_MATREPORTS'
    end
    object mem_matersid_brig: TIntegerField
      FieldName = 'id_brig'
    end
    object mem_matersbrig_name: TStringField
      FieldName = 'brig_name'
      Size = 100
    end
    object mem_matersall_q: TFloatField
      FieldName = 'all_q'
    end
    object mem_matersis_storage: TBooleanField
      FieldName = 'is_storage'
    end
    object mem_matersid_s_mat2: TIntegerField
      FieldName = 'id_s_mat2'
    end
    object mem_matersunits: TStringField
      FieldName = 'units'
      Size = 10
    end
    object mem_matersprice: TFloatField
      FieldName = 'price'
    end
    object mem_matersid_matercol: TIntegerField
      FieldName = 'id_matercol'
    end
    object mem_matersmatercol_name: TStringField
      FieldName = 'matercol_name'
    end
  end
  object mem_report: TkbmMemTable
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
    Left = 64
    Top = 312
    object mem_reportreport_mats2id: TIntegerField
      FieldName = 'report_mats2id'
    end
    object mem_reportcol_num: TIntegerField
      FieldName = 'col_num'
    end
    object mem_reportval: TStringField
      FieldName = 'val'
      Size = 420
    end
    object mem_reportcol_brigid: TIntegerField
      FieldName = 'col_brigid'
    end
    object mem_reportrow_num: TIntegerField
      FieldName = 'row_num'
    end
    object mem_reportcol_span: TIntegerField
      FieldName = 'col_span'
    end
    object mem_reportrow_span: TIntegerField
      FieldName = 'row_span'
    end
    object mem_reportqval: TFloatField
      FieldName = 'qval'
    end
    object mem_reportcol_matercol: TIntegerField
      FieldName = 'col_matercol'
    end
  end
end
