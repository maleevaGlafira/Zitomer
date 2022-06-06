object ObjOborForm: TObjOborForm
  Left = 290
  Top = 173
  Width = 804
  Height = 448
  BorderIcons = [biSystemMenu]
  Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 796
    Height = 373
    Align = alClient
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 481
      Top = 1
      Height = 371
    end
    object dbg_objoborzav: TDBGridEh
      Left = 1
      Top = 1
      Width = 480
      Height = 371
      Align = alLeft
      DataSource = ds_ObjOborZav
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          FieldName = 'INVENTAR'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1080#1085#1074'. '#8470
          Visible = False
          Width = 82
        end
        item
          DropDownSizing = True
          FieldName = 'look_objobor'
          Footers = <>
          Title.Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
          Width = 330
        end>
    end
    object Pnl_Type: TPanel
      Left = 484
      Top = 1
      Width = 311
      Height = 371
      Align = alClient
      TabOrder = 1
      object GroupGrid: TRxDBGrid
        Left = 1
        Top = 42
        Width = 309
        Height = 328
        Align = alClient
        DataSource = ds_OborGroup
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'NAME_TYPE'
            Title.Caption = #1057#1086#1089#1090#1072#1074
            Width = 196
            Visible = True
          end>
      end
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 309
        Height = 41
        Align = alTop
        TabOrder = 1
        object Label1: TLabel
          Left = 16
          Top = 16
          Width = 27
          Height = 13
          Caption = #1058#1080#1087':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Lbl_Type: TLabel
          Left = 48
          Top = 16
          Width = 3
          Height = 13
          Caption = ' '
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 373
    Width = 796
    Height = 41
    Align = alBottom
    TabOrder = 1
    object dbn_ObjOborZav: TDBNavigator
      Left = 8
      Top = 8
      Width = 228
      Height = 25
      DataSource = ds_ObjOborZav
      VisibleButtons = [nbFirst, nbLast, nbInsert, nbDelete, nbPost, nbCancel]
      TabOrder = 0
    end
    object BB_Save: TBitBtn
      Left = 291
      Top = 9
      Width = 102
      Height = 24
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1085#1091#1102' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
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
  end
  object IBTran: TIBTransaction
    Active = True
    DefaultDatabase = DM_main.IBDatabase
    Left = 136
    Top = 264
  end
  object dset_LookObjObor: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = IBTran
    SelectSQL.Strings = (
      'select soo.id'
      
        '    ,  (select fullname from GET_OBJOBOR_FULLNAME(soo.inventar, ' +
        'soo.name_r, soo.id_obortype)) name_r'
      
        '    , soo.id_object, soo.id_obortype, soo.id_soorug, soo.id_diam' +
        ', soo.del'
      '    from s_objobor soo, s_obortype sot'
      '      where ( soo.del = '#39'-'#39' ) and  ( soo.id > 0 )'
      '      and (sot.id = soo.id_obortype)'
      '      and ( id_object = :pIdObj )'
      '      and ( id_soorug = :pIdSoorug )'
      '      and ( soo.id_obortype >0 )'
      '    order by 2'
      '/*'
      'select id'
      
        ', (name_r||'#39' ('#39'||((select rtrim(so.name_r) from s_obortype so wh' +
        'ere so.id = s_objobor.id_obortype ))||'#39')'#39') name_r'
      ', id_object, id_obortype, id_soorug, id_diam, del'
      'from s_objobor'
      'where ( del = '#39'-'#39' ) and  ( id > 0 )'
      'and ( id_object = :pIdObj )'
      'and ( id_soorug = :pIdSoorug )'
      'order by name_r'
      '*/')
    Left = 176
    Top = 265
  end
  object ds_ObjOborZav: TDataSource
    DataSet = dset_ObjOborZav
    Left = 136
    Top = 224
  end
  object dset_ObjOborZav: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = IBTran
    AfterPost = dset_ObjOborZavAfterPost
    AfterScroll = NewAfterScroll
    BeforePost = dset_ObjOborZavBeforePost
    DeleteSQL.Strings = (
      'delete from objoborzav'
      'where id = :id')
    InsertSQL.Strings = (
      
        'insert into objoborzav (id_zav, id_objobor) values (:Id_Zav , :i' +
        'd_objobor)')
    SelectSQL.Strings = (
      'select oz.id, oz.id_zav, oz.id_objobor'
      ', so.name_r, so.id_obortype'
      
        ', (select name_r from s_obortype where id=so.id_obortype) name_t' +
        'ype'
      ', (select DIFFER from s_obortype where id=so.id_obortype) DIFFER'
      ', so.inventar'
      'from objoborzav oz, s_objobor so'
      'where ( so.id = oz.id_objobor )'
      'and ( so.del = '#39'-'#39' ) '
      'and ( oz.id_zav = :pIdZav )'
      'and ( so.id_object =  :pIdObj)'
      'and ( so.id_soorug =  :pIdSoorug)'
      'order by 4')
    ModifySQL.Strings = (
      'update objoborzav set'
      'id_zav = :pIdZav ,'
      'id_objobor = :id_objobor'
      'where id = :id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_OBJOBORZAV_ID'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 176
    Top = 225
    object dset_ObjOborZavID: TIntegerField
      FieldName = 'ID'
      Origin = 'OBJOBORZAV.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_ObjOborZavID_ZAV: TIntegerField
      FieldName = 'ID_ZAV'
      Origin = 'OBJOBORZAV.ID_ZAV'
    end
    object dset_ObjOborZavID_OBJOBOR: TIntegerField
      FieldName = 'ID_OBJOBOR'
      Origin = 'OBJOBORZAV.ID_OBJOBOR'
    end
    object dset_ObjOborZavNAME_R: TIBStringField
      FieldName = 'NAME_R'
      ProviderFlags = []
      Size = 40
    end
    object dset_ObjOborZavlook_objobor: TStringField
      FieldKind = fkLookup
      FieldName = 'look_objobor'
      LookupDataSet = dset_LookObjObor
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_OBJOBOR'
      Size = 60
      Lookup = True
    end
    object dset_ObjOborZavID_OBORTYPE: TIntegerField
      FieldName = 'ID_OBORTYPE'
      Origin = 'S_OBJOBOR.ID_OBORTYPE'
    end
    object dset_ObjOborZavNAME_TYPE: TIBStringField
      FieldName = 'NAME_TYPE'
      ProviderFlags = []
      FixedChar = True
      Size = 40
    end
    object dset_ObjOborZavDIFFER: TIntegerField
      FieldName = 'DIFFER'
      ProviderFlags = []
    end
    object dset_ObjOborZavINVENTAR: TIBStringField
      FieldName = 'INVENTAR'
      Origin = 'S_OBJOBOR.INVENTAR'
      FixedChar = True
    end
  end
  object dset_OborGroup: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = IBTran
    SelectSQL.Strings = (
      'SELECT s.id, s.Obortype,  s.detail, s.del'
      ', so.name_r name_type'
      'FROM s_obortypegroup s, s_obortype so'
      'WHERE (s.id > 0)'
      'and ( so.del = '#39'-'#39' ) '
      'and (so.id= s.detail )'
      'and obortype = :obortype'
      'ORDER BY s.Obortype')
    ModifySQL.Strings = (
      '')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_OBORTYPEGROUP'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 459
    Top = 229
    object dset_OborGroupID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_OBORTYPEGROUP.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_OborGroupOBORTYPE: TIntegerField
      FieldName = 'OBORTYPE'
      Origin = 'S_OBORTYPEGROUP.OBORTYPE'
      Required = True
    end
    object dset_OborGroupDETAIL: TIntegerField
      FieldName = 'DETAIL'
      Origin = 'S_OBORTYPEGROUP.DETAIL'
      Required = True
    end
    object dset_OborGroupDEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'S_OBORTYPEGROUP.DEL'
      FixedChar = True
      Size = 1
    end
    object dset_OborGroupNAME_TYPE: TIBStringField
      FieldName = 'NAME_TYPE'
      ProviderFlags = []
      FixedChar = True
      Size = 40
    end
  end
  object ds_OborGroup: TDataSource
    DataSet = dset_OborGroup
    Left = 515
    Top = 277
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 459
    Top = 277
  end
end
