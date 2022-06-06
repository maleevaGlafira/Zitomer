object frame_WorksInfo: Tframe_WorksInfo
  Left = 0
  Top = 0
  Width = 564
  Height = 258
  TabOrder = 0
  object lbl_AddInfo: TLabel
    Left = 0
    Top = 164
    Width = 564
    Height = 13
    Align = alBottom
    Caption = #1053#1077' '#1079#1072#1076#1072#1085#1086' '#1074#1088#1077#1084#1103' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1086#1073#1103#1079#1072#1090#1077#1083#1100#1085#1099#1093' '#1088#1072#1073#1086#1090' '#1087#1086' '#1073#1083#1072#1075'-'#1074#1091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Grid: TStringAlignGrid
    Left = 0
    Top = 0
    Width = 564
    Height = 164
    Align = alClient
    TabOrder = 0
    PropCell = ()
    PropCol = ()
    PropRow = ()
    PropFixedCol = ()
    PropFixedRow = ()
  end
  object pnl_NeedWorks: TPanel
    Left = 0
    Top = 177
    Width = 564
    Height = 81
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 564
      Height = 13
      Align = alTop
      Caption = #1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1074#1099#1087#1086#1083#1085#1080#1090#1100' '#1088#1072#1073#1086#1090#1099
    end
    object mem_NeedWorks: TMemo
      Left = 0
      Top = 13
      Width = 564
      Height = 68
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object dset_WorksInfo: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    OnCalcFields = dset_WorksInfoCalcFields
    SelectSQL.Strings = (
      'select n.dt_out, sb.name_r as brig_name,'
      'sp.name_r as place_name,'
      'sw.name_r as work_name, sw.ed_izm, sw.id'
      'from works w'
      'inner join nnarad n on n.id = w.id_nar'
      'left join s_work sw on sw.id = w.id_work'
      'left join s_place sp on sp.id = sw.ftype'
      'left join s_brig sb on sb.id = n.id_brig'
      'where w.id_raskop = :pRaskopID'
      'union all'
      'select n.dt_out, sb.name_r as brig_name,'
      'sp.name_r as place_name,'
      'sw.name_r as work_name, sw.ed_izm, sw.id'
      'from works w'
      'inner join narad n on n.id = w.id_nar'
      'left join s_work sw on sw.id = w.id_work'
      'left join s_place sp on sp.id = sw.ftype'
      'left join s_brig sb on sb.id = n.id_brig'
      'where w.id_raskop = :pRaskopID'
      'order by 1, 2, 3, 4')
    Left = 384
    Top = 88
    object dset_WorksInfoID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = []
    end
    object dset_WorksInfoPLACE_NAME: TIBStringField
      FieldName = 'PLACE_NAME'
      ProviderFlags = []
      FixedChar = True
    end
    object dset_WorksInfoWORK_NAME: TIBStringField
      FieldName = 'WORK_NAME'
      ProviderFlags = []
      FixedChar = True
      Size = 50
    end
    object dset_WorksInfoED_IZM: TIBStringField
      FieldName = 'ED_IZM'
      ProviderFlags = []
      FixedChar = True
      Size = 10
    end
    object dset_WorksInfoBRIG_NAME: TIBStringField
      FieldName = 'BRIG_NAME'
      ProviderFlags = []
      FixedChar = True
      Size = 35
    end
    object dset_WorksInfoDT_OUT: TDateTimeField
      FieldName = 'DT_OUT'
      ProviderFlags = []
    end
    object dset_WorksInfoclc_WORK_NAME: TStringField
      FieldKind = fkCalculated
      FieldName = 'clc_WORK_NAME'
      Size = 40
      Calculated = True
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 392
    Top = 48
  end
  object mt_NeedWorks: TkbmMemTable
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
    Left = 496
    Top = 48
    object mt_NeedWorksid_work: TIntegerField
      FieldName = 'id_work'
    end
    object mt_NeedWorkswork_name: TStringField
      FieldName = 'work_name'
      Size = 60
    end
  end
  object dset_NeedWorks: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select distinct sw.id as id_work,'
      'rtrim(sw.name_r)||'#39' ['#39'||rtrim(sp.name_r)||'#39']'#39' as work_name'
      'from s_work_mest swm'
      'inner join s_work sw on sw.id = swm.id_work'
      'left join s_place sp on sp.id = sw.ftype'
      'where ( sw.id_work_type = 2 ) and'
      '(sw.del = '#39'-'#39') and'
      '( swm.id_mest = :pMestID )'
      'order by sw.name_r')
    Left = 504
    Top = 120
    object dset_NeedWorksID_WORK: TIntegerField
      FieldName = 'ID_WORK'
      Origin = 'S_WORK.ID'
      Required = True
    end
    object dset_NeedWorksWORK_NAME: TIBStringField
      FieldName = 'WORK_NAME'
      ProviderFlags = []
      Size = 163
    end
  end
end
