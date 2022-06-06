object FormSSah: TFormSSah
  Left = 237
  Top = 123
  Width = 496
  Height = 358
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1074#1077#1076#1086#1084#1086#1089#1090#1080' '#1091#1095#1077#1090#1072' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1081
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 4
    Top = 7
    Width = 63
    Height = 15
    Caption = #1058#1080#1087' '#1079#1072#1103#1074#1082#1080
  end
  object DBL_tzav: TRxDBLookupCombo
    Left = 74
    Top = 4
    Width = 202
    Height = 22
    DropDownCount = 8
    LookupField = 'NAME_R'
    LookupDisplay = 'NAME_R'
    LookupSource = DS_stzav
    TabOrder = 0
    OnChange = DBL_tzavChange
  end
  object DBG_sod: TRxDBGrid
    Left = 4
    Top = 28
    Width = 477
    Height = 262
    DataSource = DS_ssod
    TabOrder = 1
    TitleFont.Charset = RUSSIAN_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    OnKeyDown = DBG_sodKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'NAME_R'
        ReadOnly = True
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SahLook'
        Title.Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1100
        Visible = True
      end>
  end
  object BB_Close: TBitBtn
    Left = 388
    Top = 296
    Width = 93
    Height = 30
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 2
    OnClick = BB_CloseClick
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
  object BB_Save: TBitBtn
    Left = 4
    Top = 296
    Width = 92
    Height = 30
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 3
    OnClick = BB_SaveClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
      7700333333337777777733333333008088003333333377F73377333333330088
      88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
      000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
      FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
      99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
      99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
      99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
      93337FFFF7737777733300000033333333337777773333333333}
    NumGlyphs = 2
  end
  object Qry_stzav: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select * from s_tzav where id>0')
    Left = 200
    Top = 4
  end
  object Qry_ssod: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select * from s_sod where id>0')
    UpdateObject = Upd_ssod
    Left = 308
    Top = 152
    object Qry_ssodID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_SOD.ID'
    end
    object Qry_ssodTYPE: TIntegerField
      FieldName = 'FTYPE'
      Origin = 'S_SOD.FTYPE'
    end
    object Qry_ssodNAME_R: TStringField
      FieldName = 'NAME_R'
      Origin = 'S_SOD.NAME_R'
      Size = 40
    end
    object Qry_ssodSAH: TIntegerField
      FieldName = 'SAH'
      Origin = 'S_SOD.SAH'
    end
    object Qry_ssodSahLook: TStringField
      FieldKind = fkLookup
      FieldName = 'SahLook'
      LookupDataSet = Qry_ssah
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'SAH'
      Lookup = True
    end
  end
  object Qry_ssah: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select * from s_sah order by name_r')
    Left = 448
    Top = 80
  end
  object DS_stzav: TDataSource
    DataSet = Qry_stzav
    Left = 244
    Top = 8
  end
  object DS_ssod: TDataSource
    DataSet = Qry_ssod
    OnUpdateData = DS_ssodUpdateData
    Left = 248
    Top = 192
  end
  object Upd_ssod: TUpdateSQL
    ModifySQL.Strings = (
      'update s_sod'
      'set'
      '  SAH = :SAH'
      'where'
      '  ID = :OLD_ID')
    Left = 352
    Top = 148
  end
end
