object FormSah: TFormSah
  Left = 240
  Top = 288
  BorderStyle = bsSingle
  Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1091#1095#1077#1090#1072' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1081' ("'#1096#1072#1093#1084#1072#1090#1082#1072'")'
  ClientHeight = 232
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object RG_vib: TRadioGroup
    Left = 2
    Top = 0
    Width = 589
    Height = 195
    Caption = ' '#1042#1099#1073#1086#1088' '#1086#1090#1095#1077#1090#1072' '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1091#1095#1077#1090#1072' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1081' ("'#1096#1072#1093#1084#1072#1090#1082#1072'")'
      #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1083#1080#1082#1074#1080#1076#1072#1094#1080#1080' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1081' '#1079#1072' '#1087#1077#1088#1080#1086#1076
      #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1091#1095#1077#1090#1072' '#1080#1079#1088#1072#1089#1093#1086#1076#1086#1074#1072#1085#1085#1099#1093' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
      #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1091#1095#1077#1090#1072' '#1080#1079#1088#1072#1089#1093#1086#1076'. '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074' '#1087#1086' '#1076#1080#1072#1084#1077#1090#1088#1072#1084
      #1057#1074#1086#1076#1082#1072' '#1083#1080#1082#1074#1080#1076#1080#1088#1086#1074#1072#1085#1085#1099#1093' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1081
      #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1087#1077#1088#1077#1082#1088#1099#1090#1099#1093' '#1079#1072#1076#1074#1080#1078#1077#1082
      #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1088#1072#1089#1082#1086#1087#1086#1082)
    ParentFont = False
    TabOrder = 0
    OnClick = RG_vibClick
  end
  object BB_Set: TBitBtn
    Left = 356
    Top = 11
    Width = 117
    Height = 22
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
    TabOrder = 1
    OnClick = BB_SetClick
  end
  object DBL_mat: TRxDBLookupCombo
    Left = 356
    Top = 78
    Width = 220
    Height = 24
    DropDownCount = 8
    LookupField = 'NAME_R'
    LookupDisplay = 'NAME_R'
    LookupSource = DS_mat
    TabOrder = 2
  end
  object DBL_Diam: TRxDBLookupCombo
    Left = 356
    Top = 47
    Width = 216
    Height = 24
    DropDownCount = 8
    LookupField = 'DIAM'
    LookupDisplay = 'DIAM'
    LookupSource = DS_diam
    TabOrder = 3
  end
  object RB_bezr: TRadioButton
    Left = 356
    Top = 118
    Width = 100
    Height = 15
    Caption = #1073#1077#1079' '#1088#1072#1089#1082#1086#1087#1082#1080
    TabOrder = 4
  end
  object RB_sr: TRadioButton
    Left = 463
    Top = 119
    Width = 100
    Height = 15
    Caption = #1089' '#1088#1072#1089#1082#1086#1087#1082#1086#1081
    TabOrder = 5
  end
  object ChB_open: TCheckBox
    Left = 356
    Top = 144
    Width = 139
    Height = 15
    Caption = #1090#1086#1083#1100#1082#1086' '#1085#1077#1086#1090#1082#1088#1099#1090#1099#1077
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object ChB_Excel: TCheckBox
    Left = 480
    Top = 15
    Width = 103
    Height = 15
    Caption = #1042#1099#1074#1086#1076' '#1074' Excel'
    TabOrder = 7
  end
  inline Frm_Dt: TFrm_Date
    Left = 2
    Top = 195
    Width = 424
    Height = 38
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    inherited Label1: TLabel
      Left = 2
      Top = 8
    end
    inherited Label2: TLabel
      Left = 198
      Top = 9
    end
    inherited DE_In: TDateEdit
      Left = 16
      Top = 6
      Width = 93
      ButtonWidth = 19
    end
    inherited Te_in: TDateTimePicker
      Left = 112
      Top = 6
      Width = 82
    end
    inherited DE_Out: TDateEdit
      Left = 218
      Top = 6
      Width = 93
      ButtonWidth = 19
    end
    inherited Te_Out: TDateTimePicker
      Left = 315
      Top = 6
      Width = 75
    end
  end
  object BB_ok: TBitBtn
    Left = 413
    Top = 200
    Width = 87
    Height = 28
    Caption = #1055#1088#1080#1085#1103#1090#1100
    TabOrder = 9
    OnClick = BB_okClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BB_Exit: TBitBtn
    Left = 504
    Top = 201
    Width = 87
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 10
    OnClick = BB_ExitClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object rbBury: TRadioButton
    Left = 328
    Top = 172
    Width = 103
    Height = 15
    Caption = #1085#1077#1079#1072#1082#1086#1087#1072#1085#1085#1099#1077
    Checked = True
    TabOrder = 11
    TabStop = True
  end
  object rbAsphalt: TRadioButton
    Left = 434
    Top = 172
    Width = 153
    Height = 15
    Caption = #1085#1077#1079#1072#1072#1089#1092#1083#1100#1090#1080#1088#1086#1074#1072#1085#1085#1099#1077
    TabOrder = 12
  end
  object rbAll: TRadioButton
    Left = 282
    Top = 172
    Width = 43
    Height = 15
    Caption = #1074#1089#1077
    TabOrder = 13
  end
  object Qry_tzav: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select * from s_tzav where id>0')
    Left = 208
    Top = 140
  end
  object Qry_sah: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 300
    Top = 144
  end
  object Qry_rayon: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select * from s_rayon where id>0')
    Left = 156
    Top = 140
  end
  object Qry_tmp: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 252
    Top = 140
  end
  object Qry_mat: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select * from s_mat where (id>0) and (del='#39'-'#39') order by name_r')
    Left = 428
    Top = 40
  end
  object DS_mat: TDataSource
    DataSet = Qry_mat
    Left = 488
    Top = 40
  end
  object Qry_diam: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select * from s_diam where del='#39'-'#39' order by diam')
    Left = 316
    Top = 52
  end
  object DS_diam: TDataSource
    DataSet = Qry_diam
    Left = 364
    Top = 52
  end
  object Qry_tmp2: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 304
    Top = 100
  end
end
