object Rep4F: TRep4F
  Left = 348
  Top = 121
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1060#1086#1088#1084#1072' 4'
  ClientHeight = 446
  ClientWidth = 367
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
    Width = 367
    Height = 446
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    DesignSize = (
      367
      446)
    object Label2: TLabel
      Left = 7
      Top = 60
      Width = 42
      Height = 13
      Caption = #1050#1074#1072#1088#1090#1072#1083
    end
    object Label3: TLabel
      Left = 145
      Top = 60
      Width = 18
      Height = 13
      Caption = #1043#1086#1076
    end
    object Bevel1: TBevel
      Left = 4
      Top = 410
      Width = 359
      Height = 16
      ParentShowHint = False
      Shape = bsTopLine
      ShowHint = False
    end
    object Label1: TLabel
      Left = 127
      Top = 375
      Width = 64
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = #1057#1086#1082#1088#1072#1097#1077#1085#1080#1077
    end
    object Label4: TLabel
      Left = 181
      Top = 15
      Width = 28
      Height = 13
      Caption = #1056#1069#1042#1057
    end
    object Quarte_cb: TComboBox
      Left = 56
      Top = 56
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
      Left = 172
      Top = 56
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
      Left = 159
      Top = 414
      Width = 100
      Height = 26
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
    object BExit: TBitBtn
      Left = 262
      Top = 414
      Width = 100
      Height = 26
      Caption = #1042#1099#1093#1086#1076
      TabOrder = 3
      Kind = bkClose
    end
    object Period_rg: TRadioGroup
      Left = 7
      Top = 3
      Width = 166
      Height = 50
      Caption = ' '#1055#1077#1088#1080#1086#1076' '
      ItemIndex = 0
      Items.Strings = (
        #1050#1074#1072#1088#1090#1072#1083
        #1043#1086#1076)
      TabOrder = 4
      OnClick = Period_rgClick
    end
    object Diam_lchb: TCheckListBox
      Left = 5
      Top = 96
      Width = 115
      Height = 297
      OnClickCheck = Diam_lchbClickCheck
      ItemHeight = 13
      TabOrder = 5
    end
    object Damg_lchb: TCheckListBox
      Left = 123
      Top = 96
      Width = 238
      Height = 273
      OnClickCheck = Damg_lchbClickCheck
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 15
      Items.Strings = (
        'abcd12tyu'
        '1wwertydh')
      ParentFont = False
      TabOrder = 6
      OnClick = Damg_lchbClick
    end
    object ShortForm_ed: TEdit
      Left = 201
      Top = 372
      Width = 160
      Height = 21
      TabOrder = 7
      OnChange = ShortForm_edChange
    end
    object StaticText1: TStaticText
      Left = 5
      Top = 80
      Width = 115
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = ' '#1043#1088#1091#1087#1087#1080#1088#1086#1074#1082#1072' '
      TabOrder = 8
    end
    object StaticText2: TStaticText
      Left = 122
      Top = 80
      Width = 240
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = ' '#1055#1086#1074#1088#1077#1078#1076#1077#1085#1080#1077' '
      TabOrder = 9
    end
    object Rayon_lcb: TRxDBLookupCombo
      Left = 240
      Top = 10
      Width = 118
      Height = 23
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'NAME_R'
      LookupSource = DM1.S_Revs_sur
      TabOrder = 10
    end
    object Excavation_chb: TCheckBox
      Left = 182
      Top = 34
      Width = 159
      Height = 17
      Caption = #1056#1072#1089#1082#1086#1087#1082#1072
      Checked = True
      State = cbChecked
      TabOrder = 11
    end
    object EmptyRows_chb: TCheckBox
      Left = 6
      Top = 394
      Width = 214
      Height = 14
      Caption = #1053#1077' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1085#1091#1083#1077#1074#1099#1077' '#1089#1090#1088#1086#1082#1080
      Checked = True
      State = cbChecked
      TabOrder = 12
    end
  end
end
