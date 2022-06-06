object VedomsForm: TVedomsForm
  Left = 584
  Top = 243
  Anchors = [akTop, akRight]
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1080
  ClientHeight = 86
  ClientWidth = 404
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    404
    86)
  PixelsPerInch = 96
  TextHeight = 13
  object BB_Ok: TBitBtn
    Left = 107
    Top = 58
    Width = 93
    Height = 25
    Anchors = [akLeft]
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = BB_OkClick
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
  object BB_esc: TBitBtn
    Left = 203
    Top = 58
    Width = 92
    Height = 25
    Anchors = [akLeft]
    Caption = #1054#1090#1084#1077#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BB_escClick
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
  object OutPanel: TPanel
    Left = 202
    Top = 0
    Width = 198
    Height = 33
    BevelOuter = bvNone
    TabOrder = 2
    object Label2: TLabel
      Left = 3
      Top = 10
      Width = 12
      Height = 13
      Caption = #1087#1086
    end
    object DE_Out: TDateEdit
      Left = 20
      Top = 5
      Width = 93
      Height = 22
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ButtonWidth = 19
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      YearDigits = dyFour
      TabOrder = 0
    end
    object TE_Out: TDateTimePicker
      Left = 115
      Top = 4
      Width = 82
      Height = 24
      Date = 36460.000694444400000000
      Time = 36460.000694444400000000
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Kind = dtkTime
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
  end
  object InPanel: TPanel
    Left = 0
    Top = 0
    Width = 204
    Height = 33
    BevelOuter = bvNone
    TabOrder = 3
    object Label3: TLabel
      Left = 3
      Top = 10
      Width = 7
      Height = 13
      Caption = #1057
    end
    object DE_In: TDateEdit
      Left = 21
      Top = 5
      Width = 93
      Height = 22
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ButtonWidth = 19
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      YearDigits = dyFour
      TabOrder = 0
    end
    object TE_In: TDateTimePicker
      Left = 116
      Top = 4
      Width = 82
      Height = 24
      Date = 36460.000694444400000000
      Time = 36460.000694444400000000
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Kind = dtkTime
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
  end
  object OLD_OK_BitBtn: TBitBtn
    Left = 164
    Top = 108
    Width = 93
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    TabOrder = 4
    OnClick = OLD_OK_BitBtnClick
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
  object P_Ul: TPanel
    Left = 1
    Top = 30
    Width = 401
    Height = 26
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 5
    Visible = False
    object Label1: TLabel
      Left = 10
      Top = 6
      Width = 32
      Height = 13
      Caption = #1059#1083#1080#1094#1072
    end
    object DBL_ul1: TRxDBLookupCombo
      Left = 48
      Top = 2
      Width = 345
      Height = 21
      DropDownCount = 8
      Ctl3D = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      LookupField = 'ID'
      LookupDisplay = 'NAME_R'
      LookupSource = DS_ul1
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
    end
  end
  object P_Blag: TPanel
    Left = 0
    Top = 31
    Width = 402
    Height = 25
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 6
    Visible = False
    object rb_AllZav: TRadioButton
      Left = 4
      Top = 4
      Width = 185
      Height = 17
      Caption = #1042#1089#1077' '#1079#1072#1103#1074#1082#1080' '#1087#1086' '#1073#1083#1072#1075#1086#1091#1089#1090#1088#1086#1081#1089#1090#1074#1091
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rb_NeedBlagZav: TRadioButton
      Left = 192
      Top = 5
      Width = 209
      Height = 17
      Caption = #1058#1086#1083#1100#1082#1086' '#1085#1077#1079#1072#1074#1077#1088#1096#1077#1085#1085#1086#1077' '#1073#1083#1072#1075'-'#1074#1086
      TabOrder = 1
    end
  end
  object Qry_ul1: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select u.id id, u.name_r  u_name_r , v.name_r  v_name_r ,'
      'rtrim(u.name_r)||" "||rtrim(v.name_r) as name_r,u.orint'
      'from s_ulic u,s_vidul v'
      'where u.del in ('#39'-'#39','#39'd'#39') and (u.id_vidul=v.id)'
      'or ((u.id_vidul=-1) and (u.id_vidul=v.id))'
      'order by u.name_r')
    Left = 12
    Top = 32
  end
  object DS_ul1: TDataSource
    DataSet = Qry_ul1
    Left = 40
    Top = 32
  end
end
