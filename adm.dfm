object FormAdm: TFormAdm
  Left = 218
  Top = 135
  BorderStyle = bsDialog
  Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
  ClientHeight = 279
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 427
    Height = 259
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Label1: TLabel
      Left = 7
      Top = 33
      Width = 73
      Height = 13
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object Label2: TLabel
      Left = 7
      Top = 64
      Width = 186
      Height = 13
      Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' ('#1072#1085#1075#1083')'
    end
    object Label3: TLabel
      Left = 7
      Top = 9
      Width = 125
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1072
    end
    object Lb_us: TLabel
      Left = 290
      Top = 162
      Width = 35
      Height = 15
      Caption = 'Lb_us'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Bevel1: TBevel
      Left = 4
      Top = 55
      Width = 440
      Height = 13
      Shape = bsTopLine
    end
    object DBL_brig: TRxDBLookupCombo
      Left = 94
      Top = 29
      Width = 328
      Height = 23
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'NAME_R;DOLGN'
      LookupSource = DS_brig
      TabOrder = 0
      OnChange = DBL_brigChange
      OnClick = DBL_brigClick
      OnEnter = DBL_brigEnter
    end
    object Ed_uid: TEdit
      Left = 208
      Top = 60
      Width = 214
      Height = 21
      TabOrder = 1
      OnChange = Ed_uidChange
      OnEnter = Ed_admEnter
    end
    object GrB_prava: TGroupBox
      Left = 6
      Top = 83
      Width = 275
      Height = 171
      Caption = ' '#1055#1088#1072#1074#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object ChB_read: TCheckBox
        Left = 7
        Top = 17
        Width = 117
        Height = 15
        Caption = #1063#1090#1077#1085#1080#1077
        Checked = True
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 0
        OnClick = ChB_readClick
      end
      object ChB_Sprav: TCheckBox
        Left = 7
        Top = 123
        Width = 190
        Height = 15
        Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1086#1074
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object Admin_chb: TCheckBox
        Left = 7
        Top = 153
        Width = 190
        Height = 15
        Caption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1080#1077
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = Admin_chbClick
      end
      object ChB_WriteZav: TCheckBox
        Left = 7
        Top = 31
        Width = 193
        Height = 17
        Caption = #1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1086#1089#1085#1086#1074#1085#1086#1081' '#1092#1086#1088#1084#1099
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object ChB_WriteRask: TCheckBox
        Left = 7
        Top = 47
        Width = 185
        Height = 17
        Caption = #1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1088#1072#1089#1082#1086#1087#1086#1082
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object ChB_WriteZadv: TCheckBox
        Left = 7
        Top = 63
        Width = 193
        Height = 17
        Caption = #1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1079#1072#1076#1074#1080#1078#1077#1082
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object ChB_WriteNarad: TCheckBox
        Left = 7
        Top = 78
        Width = 193
        Height = 17
        Caption = #1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1074#1099#1077#1079#1076#1086#1074
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object ChB_WritePoter: TCheckBox
        Left = 7
        Top = 93
        Width = 193
        Height = 17
        Caption = #1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1087#1086#1090#1077#1088#1100
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object ChB_Del: TCheckBox
        Left = 7
        Top = 138
        Width = 114
        Height = 15
        Caption = #1059#1076#1072#1083#1077#1085#1080#1077' '#1079#1072#1103#1074#1086#1082
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object ChB_wwater: TCheckBox
        Left = 7
        Top = 107
        Width = 250
        Height = 17
        Caption = #1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1089#1087#1080#1089#1082#1072' '#1072#1073#1086#1085#1077#1085#1090#1086#1074'('#1073#1077#1079' '#1074#1086#1076#1099')'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
    end
    object GrB_Pass: TGroupBox
      Left = 285
      Top = 83
      Width = 136
      Height = 77
      Caption = ' '#1055#1072#1088#1086#1083#1100' '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Ed_pas1: TEdit
        Left = 6
        Top = 18
        Width = 123
        Height = 21
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PasswordChar = '#'
        TabOrder = 0
        OnChange = Ed_uidChange
        OnEnter = Ed_admEnter
      end
      object Ed_pas2: TEdit
        Left = 6
        Top = 46
        Width = 123
        Height = 21
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PasswordChar = '#'
        TabOrder = 1
        OnChange = Ed_uidChange
        OnEnter = Ed_admEnter
      end
    end
    object BB_Close: TBitBtn
      Left = 286
      Top = 227
      Width = 135
      Height = 27
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 4
      OnClick = BB_CloseClick
      Kind = bkClose
    end
    object BB_Save: TBitBtn
      Left = 285
      Top = 198
      Width = 136
      Height = 27
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Enabled = False
      TabOrder = 5
      OnClick = BB_SaveClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
        00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
        00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
        00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
        0003737FFFFFFFFF7F7330099999999900333777777777777733}
      NumGlyphs = 2
    end
    object Ed_adm: TEdit
      Left = 150
      Top = 5
      Width = 271
      Height = 21
      PasswordChar = '#'
      TabOrder = 6
      OnEnter = Ed_admEnter
    end
  end
  object Pn_stat: TPanel
    Left = 0
    Top = 259
    Width = 427
    Height = 20
    Align = alBottom
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 1
    object Lb_izm: TLabel
      Left = 9
      Top = 2
      Width = 156
      Height = 18
      Caption = 'GGGGGGGGGGGGG'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
  end
  object Qry_brig: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id, cast(name_r as char(20)) name_r, '
      '          cast(dolgn as char(20)) dolgn, uid, prava '
      'from s_brig '
      'where id>0'
      'order by name_r'
      '')
    Left = 268
    Top = 12
  end
  object DS_brig: TDataSource
    DataSet = Qry_brig
    Left = 256
    Top = 4
  end
  object Exec: TsfAppExec
    ApplicationName = '"C:\Program Files\InterBase Corp\InterBase\Bin\gsec"'
    ShowType = sstShowNormal
    Wait = True
    Left = 168
    Top = 84
  end
  object Qry_tmp: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 196
    Top = 8
  end
  object Db_isc: TDatabase
    AliasName = 'AVARODESSA'
    DatabaseName = 'ISC_DBN'
    LoginPrompt = False
    Params.Strings = (
      'SERVER NAME='
      'USER NAME=SYSDBA'
      'OPEN MODE=READ ONLY'
      'SCHEMA CACHE SIZE=8'
      'LANGDRIVER=Pdox ANSI Cyrillic'
      'SQLPASSTHRU MODE=SHARED AUTOCOMMIT'
      'SCHEMA CACHE TIME=-1'
      'MAX ROWS=-1'
      'BATCH COUNT=200'
      'ENABLE SCHEMA CACHE=FALSE'
      'ENABLE BCD=TRUE'
      'BLOBS TO CACHE=64'
      'BLOB SIZE=32'
      'PASSWORD=')
    SessionName = 'Default'
    Left = 16
    Top = 56
  end
  object Qry_isc: TQuery
    DatabaseName = 'ISC_DBN'
    SQL.Strings = (
      'select user_name from users')
    Left = 316
    Top = 12
  end
  object Check: TDatabase
    AliasName = 'AVARODESSA'
    DatabaseName = 'Check'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=sysdba')
    SessionName = 'Default'
    Left = 216
    Top = 160
  end
  object Database1: TDatabase
    AliasName = 'AVARODESSA'
    DatabaseName = 'PROC_AVAR'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=SYSDBA'
      'PASSWORD=masterkey'
      'LANGDRIVER=Pdox ANSI Cyrillic')
    SessionName = 'Default'
    Left = 16
    Top = 16
  end
  object ProcQueryTmp: TQuery
    DatabaseName = 'PROC_AVAR'
    Left = 68
    Top = 48
  end
  object Qry_isc2: TQuery
    DatabaseName = 'ISC_DBN'
    SQL.Strings = (
      'select user_name from users')
    Left = 228
    Top = 108
  end
end
