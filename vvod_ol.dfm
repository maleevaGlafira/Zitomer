object FormVvod: TFormVvod
  Left = 222
  Top = 187
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1042#1099#1073#1086#1088
  ClientHeight = 358
  ClientWidth = 635
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 358
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    DesignSize = (
      635
      358)
    object Bevel1: TBevel
      Left = 4
      Top = 324
      Width = 629
      Height = 12
      Shape = bsTopLine
    end
    object BShowonMap: TSpeedButton
      Left = 7
      Top = 328
      Width = 30
      Height = 25
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1079#1072#1103#1074#1082#1091' '#1085#1072' '#1082#1072#1088#1090#1077
      Glyph.Data = {
        06020000424D0602000000000000760000002800000028000000140000000100
        0400000000009001000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        33333333333333333333333FFFF3333FFFF33333330000333300003333333377
        77FF337777FF33333033360330333603333F37F3377F37F3377F330330FFF303
        30F3F303337337F3337F37F3337F303330FFF303303FF30337F337F3337FF7F3
        337F3033303FF307703FF30337F337FFFF7777FFFF7F30330700003000000073
        37F377777737777777733030733333333033073337F773333333373F77333707
        3333333333003333377733333333337733333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        33333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BShowonMapClick
    end
    object DBLL_Vvod: TRxDBLookupList
      Left = 5
      Top = 30
      Width = 626
      Height = 274
      Ctl3D = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      LookupField = 'TrimVVod'
      LookupDisplay = 'TrimVVod'
      LookupSource = DS_Sour
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      TabStop = False
      OnDblClick = DBLL_VvodDblClick
      OnKeyDown = DBLL_VvodKeyDown
    end
    object BB_Ok: TBitBtn
      Left = 458
      Top = 328
      Width = 85
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100
      Default = True
      ModalResult = 1
      TabOrder = 2
      OnClick = BB_OkClick
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
    object BB_ESC: TBitBtn
      Left = 546
      Top = 328
      Width = 85
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 3
      OnClick = BB_ESCClick
      Kind = bkCancel
    end
    object Find_ed: TEdit
      Left = 5
      Top = 5
      Width = 624
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnChange = Find_edChange
      OnKeyDown = Find_edKeyDown
    end
    object BB_DeleteAll: TBitBtn
      Left = 40
      Top = 329
      Width = 129
      Height = 25
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
      TabOrder = 4
      OnClick = BB_DeleteAllClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
        555557777F777555F55500000000555055557777777755F75555005500055055
        555577F5777F57555555005550055555555577FF577F5FF55555500550050055
        5555577FF77577FF555555005050110555555577F757777FF555555505099910
        555555FF75777777FF555005550999910555577F5F77777775F5500505509990
        3055577F75F77777575F55005055090B030555775755777575755555555550B0
        B03055555F555757575755550555550B0B335555755555757555555555555550
        BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
        50BB555555555555575F555555555555550B5555555555555575}
      NumGlyphs = 2
    end
  end
  object Qry_Sour: TQuery
    OnCalcFields = Qry_SourCalcFields
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'select cast(nomer as char(6))||"    "||cast(dt_in as char(20)) v' +
        'vod,'
      'nzavjav.id as id,'
      '(select rtrim(u.name_r)||" "||rtrim(v.name_r)'
      ' from s_ulic u,s_vidul v'
      
        ' where (u.del in ('#39'-'#39','#39'd'#39')) and (u.id_vidul>-2) and (u.id_vidul=' +
        'v.id)'
      '  and (u.id=z.id_ul1)) as ul1, '
      '(select rtrim(u.name_r)||" "||rtrim(v.name_r)'
      ' from s_ulic u,s_vidul v'
      
        ' where (u.del in ('#39'-'#39','#39'd'#39')) and (u.id_vidul>-2) and (u.id_vidul=' +
        'v.id)'
      '  and (u.id=z.id_ul1)) as vvod1,'
      'id_ul2, kod_ul, dop_adr,dt_in, is_otl'
      'from nzavjav z'
      'where (delz=0) and '
      '(id_attach=1)'
      'order by fyear desc,nomer desc')
    Left = 88
    Top = 12
    object Qry_SourTrimVVod: TStringField
      FieldKind = fkCalculated
      FieldName = 'TrimVVod'
      Size = 100
      Calculated = True
    end
    object Qry_SourVvod: TStringField
      FieldName = 'Vvod'
      Size = 70
    end
    object Qry_SourImgCount: TStringField
      FieldKind = fkCalculated
      FieldName = 'ImgCount'
      Size = 2
      Calculated = True
    end
    object Qry_SourId: TIntegerField
      FieldName = 'Id'
    end
    object Qry_SourUL1: TStringField
      FieldName = 'UL1'
      Size = 161
    end
    object Qry_SourID_UL2: TStringField
      FieldName = 'ID_UL2'
      FixedChar = True
      Size = 8
    end
    object Qry_SourKOD_UL: TIntegerField
      FieldName = 'KOD_UL'
    end
    object Qry_SourDOP_ADR: TStringField
      FieldName = 'DOP_ADR'
      Size = 40
    end
    object Qry_SourDT_IN: TDateTimeField
      FieldName = 'DT_IN'
    end
    object Qry_SourID_DOPADRES: TIntegerField
      FieldName = 'ID_DOPADRES'
    end
    object Qry_SourID_OBJECT: TIntegerField
      FieldName = 'ID_OBJECT'
    end
    object Qry_Souris_otl: TIntegerField
      FieldName = 'is_otl'
    end
    object Qry_Sourc_is_otl: TStringField
      FieldKind = fkCalculated
      FieldName = 'c_is_otl'
      Calculated = True
    end
  end
  object DS_Sour: TDataSource
    DataSet = Qry_Sour
    Left = 28
    Top = 12
  end
  object Qry_Find: TQuery
    OnCalcFields = Qry_SourCalcFields
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select z.id'
      'from nzavjav z'
      ' left join s_ulic on z.id_ul1=s_ulic.id'
      'where (delz=0) and '
      '(id_attach=1) and '
      
        '((dt_in=:dt_in) or (nomer=:nomer) or (dop_adr like UPPER(:dop_ad' +
        'r)) or '
      ' (s_ulic.name_r like UPPER(:ul1)))'
      'order by fyear desc,nomer desc')
    Left = 40
    Top = 84
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'dt_in'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'nomer'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'dop_adr'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ul1'
        ParamType = ptInput
      end>
    object Qry_FindID: TIntegerField
      FieldName = 'ID'
    end
  end
  object Qry_tmp: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 176
    Top = 80
  end
end
