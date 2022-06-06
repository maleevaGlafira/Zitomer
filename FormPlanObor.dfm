inherited frm_PlanObor: Tfrm_PlanObor
  Left = 421
  Top = 292
  Width = 594
  Height = 311
  Caption = 'frm_PlanObor'
  OldCreateOrder = True
  Position = poMainFormCenter
  OnClose = v
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGr_Planobor: TDBGrid
    Left = 0
    Top = 0
    Width = 578
    Height = 229
    Align = alTop
    DataSource = Planobors_sur
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnEnter = DBGr_PlanoborEnter
    OnExit = DBGr_PlanoborExit
    Columns = <
      item
        Expanded = False
        FieldName = 'List_OBOR'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Title.Caption = #1055#1083#1072#1085#1080#1088#1091#1077#1084#1099#1077' '#1084#1077#1093#1072#1085#1080#1079#1084#1099
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 477
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 232
    Width = 578
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BB_Insert: TBitBtn
      Left = 13
      Top = 8
      Width = 90
      Height = 25
      Caption = #1042#1089'&'#1090#1072#1074#1080#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BB_InsertClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
        0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
        33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      NumGlyphs = 2
    end
    object BB_Delete: TBitBtn
      Left = 103
      Top = 8
      Width = 90
      Height = 25
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BB_DeleteClick
      Glyph.Data = {
        42010000424D4201000000000000760000002800000011000000110000000100
        040000000000CC00000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        888880000000888888888888888880000000888888888888880F800000008888
        0F888888888880000000888000F8888880F880000000888000F888880F888000
        00008888000F88800F888000000088888000F800F8888000000088888800000F
        8888800000008888888000F888888000000088888800000F8888800000008888
        8000F80F8888800000008880000F88800F8880000000880000F8888800F88000
        00008800F8888888800F80000000888888888888888880000000888888888888
        888880000000}
    end
    object BB_Save: TBitBtn
      Left = 193
      Top = 8
      Width = 90
      Height = 25
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BB_SaveClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
        00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
        00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
        00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
        0003737FFFFFFFFF7F7330099999999900333777777777777733}
      NumGlyphs = 2
    end
    object BB_Close: TBitBtn
      Left = 491
      Top = 8
      Width = 75
      Height = 25
      Caption = '&'#1042#1099#1093#1086#1076
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = BB_CloseClick
      Kind = bkClose
    end
  end
  object Planobors_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE planobors'
      'SET'
      '  id_zav = :id_zav,'
      '  id_nar = :id_nar,'
      '  id_obor = :id_obor'
      'WHERE'
      '  id = :OLD_ID'
      '')
    InsertSQL.Strings = (
      'INSERT INTO planobors (id_zav, id_nar, id_obor)'
      'VALUES  (:id_zav, :id_nar, :id_obor)'
      '')
    DeleteSQL.Strings = (
      'delete from planobors'
      'where'
      '  ID = :OLD_ID'
      '')
    Left = 400
    Top = 80
  end
  object Planobors_q: TQuery
    CachedUpdates = True
    BeforePost = Planobors_qBeforePost
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT id, id_zav, id_nar, id_obor'
      'FROM planobors'
      'WHERE (id_zav = :idZav)and'
      '               (id_nar = :idNar)'
      'ORDER BY id'
      '')
    UpdateObject = Planobors_upd
    Left = 384
    Top = 56
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'idZav'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'idNar'
        ParamType = ptUnknown
      end>
    object Planobors_qID: TIntegerField
      FieldName = 'ID'
    end
    object Planobors_qID_ZAV: TIntegerField
      FieldName = 'ID_ZAV'
    end
    object Planobors_qID_NAR: TIntegerField
      FieldName = 'ID_NAR'
    end
    object Planobors_qID_OBOR: TIntegerField
      FieldName = 'ID_OBOR'
    end
    object Planobors_qList_OBOR: TStringField
      FieldKind = fkLookup
      FieldName = 'List_OBOR'
      LookupDataSet = DM1.S_Obor_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R_AND_FIO'
      KeyFields = 'ID_OBOR'
      Size = 60
      Lookup = True
    end
  end
  object Planobors_sur: TDataSource
    DataSet = Planobors_q
    OnUpdateData = Planobors_surUpdateData
    Left = 400
    Top = 112
  end
  object Qry_tmp: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 488
    Top = 60
  end
end
