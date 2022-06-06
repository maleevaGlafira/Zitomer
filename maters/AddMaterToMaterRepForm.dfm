object frm_AddMaterToMaterRep: Tfrm_AddMaterToMaterRep
  Left = 333
  Top = 134
  Width = 546
  Height = 307
  Caption = 'frm_AddMaterToMaterRep'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 72
    Top = 20
    Width = 19
    Height = 13
    Caption = #1050#1086#1076
  end
  object lbl_name: TLabel
    Left = 16
    Top = 80
    Width = 76
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object lbl_units: TLabel
    Left = 56
    Top = 146
    Width = 39
    Height = 13
    Caption = #1045#1076' '#1080#1079#1084'.'
  end
  object Lbl_price: TLabel
    Left = 64
    Top = 178
    Width = 26
    Height = 13
    Caption = #1062#1077#1085#1072
  end
  object lbl_q: TLabel
    Left = 288
    Top = 178
    Width = 34
    Height = 13
    Caption = #1050#1086#1083'-'#1074#1086
  end
  object lbl_columnname: TLabel
    Left = 16
    Top = 48
    Width = 76
    Height = 13
    Caption = 'lbl_columnname'
  end
  object me_kod: TMaskEdit
    Left = 112
    Top = 16
    Width = 120
    Height = 21
    EditMask = '00000000000;1;_'
    MaxLength = 11
    TabOrder = 0
    Text = '           '
    OnExit = me_kodExit
  end
  object ed_units: TEdit
    Left = 112
    Top = 144
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object spe_price: TRxSpinEdit
    Left = 112
    Top = 176
    Width = 121
    Height = 21
    Increment = 0.010000000000000000
    ValueType = vtFloat
    TabOrder = 3
  end
  object spe_kol: TRxSpinEdit
    Left = 376
    Top = 176
    Width = 121
    Height = 21
    Decimal = 3
    ValueType = vtFloat
    TabOrder = 4
  end
  object mem_name: TMemo
    Left = 112
    Top = 80
    Width = 385
    Height = 49
    Lines.Strings = (
      '')
    TabOrder = 1
  end
  object pnl_controls: TPanel
    Left = 0
    Top = 209
    Width = 530
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    object btn_add: TBitBtn
      Left = 32
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = btn_addClick
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
    object btn_cancel: TBitBtn
      Left = 408
      Top = 9
      Width = 75
      Height = 25
      TabOrder = 1
      OnClick = btn_cancelClick
      Kind = bkCancel
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 250
    Width = 530
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object RxLbMaterColumn: TRxDBLookupCombo
    Left = 114
    Top = 45
    Width = 223
    Height = 21
    DropDownCount = 8
    LookupField = 'ID'
    LookupDisplay = 'NAME_R'
    LookupSource = ds_s_mat2column
    TabOrder = 7
  end
  object ds_s_mat2: TDataSource
    Left = 288
    Top = 16
  end
  object ds_matermater: TDataSource
    Left = 360
    Top = 24
  end
  object ds_s_mat2column: TDataSource
    Left = 440
    Top = 32
  end
end
