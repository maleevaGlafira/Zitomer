object CompZReferF: TCompZReferF
  Left = 101
  Top = 127
  BorderStyle = bsSingle
  Caption = #1057#1088#1072#1074#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1089#1087#1088#1072#1074#1082#1072
  ClientHeight = 390
  ClientWidth = 593
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inline Frm_Dt: TFrm_Date
    Left = 1
    Top = 2
    Width = 435
    Height = 37
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    inherited Label1: TLabel
      Top = 3
      Font.Height = -15
    end
    inherited Label2: TLabel
      Left = 200
      Font.Height = -15
    end
    inherited DE_In: TDateEdit
      Top = 1
      Width = 93
      Height = 21
      Font.Height = -15
      ButtonWidth = 18
      OnChange = DateChange
    end
    inherited Te_in: TDateTimePicker
      Left = 114
      Top = 1
      Width = 81
      Font.Height = -15
    end
    inherited DE_Out: TDateEdit
      Left = 220
      Top = 1
      Width = 95
      Height = 21
      Font.Height = -15
      ButtonWidth = 18
      OnChange = DateChange
    end
    inherited Te_Out: TDateTimePicker
      Left = 319
      Top = 1
      Width = 86
      Font.Height = -15
    end
  end
  object BtOk: TBitBtn
    Left = 410
    Top = 2
    Width = 110
    Height = 23
    Caption = #1055#1088#1080#1085#1103#1090#1100
    TabOrder = 1
    OnClick = BtOkClick
    Kind = bkOK
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 52
    Width = 594
    Height = 324
    ActivePage = TabSheet1
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = #1047#1072#1082#1088#1099#1090#1099#1077' '#1079#1072#1103#1074#1082#1080
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 586
        Height = 296
        Align = alClient
        DataSource = DataSource1
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -10
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = DBGridDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'REVS'
            Title.Alignment = taCenter
            Title.Caption = #1056#1069#1042#1057
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOMER'
            Title.Alignment = taCenter
            Title.Caption = #1053#1086#1084#1077#1088
            Width = 56
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ADR'
            Title.Alignment = taCenter
            Title.Caption = #1040#1076#1088#1077#1089
            Width = 272
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DT_IN'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
            Width = 138
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DT_OUT'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1079#1072#1082#1088#1099#1090#1080#1103
            Width = 134
            Visible = True
          end>
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1053#1077#1079#1072#1082#1088#1099#1090#1099#1077' '#1079#1072#1103#1074#1082#1080
      ImageIndex = 1
      object DBGrid2: TDBGrid
        Left = 0
        Top = 0
        Width = 586
        Height = 296
        Align = alClient
        DataSource = DataSource2
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -10
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = DBGridDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'REVS'
            Title.Alignment = taCenter
            Title.Caption = #1056#1069#1042#1057
            Width = 69
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOMER'
            Title.Alignment = taCenter
            Title.Caption = #1053#1086#1084#1077#1088
            Width = 52
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ADR'
            Title.Alignment = taCenter
            Title.Caption = #1040#1076#1088#1077#1089
            Width = 401
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DT_IN'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
            Width = 141
            Visible = True
          end>
      end
    end
  end
  object BExit: TBitBtn
    Left = 523
    Top = 26
    Width = 70
    Height = 24
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 3
    OnClick = BExitClick
    Kind = bkClose
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 371
    Width = 593
    Height = 19
    Panels = <
      item
        Width = 300
      end
      item
        Width = 50
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 27
    Width = 520
    Height = 24
    TabOrder = 5
    object Label1: TLabel
      Left = 85
      Top = 6
      Width = 58
      Height = 13
      Caption = #1058#1080#1087' '#1079#1072#1103#1074#1082#1080
    end
    object S_Tzav_lcb: TRxDBLookupCombo
      Left = 158
      Top = 2
      Width = 191
      Height = 20
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'NAME_R'
      LookupSource = S_Tzav_sur
      TabOrder = 0
      OnCloseUp = S_Tzav_lcbCloseUp
    end
    object StaticText1: TStaticText
      Left = 4
      Top = 3
      Width = 69
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = #1060#1080#1083#1100#1090#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object BPrint: TBitBtn
      Left = 362
      Top = 2
      Width = 114
      Height = 21
      Caption = #1055#1077#1095#1072#1090#1100
      TabOrder = 2
      OnClick = BPrintClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0777777777777770888888888888888F077777777777
        7770888888888888888F0000000000000000FFFFFFFFFFFFFFFF0F7F7F7F7F7F
        7F70888888888888888F07F7F7F7F7F7F9F0888888888888888F0F7F7F7F7F7F
        7F708888888888888F8F0000000000000000888888888888888F3330FFFFFFFF
        03333338F3FFFF3F8F333330F0000F0F03333338F88883838F333330FFFFFFFF
        03333338F3FF3FFF8F333330F00F000003333338F883888883333330FFFF0FF0
        33333338F3FF8F3833333330F07F0F0333333338F8838F8333333330FFFF0033
        33333338FFFF8833333333300000033333333338888883333333}
      NumGlyphs = 2
    end
  end
  object BB_zav: TBitBtn
    Left = 522
    Top = 1
    Width = 71
    Height = 23
    Caption = #1047#1072#1103#1074#1082#1072
    TabOrder = 6
    OnClick = DBGridDblClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333FF3333333333333C0C333333333333F777F3333333333CC0F0C3
      333333333777377F33333333C30F0F0C333333337F737377F333333C00FFF0F0
      C33333F7773337377F333CC0FFFFFF0F0C3337773F33337377F3C30F0FFFFFF0
      F0C37F7373F33337377F00FFF0FFFFFF0F0C7733373F333373770FFFFF0FFFFF
      F0F073F33373F333373730FFFFF0FFFFFF03373F33373F333F73330FFFFF0FFF
      00333373F33373FF77333330FFFFF000333333373F333777333333330FFF0333
      3333333373FF7333333333333000333333333333377733333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 44
    Top = 176
  end
  object Query1: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'SELECT z.id, z.nomer,  sr.name_r as revs, z.dt_in, z.dt_out, id_' +
        'tzav,'
      
        '                  z.id_ul1, z.id_ul2, z.kod_ul, cast('#39'  '#39' as cha' +
        'r(70)) as adr, z.dop_adr'
      'FROM zavjav z,s_sod sd,s_diam dm,s_revs sr'
      
        'WHERE (delz=0) and sd.id=z.id_sod and sr.id=-z.id_to and dm.id=z' +
        '.id_diam')
    UpdateObject = UpdateSQL1
    Left = 44
    Top = 120
  end
  object DataSource2: TDataSource
    DataSet = Query2
    Left = 132
    Top = 180
  end
  object Query2: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'SELECT z.id, z.nomer, sd.name_r, sr.name_r as revs, z.dt_in, id_' +
        'tzav,'
      
        '                  z.id_ul1, z.id_ul2, z.kod_ul, cast('#39'  '#39' as cha' +
        'r(70)) as adr, z.dop_adr'
      'FROM nzavjav z,s_sod sd,s_diam dm,s_revs sr'
      
        'WHERE (delz=0) and sd.id=z.id_sod and sr.id=-z.id_to and dm.id=z' +
        '.id_diam')
    UpdateObject = UpdateSQL2
    Left = 132
    Top = 124
  end
  object UpdateSQL1: TUpdateSQL
    Left = 44
    Top = 230
  end
  object Qry_ul2: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'select u.id id,u.name_r||" "||v.name_r name_r from s_ulic u,s_vi' +
        'dul v'
      'where u.id_vidul=v.id')
    Left = 348
    Top = 176
  end
  object Qry_ul1: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'select u.id id,u.name_r||" "||v.name_r name_r from s_ulic u,s_vi' +
        'dul v'
      'where u.id_vidul=v.id')
    Left = 400
    Top = 176
  end
  object UpdateSQL2: TUpdateSQL
    Left = 132
    Top = 230
  end
  object S_Tzav_q: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id, name_r'
      'from S_Tzav')
    Left = 236
    Top = 124
  end
  object S_Tzav_sur: TDataSource
    DataSet = S_Tzav_q
    Left = 236
    Top = 179
  end
end
