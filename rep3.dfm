object Rep3F: TRep3F
  Left = 360
  Top = 228
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsNone
  Caption = #1060#1086#1088#1084#1072' 3'
  ClientHeight = 364
  ClientWidth = 263
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 263
    Height = 364
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 61
      Width = 42
      Height = 13
      Caption = #1050#1074#1072#1088#1090#1072#1083
    end
    object Label3: TLabel
      Left = 146
      Top = 61
      Width = 18
      Height = 13
      Caption = #1043#1086#1076
    end
    object Bevel1: TBevel
      Left = 3
      Top = 327
      Width = 256
      Height = 13
      ParentShowHint = False
      Shape = bsTopLine
      ShowHint = False
    end
    object Quarte_cb: TComboBox
      Left = 61
      Top = 57
      Width = 72
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = '1'
      OnChange = Quarte_cbChange
      Items.Strings = (
        '1'
        '2'
        '3'
        '4')
    end
    object Year_cb: TComboBox
      Left = 173
      Top = 57
      Width = 85
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = '2015'
      OnChange = Year_cbChange
      Items.Strings = (
        '2015'
        '2016'
        '2017')
    end
    object BtOk: TBitBtn
      Left = 55
      Top = 332
      Width = 101
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100
      Default = True
      ModalResult = 1
      TabOrder = 2
      OnClick = BtOkClick
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
    object BitBtn1: TBitBtn
      Left = 158
      Top = 332
      Width = 100
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      TabOrder = 3
      Kind = bkClose
    end
    object Period_rg: TRadioGroup
      Left = 6
      Top = 3
      Width = 124
      Height = 50
      Caption = ' '#1055#1077#1088#1080#1086#1076' '
      ItemIndex = 0
      Items.Strings = (
        #1050#1074#1072#1088#1090#1072#1083
        #1043#1086#1076)
      TabOrder = 4
      OnClick = Period_rgClick
    end
    object Vidrep_rg: TRadioGroup
      Left = 134
      Top = 3
      Width = 124
      Height = 50
      ItemIndex = 0
      Items.Strings = (
        #1044#1080#1072#1084#1077#1090#1088
        #1056#1069#1042#1057)
      TabOrder = 5
    end
    object Mat_lch: TCheckListBox
      Left = 5
      Top = 81
      Width = 253
      Height = 192
      OnClickCheck = Mat_lchClickCheck
      ItemHeight = 13
      TabOrder = 6
    end
    object AllMat_chb: TCheckBox
      Left = 6
      Top = 275
      Width = 97
      Height = 17
      Caption = #1042#1089#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1099
      TabOrder = 7
    end
    object Extend_chb: TCheckBox
      Left = 6
      Top = 292
      Width = 207
      Height = 17
      Caption = #1056#1072#1089#1096#1080#1088#1077#1085#1085#1099#1081' '#1086#1090#1095#1077#1090
      TabOrder = 8
    end
    object EmptyRows_chb: TCheckBox
      Left = 7
      Top = 309
      Width = 247
      Height = 14
      Caption = #1053#1077' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1085#1091#1083#1077#1074#1099#1077' '#1089#1090#1088#1086#1082#1080
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
  end
end
