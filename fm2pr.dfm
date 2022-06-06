object Form2Pr: TForm2Pr
  Left = 158
  Top = 180
  BorderStyle = bsDialog
  Caption = #1055#1077#1095#1072#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072
  ClientHeight = 293
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 15
  object Lb_stat: TLabel
    Left = 244
    Top = 251
    Width = 3
    Height = 15
  end
  object Gg: TGauge
    Left = 4
    Top = 251
    Width = 230
    Height = 29
    Color = clBlack
    ForeColor = clBlue
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Progress = 0
  end
  object GrB_Export: TGroupBox
    Left = 240
    Top = 7
    Width = 128
    Height = 93
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object BB_Save: TBitBtn
      Left = 8
      Top = 32
      Width = 106
      Height = 29
      Caption = #1058#1077#1093#1090'. '#1092#1072#1081#1083
      TabOrder = 0
      OnClick = BB_SaveClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
        7700333333337777777733333333008088003333333377F73377333333330088
        88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
        000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
        FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
        99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
        99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
        99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
        93337FFFF7737777733300000033333333337777773333333333}
      NumGlyphs = 2
    end
    object ChB_Dos: TCheckBox
      Left = 7
      Top = 67
      Width = 117
      Height = 15
      Caption = #1050#1086#1076#1080#1088#1086#1074#1082#1072' DOS'
      TabOrder = 1
    end
  end
  object GrB_Print: TGroupBox
    Left = 4
    Top = 7
    Width = 230
    Height = 156
    Caption = #1055#1077#1095#1072#1090#1100' '#1090#1077#1082#1089#1090#1086#1074#1072#1103
    TabOrder = 1
    object Label1: TLabel
      Left = 11
      Top = 21
      Width = 143
      Height = 16
      Caption = #1050'-'#1074#1086' '#1089#1080#1084#1074#1086#1083#1086#1074' '#1085#1072' '#1083#1080#1089#1090#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 11
      Top = 42
      Width = 117
      Height = 16
      Caption = #1050'-'#1074#1086' '#1089#1090#1088#1086#1082' '#1085#1072' '#1083#1080#1089#1090#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 124
      Top = 78
      Width = 53
      Height = 15
      Caption = #1074#1082#1083#1102#1095#1080#1090#1100
    end
    object Label6: TLabel
      Left = 114
      Top = 102
      Width = 62
      Height = 15
      Caption = #1074#1099#1082#1083#1102#1095#1080#1090#1100
    end
    object ChB_PrDos: TCheckBox
      Left = 7
      Top = 124
      Width = 121
      Height = 15
      Caption = #1050#1086#1076#1080#1088#1086#1074#1082#1072' DOS'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object SpEd_Col: TSpinEdit
      Left = 180
      Top = 14
      Width = 43
      Height = 24
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      MaxValue = 255
      MinValue = 1
      ParentFont = False
      TabOrder = 1
      Value = 62
      OnChange = SpEd_ColChange
    end
    object SpEd_Row: TSpinEdit
      Left = 180
      Top = 39
      Width = 43
      Height = 24
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      MaxValue = 255
      MinValue = 0
      ParentFont = False
      TabOrder = 2
      Value = 60
      OnChange = SpEd_ColChange
    end
    object ChB_Con: TCheckBox
      Left = 7
      Top = 78
      Width = 114
      Height = 15
      Caption = #1057#1078#1072#1090#1099#1081' '#1096#1088#1080#1092#1090' :'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = ChB_ConClick
    end
    object SpEd_COn: TSpinEdit
      Left = 184
      Top = 74
      Width = 39
      Height = 24
      MaxValue = 255
      MinValue = 1
      TabOrder = 4
      Value = 1
    end
    object SpEd_COff: TSpinEdit
      Left = 184
      Top = 99
      Width = 39
      Height = 24
      MaxValue = 255
      MinValue = 1
      TabOrder = 5
      Value = 1
    end
  end
  object BB_Close: TBitBtn
    Left = 251
    Top = 251
    Width = 105
    Height = 29
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 2
    OnClick = BB_CloseClick
    Kind = bkClose
  end
  object GrB_List: TGroupBox
    Left = 4
    Top = 169
    Width = 230
    Height = 75
    Caption = #1055#1077#1095#1072#1090#1100
    TabOrder = 3
    object Label3: TLabel
      Left = 12
      Top = 49
      Width = 26
      Height = 15
      Caption = #1051#1080#1089#1090
    end
    object Label4: TLabel
      Left = 101
      Top = 49
      Width = 31
      Height = 15
      Caption = #1095#1072#1089#1090#1100
    end
    object RB_All: TRadioButton
      Left = 11
      Top = 25
      Width = 50
      Height = 15
      Caption = #1042#1089#1077
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = RB_StrClick
    end
    object RB_Str: TRadioButton
      Left = 95
      Top = 25
      Width = 100
      Height = 15
      Caption = #1055#1086' '#1083#1080#1089#1090#1072#1084
      TabOrder = 1
      OnClick = RB_StrClick
    end
    object CB_str: TComboBox
      Left = 46
      Top = 46
      Width = 50
      Height = 23
      Enabled = False
      ItemHeight = 15
      TabOrder = 2
      OnChange = CB_strChange
    end
    object CB_Col: TComboBox
      Left = 148
      Top = 49
      Width = 51
      Height = 23
      Enabled = False
      ItemHeight = 15
      TabOrder = 3
    end
  end
  object BB_Print: TBitBtn
    Left = 251
    Top = 164
    Width = 105
    Height = 29
    Caption = #1051#1072#1079#1077#1088#1085#1099#1081
    TabOrder = 4
    OnClick = BitBtn1Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
      8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
      8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
      8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    NumGlyphs = 2
  end
  object MatrixCheckBox: TCheckBox
    Left = 250
    Top = 200
    Width = 89
    Height = 17
    Caption = #1052#1072#1090#1088#1080#1095#1085#1099#1081
    TabOrder = 5
  end
  object SaveF: TSaveDialog
    Left = 320
    Top = 124
  end
end
