inherited WithoutWaterForm: TWithoutWaterForm
  Left = 173
  Top = 374
  BorderStyle = bsDialog
  Caption = #1040#1073#1086#1085#1077#1085#1090#1099', '#1086#1089#1090#1072#1074#1096#1080#1077#1089#1103' '#1073#1077#1079' '#1074#1086#1076#1099
  ClientHeight = 207
  ClientWidth = 692
  OldCreateOrder = True
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_Bottom: TPanel
    Left = 0
    Top = 174
    Width = 692
    Height = 33
    Align = alBottom
    TabOrder = 0
    object BB_Insert: TBitBtn
      Left = 3
      Top = 4
      Width = 81
      Height = 25
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      TabOrder = 0
      OnClick = BB_InsertClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333FF33333333FF333993333333300033377F3333333777333993333333
        300033F77FFF3333377739999993333333333777777F3333333F399999933333
        33003777777333333377333993333333330033377F3333333377333993333333
        3333333773333333333F333333333333330033333333F33333773333333C3333
        330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
        333333333337733333FF3333333C333330003333333733333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
    end
    object bb_edit: TBitBtn
      Left = 84
      Top = 4
      Width = 105
      Height = 25
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      TabOrder = 1
      OnClick = bb_editClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
        00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
        F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
        0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
        FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
        FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
        0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
        00333377737FFFFF773333303300000003333337337777777333}
      NumGlyphs = 2
    end
    object bb_post: TBitBtn
      Left = 189
      Top = 4
      Width = 89
      Height = 25
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100
      Enabled = False
      TabOrder = 2
      OnClick = bb_postClick
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
    object bb_cancel: TBitBtn
      Left = 278
      Top = 4
      Width = 83
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Enabled = False
      TabOrder = 3
      OnClick = bb_cancelClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333333333333333
        00003333003333333333333333F8333333333333000033300003333333333333
        3F88833333333333000033000000333333333333F88888333333333300003000
        000003333333333FFFF888833333333300003333003333333333333333F83333
        3333333300003333003333333333333333F83333333333330000333300333333
        3333333333F8333338F3333300003333003333300333333333F8333338F33333
        00003333003333300333333333F8333338F33333000033330003333003333333
        33F8833338F33333000033333000330003333333333F883388F3333300003333
        33000000333333333333F8888F33333300003333333000033333333333333FFF
        F333333300003333333333333333333333333333333333330000333333333333
        3333333333333333333333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object bb_delete: TBitBtn
      Left = 361
      Top = 4
      Width = 82
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 4
      OnClick = bb_deleteClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        300033FFFFFF3333377739999993333333333777777F3333333F399999933333
        3300377777733333337733333333333333003333333333333377333333333333
        3333333333333333333F333333333333330033333F33333333773333C3333333
        330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
        333333377F33333333FF3333C333333330003333733333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
    end
    object bb_exit: TBitBtn
      Left = 612
      Top = 4
      Width = 75
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      TabOrder = 5
      OnClick = bb_exitClick
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
  end
  object dbg_WWater: TDBGrid
    Left = 0
    Top = 0
    Width = 692
    Height = 174
    Align = alClient
    DataSource = ds_wwater
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'loop_ul'
        Title.Alignment = taCenter
        Title.Caption = #1059#1083#1080#1094#1072
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'house'
        Title.Alignment = taCenter
        Title.Caption = #1044#1086#1084
        Width = 236
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'comment'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1081
        Width = 376
        Visible = True
      end>
  end
  object qry_wwater: TQuery
    CachedUpdates = True
    AfterInsert = qry_wwaterAfterInsert
    AfterEdit = qry_wwaterAfterEdit
    BeforePost = qry_wwaterBeforePost
    AfterDelete = qry_wwaterAfterEdit
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id, id_zav, id_ul, house, comment'
      'from wwater'
      'where id_zav=:pID_ZAV')
    UpdateObject = upd_wwater
    Left = 40
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pID_ZAV'
        ParamType = ptUnknown
      end>
    object qry_wwaterid: TIntegerField
      FieldName = 'id'
    end
    object qry_wwaterid_zav: TIntegerField
      FieldName = 'id_zav'
    end
    object qry_wwaterid_ul: TIntegerField
      FieldName = 'id_ul'
    end
    object qry_wwaterhouse: TStringField
      DisplayWidth = 40
      FieldName = 'house'
      Size = 40
    end
    object qry_wwatercomment: TStringField
      FieldName = 'comment'
    end
    object qry_wwaterloop_ul: TStringField
      DisplayWidth = 100
      FieldKind = fkLookup
      FieldName = 'loop_ul'
      LookupDataSet = qry_ul
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'id_ul'
      Size = 100
      Lookup = True
    end
  end
  object upd_wwater: TUpdateSQL
    ModifySQL.Strings = (
      'update wwater'
      'set'
      '  ID_UL = :ID_UL,'
      '  HOUSE = :HOUSE,'
      '  COMMENT = :COMMENT'
      'where'
      '  ID = :ID')
    InsertSQL.Strings = (
      'insert into wwater'
      '  (ID_ZAV, ID_UL, HOUSE, COMMENT)'
      'values'
      '  (:ID_ZAV, :ID_UL, :HOUSE, :COMMENT)')
    DeleteSQL.Strings = (
      'delete from wwater'
      'where'
      '  ID = :OLD_ID')
    Left = 40
    Top = 96
  end
  object ds_wwater: TDataSource
    DataSet = qry_wwater
    Left = 40
    Top = 72
  end
  object qry_ul: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select u.id id, rtrim(u.name_r)||" "||rtrim(v.name_r) as name_r'
      'from s_ulic u,s_vidul v'
      'where u.del in ('#39'-'#39','#39'd'#39')'
      'and (u.id_vidul=v.id)'
      'order by u.name_r')
    Left = 184
    Top = 72
  end
end
