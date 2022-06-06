object NastrF: TNastrF
  Left = 189
  Top = 203
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 261
  ClientWidth = 347
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Nastr_pc: TPageControl
    Left = 0
    Top = 0
    Width = 348
    Height = 229
    ActivePage = General_pg
    TabOrder = 0
    object General_pg: TTabSheet
      Caption = #1054#1073#1097#1080#1077
      object TPanel
        Left = 9
        Top = 12
        Width = 321
        Height = 179
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object lbPRN: TLabel
          Left = 8
          Top = 136
          Width = 168
          Height = 13
          Caption = #1055#1088#1080#1085#1090#1077#1088'('#1074#1086#1079#1084#1086#1078#1085#1086' '#1089#1077#1090#1077#1074#1086#1077' '#1080#1084#1103')'
        end
        object Label1: TLabel
          Left = 8
          Top = 104
          Width = 194
          Height = 26
          Caption = #1055#1088#1086#1074#1077#1088#1103#1090#1100' '#1079#1072#1082#1088#1099#1090#1099#1077' '#1085#1072#1088#1103#1076#1099' '#1087#1086#1079#1078#1077',  '#13#10#1095#1077#1084' '#1079#1072' '#1076#1072#1085#1085#1086#1077' '#1082#1086#1083'-'#1074#1086' '#1076#1085#1077#1081
        end
        object MainFPlacement_chb: TCheckBox
          Left = 16
          Top = 72
          Width = 293
          Height = 17
          Caption = #1057#1086#1093#1088#1072#1085#1103#1090#1100' '#1088#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1077' '#1075#1083#1072#1074#1085#1086#1081' '#1092#1086#1088#1084#1099
          TabOrder = 0
        end
        object GroupBox1: TGroupBox
          Left = 8
          Top = 8
          Width = 121
          Height = 57
          Caption = #1071#1079#1099#1082
          TabOrder = 1
          Visible = False
          object RB_langUA: TRadioButton
            Left = 8
            Top = 16
            Width = 89
            Height = 17
            Caption = #1059#1082#1088#1072#1080#1085#1089#1082#1080#1081
            Checked = True
            TabOrder = 0
            TabStop = True
          end
          object RB_langRU: TRadioButton
            Left = 8
            Top = 32
            Width = 73
            Height = 17
            Caption = #1056#1091#1089#1089#1082#1080#1081
            TabOrder = 1
          end
        end
        object edPRNpath: TEdit
          Left = 16
          Top = 152
          Width = 289
          Height = 21
          TabOrder = 2
          Text = 'PRN'
        end
        object spe_days: TSpinEdit
          Left = 216
          Top = 112
          Width = 65
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 3
          Value = 0
          OnChange = spe_daysChange
        end
      end
    end
    object Color_pg: TTabSheet
      Caption = #1062#1074#1077#1090#1072
      ImageIndex = 1
      object TPanel
        Left = 3
        Top = 5
        Width = 330
        Height = 189
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Lb_mess: TLabel
          Left = 9
          Top = 92
          Width = 78
          Height = 13
          Caption = #1069#1090#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
          OnClick = Lb_messClick
        end
        object Lb_vid: TLabel
          Left = 9
          Top = 113
          Width = 170
          Height = 16
          Caption = #1069#1090#1086' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          OnClick = Lb_vidClick
        end
        object Lb_err: TLabel
          Left = 9
          Top = 135
          Width = 160
          Height = 16
          Caption = #1069#1090#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1077' '#1086#1073' '#1086#1096#1080#1073#1082#1077
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          OnClick = Lb_errClick
        end
        object ClGr: TColorGrid
          Left = 194
          Top = 5
          Width = 128
          Height = 148
          ForegroundIndex = 6
          BackgroundIndex = 1
          TabOrder = 0
          OnChange = ClGrChange
        end
        object LB_vib: TListBox
          Left = 7
          Top = 7
          Width = 182
          Height = 81
          ItemHeight = 13
          Items.Strings = (
            #1057#1086#1086#1073#1097#1077#1085#1080#1077
            #1042#1099#1076#1077#1083#1077#1085#1085#1086#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
            #1057#1086#1086#1073#1097#1077#1085#1080#1103' '#1086#1073' '#1086#1096#1080#1073#1082#1072#1093
            #1055#1086#1083#1103' '#1074#1074#1086#1076#1072)
          TabOrder = 1
          OnClick = LB_vibClick
        end
        object CB_Sam: TComboBox
          Left = 9
          Top = 158
          Width = 180
          Height = 21
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 2
          Text = #1069#1090#1086' '#1087#1086#1083#1077' '#1074#1074#1086#1076#1072
          OnClick = CB_SamClick
          OnDblClick = CB_SamClick
          OnEnter = CB_SamClick
          Items.Strings = (
            #1042#1099#1073#1086#1088' 1'
            #1042#1099#1073#1086#1088' 2'
            #1042#1099#1073#1086#1088' 3')
        end
        object BB_Def: TBitBtn
          Left = 195
          Top = 155
          Width = 128
          Height = 25
          Caption = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
          TabOrder = 3
          OnClick = BB_DefClick
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 228
    Width = 347
    Height = 33
    Align = alBottom
    TabOrder = 1
    OnClick = Panel1Click
    object BtOk: TBitBtn
      Left = 158
      Top = 4
      Width = 90
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100
      TabOrder = 0
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
    object BtCancel: TBitBtn
      Left = 252
      Top = 4
      Width = 90
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = BtCancelClick
      Kind = bkAbort
    end
  end
end
