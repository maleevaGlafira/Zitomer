object frm_materstobrig: Tfrm_materstobrig
  Left = 123
  Top = 140
  Width = 1287
  Height = 807
  Caption = 'frm_materstobrig'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 681
    Height = 89
    TabOrder = 0
    object lbl_brigcap: TLabel
      Left = 19
      Top = 14
      Width = 57
      Height = 13
      Caption = #1041#1088#1080#1075#1072#1076#1080#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_report_cap: TLabel
      Left = 461
      Top = 18
      Width = 25
      Height = 13
      Caption = #1047#1074#1110#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btn_openFile: TButton
      Left = 8
      Top = 48
      Width = 121
      Height = 25
      Caption = #1047#1072#1074#1072#1085#1090#1072#1078#1080#1090#1080
      TabOrder = 0
      OnClick = btn_openFileClick
    end
    object btn_SavedReport: TButton
      Left = 136
      Top = 48
      Width = 145
      Height = 25
      Caption = #1047#1073#1077#1088#1077#1075#1090#1080' '#1074#1110#1076#1082#1088#1080#1090#1080#1081' '#1079#1074#1110#1090
      TabOrder = 1
      WordWrap = True
      OnClick = btn_SavedReportClick
    end
    object btn_openFromBase: TButton
      Left = 456
      Top = 56
      Width = 113
      Height = 25
      Caption = #1042#1110#1076#1082#1088#1080#1090#1080' '#1079#1074#1110#1090
      TabOrder = 3
      OnClick = btn_openFromBaseClick
    end
    object btn_close_report: TButton
      Left = 576
      Top = 56
      Width = 89
      Height = 25
      Caption = #1047#1072#1082#1088#1080#1090#1080' '#1079#1074#1110#1090
      TabOrder = 2
      OnClick = btn_close_reportClick
    end
    object rxdbReports: TRxDBLookupCombo
      Left = 490
      Top = 13
      Width = 159
      Height = 21
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'show_title'
      LookupSource = ds_reports
      TabOrder = 4
    end
    object RxLbBrigs: TRxDBLookupCombo
      Left = 106
      Top = 13
      Width = 345
      Height = 21
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'CONCATENATION'
      LookupSource = ds_brigs
      TabOrder = 5
      OnChange = RxLbBrigsChange
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 750
    Width = 1271
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object pnl_report: TPanel
    Left = -8
    Top = 90
    Width = 681
    Height = 623
    Caption = 'pnl_report'
    TabOrder = 2
    object lbl_report_title: TLabel
      Left = 17
      Top = 145
      Width = 82
      Height = 13
      Alignment = taCenter
      Caption = 'lbl_report_title'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object lbl_MaterReportCap: TLabel
      Left = 16
      Top = 128
      Width = 140
      Height = 16
      Caption = 'lbl_MaterReportCap'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBGridEh_Report: TDBGridEh
      Left = 8
      Top = 184
      Width = 665
      Height = 393
      DataSource = DataSource1
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      RowHeight = 18
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitleHeight = 20
      Columns = <
        item
          FieldName = 'kod'
          Footers = <>
          Title.Caption = #1082#1086#1076
          Width = 74
        end
        item
          FieldName = 'name'
          Footers = <>
          Title.Caption = 'Yfbvtyjdfybt'
          Width = 295
        end
        item
          FieldName = 'Units'
          Footers = <>
          Width = 38
        end
        item
          FieldName = 'price'
          Footers = <>
          Width = 44
        end
        item
          FieldName = 'left'
          Footers = <>
          Width = 43
        end
        item
          FieldName = 'all_q'
          Footers = <>
          Width = 46
        end
        item
          AutoFitColWidth = False
          FieldName = 'is_storage'
          Footers = <>
          ReadOnly = True
          Width = 40
        end
        item
          FieldName = 'name_col'
          Footers = <>
          Width = 50
        end>
    end
    object tbn_addmatertorep: TBitBtn
      Left = 408
      Top = 592
      Width = 155
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1084#1072#1090#1077#1088#1080#1072#1083
      TabOrder = 1
      Visible = False
      OnClick = tbn_addmatertorepClick
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000120B0000120B00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FBFBFB00EEEEEE00DADADA00CDCDCD00CDCDCD00DADA
        DA00F2F2F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FBFBFB00E7E7E700C2C2C200A0A0A00097979700B0B0
        B000DADADA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00F9F9F900EEEEEE000000000000000000000000009696
        9600CDCDCD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFB
        FB00EFEFEF00E1E1E100E1E1E100EBEBEB000000000000000000000000008787
        8700A7A7A700CDCDCD00DADADA00F2F2F200FFFFFF00FFFFFF00FFFFFF00FCFC
        FC00E8E8E800CBCBCB00C1C1C100D5D5D5000000000000000000000000008282
        82008080800090909000B0B0B000DADADA00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FAFAFA000000000000000000000000000000000000000000000000000000
        00000000000000000000A0A0A000CFCFCF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00313131001B1B1B00151515001313130000000000000000000000
        00000000000000000000B3B3B300D5D5D500FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00878787008686860077777700555555001F1F1F00000000000606
        06000505050000000000DCDCDC00E7E7E700FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00717171002525250000000000F5F5
        F500FFFFFF00FFFFFF00FCFCFC00F8F8F800FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007E7E7E003434340000000000E0E0
        E000FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008D8D8D005858580000000000E6E6
        E600F2F2F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFD
        FD00FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
    end
  end
  object Panel3: TPanel
    Left = 683
    Top = -3
    Width = 585
    Height = 92
    TabOrder = 3
    object lbl_depscaption: TLabel
      Left = 11
      Top = 14
      Width = 51
      Height = 16
      Caption = #1042#1080#1111#1079#1076#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 80
      Top = 16
      Width = 7
      Height = 13
      Caption = #1057
    end
    object Label4: TLabel
      Left = 246
      Top = 12
      Width = 12
      Height = 13
      Caption = #1087#1086
    end
    object lb_brig2: TLabel
      Left = 24
      Top = 40
      Width = 46
      Height = 13
      Caption = 'lb_brig2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_repp: TLabel
      Left = 392
      Top = 40
      Width = 20
      Height = 13
      Caption = #1047#1074#1110#1090
    end
    object btn_searchdeps: TButton
      Left = 16
      Top = 63
      Width = 161
      Height = 25
      Caption = #1055#1086#1080#1089#1082' '#1074#1110#1077#1079#1076#1086#1074
      Enabled = False
      TabOrder = 0
      OnClick = btn_searchdepsClick
    end
    object de_start: TDateEdit
      Left = 106
      Top = 9
      Width = 121
      Height = 21
      NumGlyphs = 2
      TabOrder = 1
    end
    object de_end: TDateEdit
      Left = 272
      Top = 9
      Width = 121
      Height = 21
      NumGlyphs = 2
      TabOrder = 2
    end
    object RxDBL_brigs2: TRxDBLookupCombo
      Left = 106
      Top = 38
      Width = 279
      Height = 21
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'NAME_R'
      LookupSource = ds_brigs2
      TabOrder = 3
    end
    object RxDBLreports_out: TRxDBLookupCombo
      Left = 418
      Top = 37
      Width = 159
      Height = 21
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'show_title'
      LookupSource = ds_repsout
      TabOrder = 4
    end
    object Button1: TButton
      Left = 416
      Top = 64
      Width = 89
      Height = 25
      Caption = '+ '#1044#1086#1076#1072#1090#1080' '#1079#1074#1110#1090
      TabOrder = 5
      OnClick = Button1Click
    end
    object btn_closedeps: TButton
      Left = 184
      Top = 64
      Width = 113
      Height = 25
      Caption = 'btn_closedeps'
      TabOrder = 6
      OnClick = btn_closedepsClick
    end
  end
  object pnl_deps: TPanel
    Left = 682
    Top = 90
    Width = 585
    Height = 623
    TabOrder = 4
    object lbl_titledeps: TLabel
      Left = 9
      Top = 256
      Width = 45
      Height = 13
      Alignment = taCenter
      Caption = #1056#1072#1073#1086#1090#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_used_maters: TLabel
      Left = 10
      Top = 138
      Width = 221
      Height = 13
      Caption = #1048#1089#1087#1086#1083#1100#1079#1091#1077#1084#1099#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1099' '#1074' '#1074#1099#1077#1079#1076#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_depaddinfo: TLabel
      Left = 7
      Top = 79
      Width = 227
      Height = 13
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1074#1099#1077#1079#1076#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBGridEh1: TDBGridEh
      Left = 8
      Top = 272
      Width = 569
      Height = 345
      DataSource = ds_deps
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      RowHeight = 18
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitleHeight = 20
      OnCellClick = DBGridEh1CellClick
      Columns = <
        item
          FieldName = 'nomer'
          Footers = <>
          Title.Caption = #1053#1072#1088#1103#1076
          Width = 53
        end
        item
          FieldName = 'nnomer'
          Footers = <>
          Title.Caption = #8470' '#1042#1099#1077#1079#1076#1072
          Width = 50
        end
        item
          FieldName = 'dt'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072
          Width = 160
        end
        item
          FieldName = 'address'
          Footers = <>
          Title.Caption = #1040#1076#1088#1077#1089
          Width = 163
        end
        item
          ButtonStyle = cbsEllipsis
          EndEllipsis = True
          Footers = <>
        end>
    end
    object mem_depinfo: TMemo
      Left = 8
      Top = 99
      Width = 569
      Height = 34
      TabOrder = 1
    end
    object DBGrid_depmatrers: TDBGridEh
      Left = 8
      Top = 160
      Width = 569
      Height = 96
      DataSource = ds_depmaters
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = DBGrid_depmatrersDblClick
      OnEnter = DBGrid_depmatrersEnter
      Columns = <
        item
          FieldName = 'kod'
          Footers = <>
        end
        item
          FieldName = 'name'
          Footers = <>
          Width = 234
        end
        item
          FieldName = 'all_q'
          Footers = <>
          Width = 33
        end
        item
          FieldName = 'price'
          Footers = <>
          Width = 36
        end
        item
          FieldName = 'units'
          Footers = <>
          Width = 33
        end
        item
          FieldName = 'report_out_name'
          Footers = <>
          Width = 112
        end
        item
          FieldName = 'is_his'
          Footers = <>
          Title.Caption = ' '
          Width = 18
        end
        item
          FieldName = 'report_name'
          Footers = <>
          Title.Caption = #1047#1074#1110#1076#1082#1080
        end>
    end
  end
  object pnl_addmater: TPanel
    Left = 472
    Top = 8
    Width = 529
    Height = 281
    TabOrder = 5
    object btn_add: TSpeedButton
      Left = 360
      Top = 211
      Width = 23
      Height = 22
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000120B0000120B00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FBFBFB00EEEEEE00DADADA00CDCDCD00CDCDCD00DADA
        DA00F2F2F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FBFBFB00E7E7E700C2C2C200A0A0A00097979700B0B0
        B000DADADA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00F9F9F900EEEEEE000000000000000000000000009696
        9600CDCDCD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFB
        FB00EFEFEF00E1E1E100E1E1E100EBEBEB000000000000000000000000008787
        8700A7A7A700CDCDCD00DADADA00F2F2F200FFFFFF00FFFFFF00FFFFFF00FCFC
        FC00E8E8E800CBCBCB00C1C1C100D5D5D5000000000000000000000000008282
        82008080800090909000B0B0B000DADADA00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FAFAFA000000000000000000000000000000000000000000000000000000
        00000000000000000000A0A0A000CFCFCF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00313131001B1B1B00151515001313130000000000000000000000
        00000000000000000000B3B3B300D5D5D500FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00878787008686860077777700555555001F1F1F00000000000606
        06000505050000000000DCDCDC00E7E7E700FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00717171002525250000000000F5F5
        F500FFFFFF00FFFFFF00FCFCFC00F8F8F800FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007E7E7E003434340000000000E0E0
        E000FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008D8D8D005858580000000000E6E6
        E600F2F2F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFD
        FD00FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      Visible = False
      OnClick = btn_addClick
    end
    object btn_minus: TSpeedButton
      Left = 336
      Top = 211
      Width = 23
      Height = 22
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000120B0000120B00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFB
        FB00F4F4F400E9E9E900DDDDDD00D7D7D700D4D4D400D4D4D400D4D4D400D4D4
        D400D4D4D400D8D8D800E0E0E000EBEBEB00F6F6F600FDFDFD00FFFFFF00F6F6
        F600DFDFDF00BBBBBB0096969600808080007777770077777700777777007777
        7700797979008181810098989800BCBCBC00E1E1E100F7F7F700FFFFFF00F8F8
        F800D3D3D300999999005D5D5D00404040004040400040404000404040004040
        40004040400040404000484848007E7E7E00C2C2C200EEEEEE00FFFFFF00FFFF
        FF00F4F4F40019191900121212000C0C0C000A0A0A0009090900090909000909
        090009090900080808000909090071717100B6B6B600EAEAEA00FFFFFF00FFFF
        FF00FFFFFF00505050002B2B2B00121212000101010000000000000000000000
        00000000000000000000131313009C9C9C00C5C5C500EDEDED00FFFFFF00FFFF
        FF00FFFFFF00939393009C9C9C00949494008C8C8C008C8C8C008C8C8C008B8B
        8B007C7C7C005656560023232300E2E2E200E6E6E600F6F6F600FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      Visible = False
      OnClick = btn_minusClick
    end
    object lbl_used: TLabel
      Left = 16
      Top = 216
      Width = 72
      Height = 13
      Caption = #1048#1089#1087#1086#1083#1100#1079#1091#1077#1090#1089#1103
    end
    object sp_removeall: TSpeedButton
      Left = 232
      Top = 211
      Width = 23
      Height = 22
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFF0FFFFFFFF0FFFFFF0FFFFFF000FFFFFF0FFFF00000FFFFFF0FF000000
        0FFFFFF0FFFF00000FFFFFF0FFFFFF000FFFFFF0FFFFFFFF0FFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = sp_removeallClick
    end
    object sp_addall: TSpeedButton
      Left = 257
      Top = 211
      Width = 23
      Height = 22
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFF0FFFFFFFF0FFFFFF000FFFFFF0FFFFFF00000FFFF0FFFFFF0000000FF
        0FFFFFF00000FFFF0FFFFFF000FFFFFF0FFFFFF0FFFFFFFF0FFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = sp_addallClick
    end
    object mem_titleadd: TMemo
      Left = 1
      Top = 1
      Width = 527
      Height = 24
      Align = alTop
      Alignment = taCenter
      BevelInner = bvNone
      BevelOuter = bvRaised
      BorderStyle = bsNone
      Color = clGradientInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      TabOrder = 0
    end
    object gb_departure: TGroupBox
      Left = 8
      Top = 40
      Width = 257
      Height = 97
      Caption = #1042#1099#1077#1079#1076
      TabOrder = 1
      object lbl_dep_address: TLabel
        Left = 9
        Top = 76
        Width = 98
        Height = 13
        Caption = #1091#1083'. '#1050#1083#1086#1095#1082#1086#1074#1089#1082#1072#1103' 25'
      end
      object Lbl_order: TLabel
        Left = 94
        Top = 18
        Width = 35
        Height = 13
        Caption = ' '#1053#1072#1088#1103#1076
      end
      object lbl_numorder: TLabel
        Left = 134
        Top = 18
        Width = 59
        Height = 13
        Caption = #8470'2 20201'#1088'.'
      end
      object lbl_dep_date: TLabel
        Left = 9
        Top = 56
        Width = 192
        Height = 13
        Caption = '05.05.2021 08:00  ---   05.05.2021 12:00'
      end
      object lbl_numdep: TLabel
        Left = 8
        Top = 18
        Width = 17
        Height = 13
        Caption = #8470'1'
      end
    end
    object gb_material: TGroupBox
      Left = 268
      Top = 40
      Width = 253
      Height = 98
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083
      TabOrder = 3
      object lbl_left: TLabel
        Left = 8
        Top = 80
        Width = 49
        Height = 13
        Caption = #1054#1089#1090#1072#1083#1086#1089#1100
      end
      object lbl_left_q: TLabel
        Left = 101
        Top = 80
        Width = 45
        Height = 13
        Caption = '2222,000'
      end
      object lbl_units: TLabel
        Left = 148
        Top = 79
        Width = 13
        Height = 13
        Caption = #1096#1090
      end
      object lbl_matprice: TLabel
        Left = 183
        Top = 51
        Width = 59
        Height = 13
        Caption = '2209,20 '#1075#1088#1085
      end
      object lbl_kod: TLabel
        Left = 8
        Top = 56
        Width = 34
        Height = 13
        Caption = 'lbl_kod'
      end
      object lbl_mat_name: TMemo
        Left = 8
        Top = 15
        Width = 233
        Height = 33
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = clBtnFace
        Lines.Strings = (
          'lbl_mat_name')
        TabOrder = 0
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 248
      Width = 527
      Height = 32
      Align = alBottom
      TabOrder = 2
      object bb_canceladd: TBitBtn
        Left = 108
        Top = 4
        Width = 75
        Height = 22
        Cancel = True
        Caption = #1042#1110#1076#1084#1110#1085#1072
        TabOrder = 0
        OnClick = bb_canceladdClick
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
      object btn_savemater: TBitBtn
        Left = 17
        Top = 4
        Width = 86
        Height = 22
        Caption = #1047#1073#1077#1088#1077#1075#1090#1080
        Default = True
        Enabled = False
        TabOrder = 1
        OnClick = btn_savematerClick
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
    object ce_matquan: TRxSpinEdit
      Left = 120
      Top = 213
      Width = 105
      Height = 21
      Decimal = 3
      Increment = 0.010000000000000000
      ValueType = vtFloat
      TabOrder = 4
      OnChange = ce_matquanChange
      OnKeyUp = ce_matquanKeyUp
    end
    object gb_out_repcap: TGroupBox
      Left = 8
      Top = 144
      Width = 513
      Height = 57
      Caption = 'gb_out_repcap'
      TabOrder = 5
      object lbl_brigname: TLabel
        Left = 16
        Top = 24
        Width = 59
        Height = 13
        Caption = 'lbl_brigname'
      end
      object lbl_year: TLabel
        Left = 368
        Top = 24
        Width = 36
        Height = 13
        Caption = 'lbl_year'
      end
      object lbl_month: TLabel
        Left = 416
        Top = 24
        Width = 45
        Height = 13
        Caption = 'lbl_month'
      end
    end
  end
  object pnl_actions: TPanel
    Left = 0
    Top = 717
    Width = 1271
    Height = 33
    Align = alBottom
    TabOrder = 6
    object btn_addmater: TBitBtn
      Left = 15
      Top = 4
      Width = 98
      Height = 25
      Caption = #1044#1086#1073#1072#1080#1090#1100
      TabOrder = 0
      OnClick = btn_addmaterClick
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000120B0000120B00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FBFBFB00EEEEEE00DADADA00CDCDCD00CDCDCD00DADA
        DA00F2F2F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FBFBFB00E7E7E700C2C2C200A0A0A00097979700B0B0
        B000DADADA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00F9F9F900EEEEEE000000000000000000000000009696
        9600CDCDCD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFB
        FB00EFEFEF00E1E1E100E1E1E100EBEBEB000000000000000000000000008787
        8700A7A7A700CDCDCD00DADADA00F2F2F200FFFFFF00FFFFFF00FFFFFF00FCFC
        FC00E8E8E800CBCBCB00C1C1C100D5D5D5000000000000000000000000008282
        82008080800090909000B0B0B000DADADA00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FAFAFA000000000000000000000000000000000000000000000000000000
        00000000000000000000A0A0A000CFCFCF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00313131001B1B1B00151515001313130000000000000000000000
        00000000000000000000B3B3B300D5D5D500FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00878787008686860077777700555555001F1F1F00000000000606
        06000505050000000000DCDCDC00E7E7E700FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00717171002525250000000000F5F5
        F500FFFFFF00FFFFFF00FCFCFC00F8F8F800FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007E7E7E003434340000000000E0E0
        E000FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008D8D8D005858580000000000E6E6
        E600F2F2F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFD
        FD00FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
    end
    object btn_change: TBitBtn
      Left = 116
      Top = 3
      Width = 75
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 1
      OnClick = btn_changeClick
    end
    object btn_delete: TBitBtn
      Left = 195
      Top = 3
      Width = 86
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 2
      OnClick = btn_deleteClick
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000120B0000120B00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFB
        FB00F4F4F400E9E9E900DDDDDD00D7D7D700D4D4D400D4D4D400D4D4D400D4D4
        D400D4D4D400D8D8D800E0E0E000EBEBEB00F6F6F600FDFDFD00FFFFFF00F6F6
        F600DFDFDF00BBBBBB0096969600808080007777770077777700777777007777
        7700797979008181810098989800BCBCBC00E1E1E100F7F7F700FFFFFF00F8F8
        F800D3D3D300999999005D5D5D00404040004040400040404000404040004040
        40004040400040404000484848007E7E7E00C2C2C200EEEEEE00FFFFFF00FFFF
        FF00F4F4F40019191900121212000C0C0C000A0A0A0009090900090909000909
        090009090900080808000909090071717100B6B6B600EAEAEA00FFFFFF00FFFF
        FF00FFFFFF00505050002B2B2B00121212000101010000000000000000000000
        00000000000000000000131313009C9C9C00C5C5C500EDEDED00FFFFFF00FFFF
        FF00FFFFFF00939393009C9C9C00949494008C8C8C008C8C8C008C8C8C008B8B
        8B007C7C7C005656560023232300E2E2E200E6E6E600F6F6F600FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
    end
    object bb_close: TBitBtn
      Left = 294
      Top = 3
      Width = 75
      Height = 25
      TabOrder = 3
      Kind = bkClose
    end
  end
  object OpenDialog1: TOpenDialog
    FileName = 'E:\temp\'#1071#1088#1080#1085#1086#1074#1089#1100#1082#1080#1081' '#1082#1074#1110#1090#1077#1085#1100'.xlsx'
    Filter = 'Exel|*.xlsx'
    Left = 256
    Top = 96
  end
  object DataSource1: TDataSource
    DataSet = dm_MatersMasters.mem_main
    Left = 600
    Top = 304
  end
  object ds_brigs: TDataSource
    DataSet = dm_MatersMasters.dset_brigs
    Left = 400
    Top = 16
  end
  object ds_reports: TDataSource
    DataSet = dm_MatersMasters.dset_reports
    Left = 624
    Top = 16
  end
  object ds_deps: TDataSource
    DataSet = dm_MatersMasters.mem_deps
    Left = 1112
    Top = 368
  end
  object ds_depmaters: TDataSource
    DataSet = dm_MatersMasters.mem_depmaters
    Left = 1000
    Top = 240
  end
  object ds_brigs2: TDataSource
    DataSet = dm_MatersMasters.dset_brigs2
    Left = 995
    Top = 53
  end
  object ds_repsout: TDataSource
    DataSet = dm_MatersMasters.dset_out_reports
    Left = 1139
    Top = 21
  end
end
