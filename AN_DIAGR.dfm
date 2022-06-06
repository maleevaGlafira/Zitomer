object QueryForm: TQueryForm
  Left = 367
  Top = 330
  BorderIcons = [biSystemMenu, biMinimize, biHelp]
  BorderStyle = bsSingle
  Caption = #1040#1085#1072#1083#1080#1079' '#1040#1042#1056' '#1087#1086' '#1091#1083#1080#1094#1072#1084
  ClientHeight = 248
  ClientWidth = 373
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel
    Left = 190
    Top = 176
    Width = 179
    Height = 34
  end
  object lbSreet: TLabel
    Left = 4
    Top = 3
    Width = 173
    Height = 16
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1091#1083#1080#1094#1099':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 210
    Top = 185
    Width = 73
    Height = 16
    Caption = #1044#1080#1072#1084#1077#1090#1088' :'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gbNum: TGroupBox
    Left = 186
    Top = 46
    Width = 182
    Height = 51
    Caption = ' '#1053#1086#1084#1077#1088#1072' ('#1076#1086#1084#1072') '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 9
      Top = 22
      Width = 9
      Height = 16
      Caption = 'c'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 84
      Top = 22
      Width = 19
      Height = 16
      Caption = #1087#1086
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object seNum1: TSpinEdit
      Left = 23
      Top = 18
      Width = 50
      Height = 26
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      MaxValue = 999
      MinValue = 1
      ParentFont = False
      TabOrder = 0
      Value = 1
      OnChange = Changing
      OnEnter = seNum1Enter
      OnExit = seNum1Exit
    end
    object seNum2: TSpinEdit
      Left = 110
      Top = 18
      Width = 51
      Height = 26
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      MaxValue = 999
      MinValue = 1
      ParentFont = False
      TabOrder = 1
      Value = 100
      OnChange = Changing
      OnEnter = seNum2Enter
      OnExit = seNum2Exit
    end
  end
  object gbYear: TGroupBox
    Left = 6
    Top = 46
    Width = 176
    Height = 51
    Caption = ' '#1055#1077#1088#1080#1086#1076' ('#1075#1086#1076#1072') '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 0
    object Label3: TLabel
      Left = 9
      Top = 22
      Width = 9
      Height = 16
      Caption = 'c'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 84
      Top = 22
      Width = 19
      Height = 16
      Caption = #1087#1086
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object seYear1: TSpinEdit
      Left = 23
      Top = 18
      Width = 50
      Height = 26
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      MaxValue = 2100
      MinValue = 1992
      ParentFont = False
      TabOrder = 0
      Value = 2006
      OnChange = Changing
      OnEnter = seYear1Enter
      OnExit = seYear1Exit
    end
    object seYear2: TSpinEdit
      Left = 110
      Top = 18
      Width = 51
      Height = 26
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      MaxValue = 2100
      MinValue = 1992
      ParentFont = False
      TabOrder = 1
      Value = 1999
      OnChange = Changing
      OnEnter = seYear2Enter
      OnExit = seYear2Exit
    end
  end
  object btDiagram: TBitBtn
    Left = 5
    Top = 222
    Width = 79
    Height = 22
    Caption = #1043#1088#1072#1092#1080#1082
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btDiagramClick
  end
  object gbGraph: TGroupBox
    Tag = 1
    Left = 189
    Top = 99
    Width = 180
    Height = 72
    Caption = ' '#1042#1080#1076' '#1075#1088#1072#1092#1080#1082#1072' '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 2
    object rbMatrix: TRadioButton
      Tag = 2
      Left = 7
      Top = 34
      Width = 138
      Height = 15
      Caption = #1075#1086#1076#1086#1074#1072#1103' '#1084#1072#1090#1088#1080#1094#1072' '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = rbGraphClick
      OnEnter = rbMatrixEnter
      OnExit = rbMatrixExit
    end
    object rbAdd: TRadioButton
      Tag = 3
      Left = 7
      Top = 50
      Width = 163
      Height = 15
      Caption = #1089#1091#1084#1084#1080#1088#1091#1102#1097#1072#1103' '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = rbGraphClick
      OnEnter = rbAddEnter
      OnExit = rbAddExit
    end
    object rbDinam: TRadioButton
      Tag = 1
      Left = 7
      Top = 19
      Width = 146
      Height = 15
      Caption = #1075#1086#1076#1086#1074#1072#1103' '#1076#1080#1085#1072#1084#1080#1082#1072' '
      Checked = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = rbGraphClick
      OnEnter = rbDinamEnter
      OnExit = rbDinamExit
    end
  end
  object BitBtn1: TBitBtn
    Left = 305
    Top = 220
    Width = 66
    Height = 22
    Caption = #1042#1099#1093#1086#1076
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BitBtn1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
      F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
      000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
      338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
      45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
      3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
      F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
      000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
      338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
      4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
      8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
      333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
      0000}
    NumGlyphs = 2
  end
  object DBL_ul1: TRxDBLookupCombo
    Left = 5
    Top = 19
    Width = 364
    Height = 29
    DropDownCount = 8
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    LookupField = 'NAME_R'
    LookupDisplay = 'NAME_R'
    LookupSource = DS_ul1
    ParentFont = False
    TabOrder = 5
  end
  object DBL_Diam: TRxDBLookupCombo
    Left = 280
    Top = 179
    Width = 83
    Height = 29
    DropDownCount = 8
    DisplayEmpty = '<'#1087#1091#1089#1090#1086'>'
    EmptyValue = '-1'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    IndexSwitch = False
    LookupField = 'ID'
    LookupDisplay = 'DIAM_STR'
    LookupSource = DM1.S_Diam_sur
    ParentFont = False
    TabOrder = 6
  end
  object chb_tzav: TCheckListBox
    Left = 6
    Top = 106
    Width = 173
    Height = 103
    Color = clBtnFace
    ItemHeight = 15
    TabOrder = 7
    OnClick = Changing
  end
  object Qry_Zavjav: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 336
    Top = 128
  end
  object DS_ul1: TDataSource
    DataSet = Qry_ul1
    Left = 160
    Top = 24
  end
  object Qry_ul1: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select u.id id,u.name_r||" "||v.name_r name_r,u.orint  '
      'from s_ulic u,s_vidul v'
      'where u.del in ('#39'-'#39','#39'd'#39') and u.id_vidul>-2 and u.id_vidul=v.id '
      'order by u.name_r')
    Left = 196
    Top = 24
  end
end
