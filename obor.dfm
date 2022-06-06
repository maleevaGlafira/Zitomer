object FormObor: TFormObor
  Left = 346
  Top = 280
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
  ClientHeight = 470
  ClientWidth = 704
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 704
    Height = 451
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Bevel1: TBevel
      Left = 4
      Top = 402
      Width = 805
      Height = 13
      Shape = bsTopLine
    end
    object DBGr_Obor: TDBGrid
      Left = 4
      Top = 4
      Width = 285
      Height = 13
      DataSource = Obors_sur
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = RUSSIAN_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      Visible = False
      OnEnter = DBGr_OborEnter
      OnExit = DBGr_OborExit
      Columns = <
        item
          Expanded = False
          FieldName = 'List_Obor'
          Title.Alignment = taCenter
          Title.Caption = #1052#1077#1093#1072#1085#1080#1079#1084#1099
          Width = 215
          Visible = True
        end>
    end
    object BB_Insert: TBitBtn
      Left = 5
      Top = 408
      Width = 90
      Height = 25
      Caption = #1042#1089'&'#1090#1072#1074#1080#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
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
      Left = 95
      Top = 408
      Width = 90
      Height = 25
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
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
      Left = 185
      Top = 408
      Width = 90
      Height = 25
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
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
    object BB_Up: TBitBtn
      Left = 275
      Top = 408
      Width = 29
      Height = 25
      TabOrder = 4
      OnClick = BB_UpClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
        3333333333777F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
        3333333777737777F333333099999990333333373F3333373333333309999903
        333333337F33337F33333333099999033333333373F333733333333330999033
        3333333337F337F3333333333099903333333333373F37333333333333090333
        33333333337F7F33333333333309033333333333337373333333333333303333
        333333333337F333333333333330333333333333333733333333}
      NumGlyphs = 2
    end
    object BB_DLD: TBitBtn
      Left = 318
      Top = 408
      Width = 123
      Height = 25
      Caption = '&'#1041#1099#1089#1090#1088#1086#1077' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Visible = False
      OnClick = BB_DLDClick
    end
    object BB_Close: TBitBtn
      Left = 619
      Top = 408
      Width = 75
      Height = 25
      Caption = '&'#1042#1099#1093#1086#1076
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = BB_CloseClick
      Kind = bkClose
    end
    object DBGr_Planobor: TDBGrid
      Left = 291
      Top = 4
      Width = 279
      Height = 13
      DataSource = Planobors_sur
      TabOrder = 7
      TitleFont.Charset = RUSSIAN_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
      Visible = False
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
          Width = 215
          Visible = True
        end>
    end
    object dbg_Instrum: TDBGrid
      Left = 4
      Top = 27
      Width = 337
      Height = 358
      DataSource = Instrum_sur
      TabOrder = 8
      TitleFont.Charset = RUSSIAN_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
      OnEnter = dbg_InstrumEnter
      OnExit = dbg_InstrumExit
      Columns = <
        item
          Expanded = False
          FieldName = 'lp_INSTRUM'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Title.Alignment = taCenter
          Title.Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
          Title.Font.Charset = RUSSIAN_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 265
          Visible = True
        end>
    end
    object dbg_ObjObor: TDBGrid
      Left = 352
      Top = 27
      Width = 337
      Height = 358
      DataSource = objobor_sur
      TabOrder = 9
      TitleFont.Charset = RUSSIAN_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
      Visible = False
      OnEnter = dbg_ObjOborEnter
      OnExit = dbg_ObjOborExit
      Columns = <
        item
          Expanded = False
          FieldName = 'lp_OBJOBOR'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Title.Alignment = taCenter
          Title.Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
          Title.Font.Charset = RUSSIAN_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 269
          Visible = True
        end>
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 451
    Width = 704
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object Qry_tmp: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 488
    Top = 4
  end
  object DLD_vib: TDualListDialog
    Sorted = True
    Title = #1042#1099#1073#1086#1088
    OkBtnCaption = #1042#1099#1073#1088#1072#1090#1100
    CancelBtnCaption = #1054#1090#1084#1077#1085#1072
    HelpContext = 0
    ShowHelp = False
    Left = 276
    Top = 8
  end
  object Timer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerTimer
    Left = 284
    Top = 52
  end
  object Obors_q: TQuery
    CachedUpdates = True
    BeforePost = Qr_BeforePost
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT id, id_zav, id_nar, id_obor'
      'FROM obors'
      'WHERE (id_zav = :idZav)and'
      '               (id_nar = :idNar)'
      'ORDER BY id')
    UpdateObject = Obors_upd
    Left = 112
    Top = 65532
    ParamData = <
      item
        DataType = ftInteger
        Name = 'idZav'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'idNar'
        ParamType = ptInput
      end>
    object Obors_qID: TIntegerField
      FieldName = 'ID'
    end
    object Obors_qID_ZAV: TIntegerField
      FieldName = 'ID_ZAV'
    end
    object Obors_qID_NAR: TIntegerField
      FieldName = 'ID_NAR'
    end
    object Obors_qID_OBOR: TIntegerField
      FieldName = 'ID_OBOR'
    end
    object Obors_qList_Obor: TStringField
      DisplayWidth = 52
      FieldKind = fkLookup
      FieldName = 'List_Obor'
      LookupDataSet = DM1.S_Obor_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R_AND_FIO'
      KeyFields = 'ID_OBOR'
      Size = 30
      Lookup = True
    end
  end
  object Obors_upd: TUpdateSQL
    ModifySQL.Strings = (
      'UPDATE obors'
      'SET'
      '  id_zav = :id_zav,'
      '  id_nar = :id_nar,'
      '  id_obor = :id_obor'
      'WHERE'
      '  id = :OLD_ID')
    InsertSQL.Strings = (
      'INSERT INTO obors (id_zav, id_nar, id_obor)'
      'VALUES  (:id_zav, :id_nar, :id_obor)')
    DeleteSQL.Strings = (
      'delete from obors'
      'where'
      '  ID = :OLD_ID')
    Left = 144
    Top = 12
  end
  object Obors_sur: TDataSource
    DataSet = Obors_q
    OnUpdateData = __DS_oborUpdateData
    Left = 120
    Top = 40
  end
  object Planobors_sur: TDataSource
    DataSet = Planobors_q
    OnUpdateData = __DS_planoborUpdateData
    Left = 400
    Top = 56
  end
  object Planobors_q: TQuery
    CachedUpdates = True
    BeforePost = Qr_BeforePost
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
      LookupDataSet = DM1.S_PlanObor_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_OBOR'
      Lookup = True
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
    Top = 24
  end
  object Instrum_sur: TDataSource
    DataSet = Instrum_q
    OnUpdateData = __DS_instrumUpdateData
    Left = 48
    Top = 288
  end
  object Instrum_q: TQuery
    CachedUpdates = True
    BeforePost = Qr_BeforePost
    DatabaseName = 'DBN_AVAR'
    RequestLive = True
    SQL.Strings = (
      'select id, id_zav, id_nar, id_instrum'
      'from instrum'
      'where (id_zav = :idZav)'
      'and (id_nar = :idNar)'
      'order by id')
    UpdateObject = instrum_upd
    Left = 72
    Top = 328
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
    object Instrum_qID: TIntegerField
      FieldName = 'ID'
    end
    object Instrum_qID_ZAV: TIntegerField
      FieldName = 'ID_ZAV'
    end
    object Instrum_qID_NAR: TIntegerField
      FieldName = 'ID_NAR'
    end
    object Instrum_qID_INSTRUM: TIntegerField
      FieldName = 'ID_INSTRUM'
    end
    object Instrum_qlp_INSTRUM: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_INSTRUM'
      LookupDataSet = DM1.s_instrum_q
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_INSTRUM'
      Size = 40
      Lookup = True
    end
  end
  object instrum_upd: TUpdateSQL
    ModifySQL.Strings = (
      'update instrum set'
      'id_zav = :id_zav,'
      'id_nar = :id_nar,'
      'id_instrum = :id_instrum'
      'where id = :id')
    InsertSQL.Strings = (
      'insert into instrum(id_zav, id_nar, id_instrum)'
      'values(:id_zav, :id_nar, :id_instrum)')
    DeleteSQL.Strings = (
      'delete from instrum where id = :old_id')
    Left = 136
    Top = 312
  end
  object objobor_q: TQuery
    CachedUpdates = True
    BeforePost = Qr_BeforePost
    DatabaseName = 'DBN_AVAR'
    RequestLive = True
    SQL.Strings = (
      'select id, id_zav, id_nar, id_objobor'
      'from objobor'
      'where (id_zav = :idZav)'
      'and (id_nar = :idNar)'
      'order by id')
    UpdateObject = objobor_upd
    Left = 472
    Top = 248
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
    object objobor_qID: TIntegerField
      FieldName = 'ID'
    end
    object objobor_qID_ZAV: TIntegerField
      FieldName = 'ID_ZAV'
    end
    object objobor_qID_NAR: TIntegerField
      FieldName = 'ID_NAR'
    end
    object objobor_qID_OBJOBOR: TIntegerField
      FieldName = 'ID_OBJOBOR'
    end
    object objobor_qlp_OBJOBOR: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_OBJOBOR'
      LookupDataSet = s_objobor_q
      LookupKeyFields = 'id'
      LookupResultField = 'name_r'
      KeyFields = 'ID_OBJOBOR'
      Size = 40
      Lookup = True
    end
  end
  object objobor_upd: TUpdateSQL
    ModifySQL.Strings = (
      'update objobor set'
      'id_zav = :id_zav,'
      'id_nar = :id_nar,'
      'id_objobor = :id_objobor'
      'where id = :id')
    InsertSQL.Strings = (
      'insert into objobor(id_zav, id_nar, id_objobor)'
      'values(:id_zav, :id_nar, :id_objobor)')
    DeleteSQL.Strings = (
      'delete from objobor where id = :old_id')
    Left = 408
    Top = 272
  end
  object objobor_sur: TDataSource
    DataSet = objobor_q
    OnUpdateData = __DS_objoborUpdateData
    Left = 432
    Top = 304
  end
  object s_objobor_q: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id, name_r, id_object, del'
      'from s_objobor'
      'where ( del = '#39'-'#39' ) and  ( id > 0 )'
      'and (id_object = :pObjectID)'
      'order by name_r')
    Left = 504
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pObjectID'
        ParamType = ptUnknown
      end>
    object s_objobor_qid: TIntegerField
      FieldName = 'id'
    end
    object s_objobor_qid_object: TIntegerField
      FieldName = 'id_object'
    end
    object s_objobor_qname_r: TStringField
      FieldName = 'name_r'
      Size = 40
    end
    object s_objobor_qdel: TStringField
      FieldName = 'del'
      Size = 1
    end
  end
  object s_objobor_sur: TDataSource
    DataSet = s_objobor_q
    Left = 560
    Top = 296
  end
end
