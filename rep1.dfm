object Rep1F: TRep1F
  Left = 408
  Top = 338
  BorderStyle = bsSingle
  Caption = #1060#1086#1088#1084#1072' 1'
  ClientHeight = 182
  ClientWidth = 380
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 380
    Height = 182
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 84
      Width = 102
      Height = 13
      Caption = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077' '#1079#1072#1103#1074#1082#1080
    end
    object Label2: TLabel
      Left = 68
      Top = 61
      Width = 42
      Height = 13
      Caption = #1050#1074#1072#1088#1090#1072#1083
    end
    object Label3: TLabel
      Left = 206
      Top = 61
      Width = 18
      Height = 13
      Caption = #1043#1086#1076
    end
    object Bevel1: TBevel
      Left = 4
      Top = 146
      Width = 372
      Height = 13
      ParentShowHint = False
      Shape = bsTopLine
      ShowHint = False
    end
    object Label4: TLabel
      Left = 60
      Top = 108
      Width = 50
      Height = 13
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083
    end
    object Sod_lcb: TRxDBLookupCombo
      Left = 121
      Top = 81
      Width = 252
      Height = 23
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'NAME_R'
      LookupSource = DM1.S_Sod_sur
      TabOrder = 0
      OnChange = Sod_lcbChange
    end
    object Quarte_cb: TComboBox
      Left = 121
      Top = 57
      Width = 72
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = '1'
      OnChange = Quarte_cbChange
      Items.Strings = (
        '1'
        '2'
        '3'
        '4')
    end
    object Year_cb: TComboBox
      Left = 233
      Top = 57
      Width = 85
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Text = '2015'
      OnChange = Year_cbChange
      Items.Strings = (
        '2015'
        '2016')
    end
    object BtOk: TBitBtn
      Left = 182
      Top = 151
      Width = 110
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100
      Default = True
      ModalResult = 1
      TabOrder = 3
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
      Left = 295
      Top = 151
      Width = 79
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      TabOrder = 4
      Kind = bkClose
    end
    object Period_rg: TRadioGroup
      Left = 7
      Top = 3
      Width = 180
      Height = 50
      Caption = ' '#1055#1077#1088#1080#1086#1076' '
      ItemIndex = 0
      Items.Strings = (
        #1050#1074#1072#1088#1090#1072#1083
        #1043#1086#1076)
      TabOrder = 5
      OnClick = Period_rgClick
    end
    object Vidrep_rg: TRadioGroup
      Left = 193
      Top = 3
      Width = 180
      Height = 50
      ItemIndex = 0
      Items.Strings = (
        #1044#1080#1072#1084#1077#1090#1088
        #1056#1072#1081#1086#1085)
      TabOrder = 6
      OnClick = Mat_lcbChange
    end
    object Mat_lcb: TRxDBLookupCombo
      Left = 121
      Top = 105
      Width = 252
      Height = 23
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'NAME_R'
      LookupSource = DM1.S_mat_sur
      TabOrder = 7
      OnChange = Mat_lcbChange
    end
    object EmptyRows_chb: TCheckBox
      Left = 6
      Top = 131
      Width = 214
      Height = 14
      Caption = #1053#1077' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1085#1091#1083#1077#1074#1099#1077' '#1089#1090#1088#1086#1082#1080
      Checked = True
      State = cbChecked
      TabOrder = 8
    end
  end
  object Qr1: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT d.diam, count(z.id)'
      'FROM s_diam d LEFT JOIN nzavjav z'
      '      ON (z.id_diam = d.id)and'
      '         (z.dt_in >= :dt_begin)and(z.dt_in <= :dt_end)'
      '      LEFT JOIN s_sod sod'
      '        on (z.id_sod = sod.id)'
      'WHERE (delz=0) and (z.id_sod = :idsod)'
      'GROUP BY d.diam')
    Left = 128
    Top = 4
    ParamData = <
      item
        DataType = ftDate
        Name = 'dt_begin'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'dt_end'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'idsod'
        ParamType = ptInput
      end>
  end
end
