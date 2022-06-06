object FormSprav: TFormSprav
  Left = 265
  Top = 129
  Width = 423
  Height = 400
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 415
    Height = 373
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Label2: TLabel
      Left = 6
      Top = 10
      Width = 32
      Height = 13
      Caption = #1055#1086#1080#1089#1082
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 282
      Top = 9
      Width = 81
      Height = 13
      Caption = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 3
      Top = 29
      Width = 406
      Height = 10
      Shape = bsTopLine
    end
    object Bevel2: TBevel
      Left = 4
      Top = 334
      Width = 406
      Height = 10
      Shape = bsTopLine
    end
    object ChB_Sort: TCheckBox
      Left = 289
      Top = 346
      Width = 135
      Height = 15
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1087#1086' '#1087#1086#1083#1102
      TabOrder = 0
      Visible = False
      OnClick = ChB_SortClick
    end
    object Ed_Find: TEdit
      Left = 42
      Top = 5
      Width = 231
      Height = 21
      TabOrder = 1
      OnChange = Ed_FindChange
    end
    object BB_Insert: TBitBtn
      Left = 6
      Top = 340
      Width = 95
      Height = 27
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
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
      Left = 101
      Top = 340
      Width = 95
      Height = 27
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
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
      Left = 196
      Top = 340
      Width = 95
      Height = 27
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = BB_SaveClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003333330FFFFF
        FFF03333337F3FFFF3F73333330F0000F0F03333337F777737373333330FFFFF
        FFF033FFFF7FFF33FFF77000000007F00000377777777FF777770BBBBBBBB0F0
        FF037777777777F7F3730B77777BB0F0F0337777777777F7F7330B7FFFFFB0F0
        0333777F333377F77F330B7FFFFFB0009333777F333377777FF30B7FFFFFB039
        9933777F333377F777FF0B7FFFFFB0999993777F33337777777F0B7FFFFFB999
        9999777F3333777777770B7FFFFFB0399933777FFFFF77F777F3070077007039
        99337777777777F777F30B770077B039993377FFFFFF77F777330BB7007BB999
        93337777FF777777733370000000073333333777777773333333}
      NumGlyphs = 2
    end
    object SpEd_Font: TSpinEdit
      Left = 369
      Top = 5
      Width = 40
      Height = 22
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 30
      MinValue = 6
      ParentFont = False
      TabOrder = 5
      Value = 6
      OnChange = SpEd_FontChange
    end
    object BB_Close: TBitBtn
      Left = 313
      Top = 341
      Width = 95
      Height = 27
      Caption = #1042#1099#1093#1086#1076
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = BB_CloseClick
      Kind = bkClose
    end
    object DBGr_SP: TRxDBGrid
      Left = 5
      Top = 33
      Width = 404
      Height = 299
      DataSource = DS_SP
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ParentFont = False
      TabOrder = 7
      TitleFont.Charset = RUSSIAN_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
      OnKeyDown = DBGr0_SPKeyDown
      MultiSelect = True
    end
  end
  object Qry_SP: TQuery
    CachedUpdates = True
    AfterInsert = Qry_SPAfterInsert
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select * from s_brig')
    UpdateObject = UpdSP
    Left = 100
    Top = 96
  end
  object UpdSP: TUpdateSQL
    ModifySQL.Strings = (
      'update s_brig set name_r=:name_r,dolgn=:dolgn'
      'where id=:id')
    InsertSQL.Strings = (
      'insert into s_brig (name_r,dolgn) values ("'#1042#1072#1089#1103'","123")')
    Left = 168
    Top = 92
  end
  object DS_SP: TDataSource
    DataSet = Qry_SP
    OnUpdateData = DS_SPUpdateData
    Left = 92
    Top = 156
  end
  object Qry_prov: TQuery
    Left = 152
    Top = 144
  end
end
