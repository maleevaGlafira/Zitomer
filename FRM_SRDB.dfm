object Frm_SDb: TFrm_SDb
  Left = 0
  Top = 0
  Width = 479
  Height = 135
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Lb_name: TLabel
    Left = 3
    Top = 6
    Width = 44
    Height = 13
    Caption = #1059#1089#1083#1086#1074#1080#1077
  end
  object DBLC_sear: TRxDBLookupCombo
    Left = 68
    Top = 2
    Width = 408
    Height = 23
    DropDownCount = 8
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ListStyle = lsDelimited
    LookupSource = DS_sear
    ParentFont = False
    TabOrder = 0
  end
  object GrB_Spis: TGroupBox
    Left = 181
    Top = 24
    Width = 294
    Height = 96
    Caption = ' '#1059#1089#1083#1086#1074#1080#1103' '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object LB_Sear: TListBox
      Left = 5
      Top = 14
      Width = 209
      Height = 75
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 0
    end
    object BB_Add: TBitBtn
      Left = 218
      Top = 12
      Width = 70
      Height = 23
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 1
      OnClick = BB_AddClick
    end
    object BB_Del: TBitBtn
      Left = 218
      Top = 39
      Width = 70
      Height = 23
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 2
      OnClick = BB_DelClick
    end
    object BB_Clear: TBitBtn
      Left = 218
      Top = 66
      Width = 70
      Height = 23
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      TabOrder = 3
      OnClick = BB_ClearClick
    end
  end
  object GrB_like: TGroupBox
    Left = 1
    Top = 24
    Width = 177
    Height = 96
    Caption = ' '#1055#1086#1080#1089#1082' '#1087#1086' '#1074#1093#1086#1078#1076#1077#1085#1080#1102' '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Ed_sear: TEdit
      Left = 6
      Top = 25
      Width = 164
      Height = 21
      TabOrder = 0
    end
    object BB_like: TBitBtn
      Left = 8
      Top = 60
      Width = 75
      Height = 25
      Caption = #1048#1089#1082#1072#1090#1100
      Enabled = False
      TabOrder = 1
      Visible = False
      OnClick = BB_likeClick
    end
  end
  object Povrezhd_rg: TRadioGroup
    Left = 5
    Top = 38
    Width = 460
    Height = 40
    Columns = 3
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 2
    Items.Strings = (
      #1057' '#1088#1072#1089#1082#1086#1087#1082#1086#1081
      #1041#1077#1079' '#1088#1072#1089#1082#1086#1087#1082#1080
      #1042#1089#1077)
    ParentFont = False
    TabOrder = 3
  end
  object Qry_sear: TQuery
    Left = 288
    Top = 60
  end
  object DS_sear: TDataSource
    DataSet = Qry_sear
    Left = 248
    Top = 64
  end
  object Qry_tmp: TQuery
    Left = 360
    Top = 56
  end
end
