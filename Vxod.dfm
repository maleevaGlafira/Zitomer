object ZastFrm: TZastFrm
  Left = 261
  Top = 172
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #1030#1076#1077#1085#1090#1080#1092#1110#1082#1072#1110#1103' '#1082#1086#1088#1080#1089#1090#1091#1074#1072#1095#1072
  ClientHeight = 175
  ClientWidth = 491
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnBottom: TPanel
    Left = 0
    Top = 88
    Width = 489
    Height = 81
    BevelInner = bvLowered
    BevelOuter = bvLowered
    TabOrder = 1
    object RxLabel1: TRxLabel
      Left = 2
      Top = 34
      Width = 485
      Height = 13
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = #1050#1080#1077#1074#1042#1086#1076#1086#1082#1072#1085#1072#1083
    end
    object RxLabel2: TRxLabel
      Left = 2
      Top = 2
      Width = 485
      Height = 19
      Align = alTop
      Alignment = taCenter
      Caption = #1056#1086#1073#1086#1095#1077' '#1084#1110#1089#1094#1077' '#1076#1080#1089#1087#1077#1090#1095#1077#1088#1072' '#1040#1042#1056
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RxLabel3: TRxLabel
      Left = 2
      Top = 47
      Width = 485
      Height = 13
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = '*****'
    end
    object RxLabel4: TRxLabel
      Left = 2
      Top = 21
      Width = 485
      Height = 13
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'v 1.0.0.153'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object Animate: TAnimate
    Left = 408
    Top = 100
    Width = 64
    Height = 37
    AutoSize = False
    Color = clBtnFace
    CommonAVI = aviFindFolder
    ParentColor = False
    StopFrame = 29
    Visible = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 401
    Height = 89
    BevelOuter = bvNone
    TabOrder = 0
    object lUserName: TRxLabel
      Left = 15
      Top = 9
      Width = 129
      Height = 16
      Alignment = taRightJustify
      Caption = #1030#1084#39#1103' '#1082#1086#1088#1080#1089#1090#1091#1074#1072#1095#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lPassword: TRxLabel
      Left = 86
      Top = 35
      Width = 58
      Height = 16
      Alignment = taRightJustify
      Caption = #1055#1072#1088#1086#1083#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edPassword: TEdit
      Left = 148
      Top = 33
      Width = 253
      Height = 21
      PasswordChar = '#'
      TabOrder = 1
      OnChange = EditChange
      OnEnter = edPasswordEnter
      OnKeyDown = edPasswordKeyDown
    end
    object EdUserName: TEdit
      Left = 148
      Top = 4
      Width = 253
      Height = 21
      TabOrder = 2
      Visible = False
      OnChange = EditChange
      OnEnter = edUserNameEnter
      OnKeyDown = EdUserNameKeyDown
    end
    object CBox_names: TComboBox
      Left = 148
      Top = 4
      Width = 253
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnChange = CBox_namesChange
    end
  end
  object Panel2: TPanel
    Left = 401
    Top = 0
    Width = 85
    Height = 64
    BevelOuter = bvNone
    TabOrder = 3
    object BtExit: TBitBtn
      Left = 6
      Top = 33
      Width = 74
      Height = 26
      Caption = #1042#1099#1093#1086#1076
      TabOrder = 0
      OnClick = BtExitClick
      Kind = bkCancel
    end
    object BtOk: TBitBtn
      Left = 6
      Top = 3
      Width = 75
      Height = 30
      Caption = 'OK'
      TabOrder = 1
      OnClick = btOKClick
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
  end
  object cb_byname: TCheckBox
    Left = 392
    Top = 64
    Width = 97
    Height = 17
    Caption = #1030#1084#39#1103
    TabOrder = 4
    OnClick = cb_bynameClick
  end
  object Qry_user: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'select id,trim(UPPER(name_r)) as name_r,dolgn,uid,prava from s_b' +
        'rig where id>0 order by 1')
    Left = 52
    Top = 80
  end
end
