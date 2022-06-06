object frmReport: TfrmReport
  Left = 371
  Top = 146
  BorderStyle = bsDialog
  Caption = #1054#1090#1095#1077#1090#1099
  ClientHeight = 470
  ClientWidth = 580
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Courier New'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    580
    470)
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 232
    Width = 72
    Height = 16
    Caption = #1047#1072' '#1087#1077#1088#1080#1086#1076
  end
  object Label2: TLabel
    Left = 328
    Top = 232
    Width = 16
    Height = 16
    Caption = #1087#1086
  end
  object Label3: TLabel
    Left = 88
    Top = 232
    Width = 8
    Height = 16
    Caption = #1089
  end
  object Label4: TLabel
    Left = 8
    Top = 264
    Width = 40
    Height = 16
    Alignment = taRightJustify
    Caption = #1056#1072#1081#1086#1085
  end
  object Label5: TLabel
    Left = 192
    Top = 264
    Width = 24
    Height = 16
    Alignment = taRightJustify
    Caption = #1056#1050#1057
  end
  object Label6: TLabel
    Left = 368
    Top = 264
    Width = 56
    Height = 16
    Alignment = taRightJustify
    Caption = #1044#1080#1072#1084#1077#1090#1088
  end
  object Label7: TLabel
    Left = 8
    Top = 248
    Width = 40
    Height = 16
    Alignment = taRightJustify
    Caption = #1059#1083#1080#1094#1072
  end
  object ckDiam: TCheckListBox
    Left = 272
    Top = 280
    Width = 105
    Height = 145
    ItemHeight = 16
    TabOrder = 13
    Visible = False
  end
  object cbULIC: TRxDBLookupCombo
    Left = 56
    Top = 248
    Width = 465
    Height = 25
    DropDownCount = 8
    DisplayAllFields = True
    LookupField = 'ID'
    LookupDisplay = 'V_NAME;UL_NAME'
    LookupDisplayIndex = 1
    LookupSource = dsULIC
    TabOrder = 9
  end
  object ckRayon: TCheckListBox
    Left = 8
    Top = 279
    Width = 145
    Height = 145
    ItemHeight = 16
    TabOrder = 12
    Visible = False
  end
  object ckRKS: TCheckListBox
    Left = 160
    Top = 280
    Width = 105
    Height = 145
    ItemHeight = 16
    TabOrder = 11
    Visible = False
  end
  object lbRep: TListBox
    Left = 0
    Top = 0
    Width = 580
    Height = 225
    Align = alTop
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ItemHeight = 16
    ParentFont = False
    TabOrder = 0
    OnClick = lbRepClick
  end
  object dtBegin: TDateTimePicker
    Left = 104
    Top = 232
    Width = 121
    Height = 24
    Date = 37356.645959641200000000
    Time = 37356.645959641200000000
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object tmBegin: TDateTimePicker
    Left = 232
    Top = 232
    Width = 89
    Height = 24
    Date = 37356.333333333300000000
    Time = 37356.333333333300000000
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    Kind = dtkTime
    ParentFont = False
    TabOrder = 2
  end
  object dtEnd: TDateTimePicker
    Left = 352
    Top = 232
    Width = 121
    Height = 24
    Date = 37356.645959641200000000
    Time = 37356.645959641200000000
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object tmEnd: TDateTimePicker
    Left = 480
    Top = 232
    Width = 89
    Height = 24
    Date = 37356.333333333300000000
    Time = 37356.333333333300000000
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    Kind = dtkTime
    ParentFont = False
    TabOrder = 4
  end
  object bBegin: TBitBtn
    Left = 341
    Top = 438
    Width = 114
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
    TabOrder = 5
    OnClick = bBeginClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FF00FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF00FF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000000000BFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FFFFFF
      BFBFBFFFFFFFBFBFBFFFFFFFBFBFBFFFFFFFBFBFBFFFFFFFBFBFBFFFFFFFBFBF
      BFFFFFFFBFBFBF000000000000BFBFBFFFFFFFBFBFBFFFFFFFBFBFBFFFFFFFBF
      BFBFFFFFFFBFBFBFFFFFFFBFBFBFFFFFFF0000FFFFFFFF000000000000FFFFFF
      BFBFBFFFFFFFBFBFBFFFFFFFBFBFBFFFFFFFBFBFBFFFFFFFBFBFBFFFFFFFBFBF
      BFFFFFFFBFBFBF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF00FFFF00FF
      FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
      00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFF00000000000000
      0000000000FFFFFF000000FFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
      00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFF000000000000FF
      FFFF000000000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000FF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFF000000BFBFBFFF
      FFFF000000FFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000000000000000000000
      0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
  end
  object cbRayon: TRxDBLookupCombo
    Left = 8
    Top = 280
    Width = 145
    Height = 25
    DropDownCount = 8
    LookupField = 'ID'
    LookupDisplay = 'NAME_R'
    LookupSource = dsRayon
    TabOrder = 6
  end
  object cbRKS: TRxDBLookupCombo
    Left = 160
    Top = 280
    Width = 105
    Height = 25
    DropDownCount = 8
    LookupField = 'ID'
    LookupDisplay = 'NAME_R'
    LookupSource = dsRKS
    TabOrder = 7
  end
  object cbDiam: TRxDBLookupCombo
    Left = 272
    Top = 280
    Width = 105
    Height = 25
    DropDownCount = 8
    LookupField = 'ID'
    LookupDisplay = 'DIAM'
    LookupSource = dsDiam
    TabOrder = 8
  end
  object BB_Exit: TBitBtn
    Left = 461
    Top = 438
    Width = 114
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&'#1042#1099#1093#1086#1076
    TabOrder = 10
    OnClick = BB_ExitClick
    Kind = bkClose
  end
  object qRayon: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select * '
      'from s_rayon'
      'where del='#39'-'#39' and id>-1'
      'order by name_r')
    Left = 24
    Top = 336
  end
  object dsRayon: TDataSource
    DataSet = qRayon
    Left = 56
    Top = 336
  end
  object qRKS: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select * '
      'from s_revs'
      'where del='#39'-'#39' and id>-1'
      'order by name_r')
    Left = 224
    Top = 336
  end
  object dsRKS: TDataSource
    DataSet = qRKS
    Left = 256
    Top = 336
  end
  object qDiam: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select * '
      'from s_diam'
      'where del='#39'-'#39' and id>-1'
      'order by diam')
    Left = 304
    Top = 328
  end
  object dsDiam: TDataSource
    DataSet = qDiam
    Left = 336
    Top = 328
  end
  object qULIC: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select u.id,u.name_r UL_name,cast(v.name_r as char(7)) V_name'
      'from s_ulic u,s_vidul v'
      'where u.del='#39'-'#39' and id>-1'
      '    and u.id_vidul=v.id'
      'order by u.name_r')
    Left = 280
    Top = 264
  end
  object dsULIC: TDataSource
    DataSet = qULIC
    Left = 312
    Top = 264
  end
end
