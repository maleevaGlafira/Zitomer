object FormSpUl: TFormSpUl
  Left = 260
  Top = 174
  Width = 554
  Height = 460
  Caption = 'Справочник улиц'
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 239
    Top = 402
    Width = 95
    Height = 16
    Caption = 'Размер шрифта'
  end
  object DBGr_SpUl: TRxDBGrid
    Left = 8
    Top = 4
    Width = 437
    Height = 337
    DataSource = DS_SpUl
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = RUSSIAN_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    OnCellClick = DBGr_SpUlCellClick
    OnDblClick = DBGr_SpUlDblClick
    Columns = <
      item
        FieldName = 'NAME_R'
        Title.Caption = 'Наименование'
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 167
      end
      item
        FieldName = 'vidul_look'
        Title.Caption = 'вид ул.'
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 71
      end
      item
        FieldName = 'ORINT'
        Title.Caption = 'Ориентир'
      end>
  end
  object BB_Insert: TBitBtn
    Left = 4
    Top = 349
    Width = 90
    Height = 33
    Caption = 'Вставить'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
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
  object BB_Delete: TBitBtn
    Left = 100
    Top = 349
    Width = 90
    Height = 33
    Caption = 'Удалить'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = BB_DeleteClick
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
  object BB_Save: TBitBtn
    Left = 196
    Top = 349
    Width = 90
    Height = 33
    Caption = 'Сохранить'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
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
    Left = 345
    Top = 392
    Width = 49
    Height = 26
    MaxValue = 30
    MinValue = 6
    TabOrder = 4
    Value = 6
  end
  object BB_Close: TBitBtn
    Left = 432
    Top = 345
    Width = 90
    Height = 33
    Caption = 'Закрыть'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = BB_CloseClick
    Kind = bkClose
  end
  object DS_SpUl: TDataSource
    DataSet = Qry_SpUl
    Left = 48
    Top = 100
  end
  object Qry_SpUl: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r ,id_vidul,orint from s_ulic ')
    UpdateObject = UpdSpUl
    Left = 128
    Top = 112
    object Qry_SpUlID: TIntegerField
      FieldName = 'ID'
    end
    object Qry_SpUlNAME_R: TStringField
      FieldName = 'NAME_R'
    end
    object Qry_SpUlID_VIDUL: TIntegerField
      FieldName = 'ID_VIDUL'
    end
    object Qry_SpUlvidul_look: TStringField
      FieldName = 'vidul_look'
      LookupDataSet = Qry_vidul
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_VIDUL'
      Size = 10
      Lookup = True
    end
    object Qry_SpUlORINT: TStringField
      FieldName = 'ORINT'
    end
  end
  object UpdSpUl: TUpdateSQL
    ModifySQL.Strings = (
      'update s_ulic'
      'set'
      '  NAME_R = :NAME_R,'
      '  ID_VIDUL = :ID_VIDUL,'
      '  ORINT = :ORINT'
      'where'
      '  ID = :OLD_ID')
    InsertSQL.Strings = (
      'insert into s_ulic'
      '  (NAME_R, ID_VIDUL, ORINT)'
      'values'
      '  (:NAME_R, :ID_VIDUL, :ORINT)')
    DeleteSQL.Strings = (
      'delete from s_ulic'
      'where'
      '  ID = :OLD_ID')
    Left = 196
    Top = 108
  end
  object Qry_vidul: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select * from s_vidul order by name_r')
    Left = 444
    Top = 64
  end
  object DS_vidul: TDataSource
    DataSet = Qry_vidul
    Left = 452
    Top = 120
  end
end
