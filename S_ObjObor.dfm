inherited S_ObjOborF: TS_ObjOborF
  Left = 117
  Top = 210
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103' '#1086#1073#1098#1077#1082#1090#1086#1074
  ClientHeight = 545
  ClientWidth = 1045
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 545
    Top = 0
    Height = 545
  end
  inherited Panel1: TPanel
    Width = 545
    Height = 545
    Align = alLeft
    inherited DataGrid_dgr: TRxDBGrid
      Width = 539
      Height = 465
      OnTitleBtnClick = DataGrid_dgrTitleBtnClick
      Columns = <
        item
          Expanded = False
          FieldName = 'INVENTAR'
          Title.Caption = #1080#1085#1074'. '#8470
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 216
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'look_obortype'
          Title.Caption = #1058#1080#1087' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
          Width = 144
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'look_soorug'
          Title.Caption = #1057#1086#1086#1088#1091#1078#1077#1085#1080#1077
          Width = 151
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'look_diam'
          Title.Caption = #1044#1080#1072#1084#1077#1090#1088
          Visible = False
        end>
    end
    inherited Panel2: TPanel
      Top = 506
      Width = 539
      inherited BExit: TSpeedButton
        Left = 343
      end
      object BB_CopyNew: TBitBtn
        Left = 310
        Top = 7
        Width = 23
        Height = 26
        Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1079#1072#1087#1080#1089#1100' '#1074' '#1076#1086#1095#1077#1088#1085#1102#1102
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = BB_CopyNewClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
          333333333333337FF3333333333333903333333333333377FF33333333333399
          03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
          99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
          99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
          03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
          33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
          33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
          3333777777333333333333333333333333333333333333333333}
        NumGlyphs = 2
      end
    end
    inherited Panel3: TPanel
      Width = 539
      inherited Label4: TLabel
        Left = 318
        Visible = False
      end
      object Label1: TLabel [1]
        Left = 11
        Top = 12
        Width = 38
        Height = 13
        Caption = #1054#1073#1098#1077#1082#1090
      end
      inherited Find_ed: TEdit
        Left = 368
        Width = 25
        Visible = False
      end
      object dbl_Object: TRxDBLookupCombo
        Left = 56
        Top = 8
        Width = 233
        Height = 21
        DropDownCount = 8
        LookupField = 'ID'
        LookupDisplay = 'NAME_R'
        LookupSource = DM1.s_object_sur
        TabOrder = 1
        OnChange = dbl_ObjectChange
      end
    end
    object Panel7: TPanel
      Left = 320
      Top = 224
      Width = 185
      Height = 41
      Caption = 'Panel7'
      TabOrder = 3
      Visible = False
    end
  end
  object Panel4: TPanel [2]
    Left = 548
    Top = 0
    Width = 497
    Height = 545
    Align = alClient
    TabOrder = 1
    object Splitter2: TSplitter
      Left = 1
      Top = 277
      Width = 495
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object p_Group: TPanel
      Left = 1
      Top = 280
      Width = 495
      Height = 264
      Align = alBottom
      TabOrder = 0
      object Splitter3: TSplitter
        Left = 249
        Top = 1
        Height = 226
      end
      object GroupGrid: TRxDBGrid
        Left = 1
        Top = 1
        Width = 248
        Height = 226
        Align = alLeft
        Color = cl3DLight
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
            FieldName = 'NAME_R'
            Title.Caption = #1057#1086#1089#1090#1072#1074
            Width = 196
            Visible = True
          end>
      end
      object Panel5: TPanel
        Left = 1
        Top = 227
        Width = 493
        Height = 36
        Align = alBottom
        TabOrder = 1
      end
      object ValueListEditor: TValueListEditor
        Left = 252
        Top = 1
        Width = 242
        Height = 226
        TabStop = False
        Align = alClient
        Color = cl3DLight
        Ctl3D = True
        Enabled = False
        ParentCtl3D = False
        TabOrder = 2
        TitleCaptions.Strings = (
          #1055#1072#1088#1072#1084#1077#1090#1088
          #1047#1085#1072#1095#1077#1085#1080#1077)
        ColWidths = (
          125
          111)
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 241
      Width = 495
      Height = 36
      Align = alBottom
      TabOrder = 1
    end
    object dbg_Params: TRxDBGrid
      Left = 1
      Top = 1
      Width = 495
      Height = 240
      Align = alClient
      Color = cl3DLight
      Constraints.MinHeight = 70
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          ReadOnly = True
          Title.Caption = #1055#1072#1088#1072#1084#1077#1090#1088
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'P_VALUE'
          Title.Caption = #1047#1085#1072#1095#1077#1085#1080#1077
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MEASURE'
          ReadOnly = True
          Title.Caption = #1077#1076'.'#1080#1079#1084'.'
          Visible = False
        end>
    end
    object RxSplitter1: TRxSplitter
      Left = 496
      Top = 1
      Width = 0
      Height = 240
      ControlFirst = dbg_Params
      Align = alRight
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 563
    Top = 397
  end
  object ds_OborGroup: TDataSource
    DataSet = dset_OborGroup
    Left = 619
    Top = 405
  end
  object dset_OborGroup: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    AfterScroll = dset_OborGroupAfterScroll
    DeleteSQL.Strings = (
      'DELETE FROM S_obortypegroup'
      'WHERE id = :OLD_ID')
    SelectSQL.Strings = (
      'SELECT s.id, s.Obortype,  s.detail, s.del, so.name_r'
      'FROM s_obortypegroup s, s_obortype so'
      'WHERE (s.id > 0)'
      'and (so.id = s.detail)'
      'and ( so.del = '#39'-'#39' ) '
      'and obortype = :obortype'
      'ORDER BY s.Obortype')
    ModifySQL.Strings = (
      '')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_OBORTYPEGROUP'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 571
    Top = 349
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
    object dset_OborGroupNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_OBORTYPE.NAME_R'
      FixedChar = True
      Size = 40
    end
  end
  object dset_OborTypeParams: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    InsertSQL.Strings = (
      'INSERT INTO s_ot_params ( id_obortype, id_field , p_value)'
      'VALUES (:id_obortype, :sof_id, :p_value)')
    SelectSQL.Strings = (
      'select sp.id'
      '      ,(rtrim(sof.name_r)||'#39', '#39'||rtrim(sof.measure)) name_r'
      '      , sp.id_obortype'
      '      , sp.id_field'
      '      , sof.id sof_id'
      '      , sp.p_value'
      '      ,sof.measure'
      'from  s_otglob_fields sof'
      
        'join s_obortype so on (so.id_obortypeglob = sof.id_otg and so.id' +
        ' = :pid and  sof.del = '#39'-'#39')'
      
        'left join s_ot_params sp on (sp.id_field = sof.id and sp.id_obor' +
        'type = so.id)'
      'order by 2')
    ModifySQL.Strings = (
      'UPDATE s_ot_params'
      'SET  id_obortype = :id_obortype'
      '   , id_field =:sof_id'
      '   ,p_value =:p_value'
      'WHERE id = :id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_OT_PARAMS'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 826
    Top = 101
    object dset_OborTypeParamsID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_OT_PARAMS.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object dset_OborTypeParamsNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_OTGLOB_FIELDS.NAME_R'
      Size = 72
    end
    object dset_OborTypeParamsP_VALUE: TIBStringField
      FieldName = 'P_VALUE'
      Origin = 'S_OT_PARAMS.P_VALUE'
      Size = 255
    end
    object dset_OborTypeParamsMEASURE: TIBStringField
      FieldName = 'MEASURE'
      Origin = 'S_OTGLOB_FIELDS.MEASURE'
      Size = 10
    end
    object dset_OborTypeParamsID_OBORTYPE: TIntegerField
      FieldName = 'ID_OBORTYPE'
      Origin = 'S_OT_PARAMS.ID_OBORTYPE'
    end
    object dset_OborTypeParamsID_FIELD: TIntegerField
      FieldName = 'ID_FIELD'
      Origin = 'S_OT_PARAMS.ID_FIELD'
    end
    object dset_OborTypeParamsSOF_ID: TIntegerField
      FieldName = 'SOF_ID'
      Origin = 'S_OTGLOB_FIELDS.ID'
      Required = True
    end
  end
  object ds_OborTypeParams: TDataSource
    DataSet = dset_OborTypeParams
    Left = 826
    Top = 133
  end
  object dset_ParamLook: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select'
      '       (rtrim(sof.name_r)||'#39', '#39'||rtrim(sof.measure)) p_param'
      '      , sp.p_value'
      'from  s_otglob_fields sof'
      
        'join s_obortype so on (so.id_obortypeglob = sof.id_otg and so.id' +
        ' = :pid and  sof.del = '#39'-'#39')'
      
        'left join s_ot_params sp on (sp.id_field = sof.id and sp.id_obor' +
        'type = so.id)'
      'order by 2')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_OT_PARAMS'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 818
    Top = 341
    object dset_ParamLookP_PARAM: TIBStringField
      FieldName = 'P_PARAM'
      ProviderFlags = []
      Size = 162
    end
    object dset_ParamLookP_VALUE: TIBStringField
      FieldName = 'P_VALUE'
      Origin = 'S_OT_PARAMS.P_VALUE'
      Size = 255
    end
  end
  object ds_ParamLook: TDataSource
    DataSet = dset_ParamLook
    Left = 826
    Top = 381
  end
  object IBSQL: TIBSQL
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 376
    Top = 424
  end
end
