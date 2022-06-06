object FormClZadv: TFormClZadv
  Left = 286
  Top = 68
  Width = 608
  Height = 648
  Caption = #1055#1077#1088#1077#1082#1088#1099#1090#1099#1077' '#1079#1072#1076#1074#1080#1078#1082#1080
  Color = clBtnFace
  Constraints.MinHeight = 560
  Constraints.MinWidth = 547
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Lb_save: TLabel
    Left = 653
    Top = 295
    Width = 4
    Height = 18
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label4: TLabel
    Left = 15
    Top = 128
    Width = 46
    Height = 13
    Caption = #1044#1080#1072#1084#1077#1090#1088
  end
  object Label5: TLabel
    Left = 23
    Top = 136
    Width = 46
    Height = 13
    Caption = #1044#1080#1072#1084#1077#1090#1088
  end
  object Label6: TLabel
    Left = 367
    Top = 152
    Width = 46
    Height = 13
    Caption = #1044#1080#1072#1084#1077#1090#1088
  end
  object TbC_zadv: TTabControl
    Left = 0
    Top = 0
    Width = 592
    Height = 449
    Align = alTop
    TabOrder = 0
    OnChange = TbC_zadvChange
    object Lb_zakr: TLabel
      Left = 127
      Top = 153
      Width = 4
      Height = 18
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Lb_zavin: TLabel
      Left = 384
      Top = 111
      Width = 3
      Height = 13
    end
    object Lb_zavout: TLabel
      Left = 384
      Top = 130
      Width = 3
      Height = 13
    end
    object Panel1: TPanel
      Left = 4
      Top = 6
      Width = 584
      Height = 439
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object DopZadvPanel: TPanel
        Left = 2
        Top = 314
        Width = 580
        Height = 123
        Align = alBottom
        TabOrder = 1
        object Label7: TLabel
          Left = 15
          Top = 91
          Width = 45
          Height = 13
          Caption = #1055#1083#1072#1085#1096#1077#1090
        end
        object Label8: TLabel
          Left = 183
          Top = 91
          Width = 56
          Height = 13
          Caption = #8470' '#1082#1086#1083#1086#1076#1094#1072
        end
        object Label9: TLabel
          Left = 375
          Top = 91
          Width = 51
          Height = 13
          Caption = #1047#1072#1076#1074#1080#1078#1082#1072
        end
        object Bevel2: TBevel
          Left = 3
          Top = 61
          Width = 527
          Height = 24
        end
        object Label11: TLabel
          Left = 23
          Top = 66
          Width = 38
          Height = 13
          Caption = #1056#1077#1084#1086#1085#1090
        end
        object Label15: TLabel
          Left = 216
          Top = 66
          Width = 109
          Height = 13
          Caption = #1042#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1088#1077#1084#1086#1085#1090#1072
        end
        object Label1: TLabel
          Left = 191
          Top = 9
          Width = 46
          Height = 13
          Caption = #1044#1080#1072#1084#1077#1090#1088
        end
        object Label19: TLabel
          Left = 191
          Top = 28
          Width = 106
          Height = 26
          Caption = #1053#1086#1088#1084#1072#1083#1100#1085#1086#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077' '#1079#1072#1076#1074#1080#1078#1082#1080
          WordWrap = True
        end
        object DBL_Pad: TRxDBLookupCombo
          Left = 69
          Top = 87
          Width = 102
          Height = 23
          DropDownCount = 8
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          LookupField = 'ID'
          LookupDisplay = 'NAME_R'
          LookupSource = ds_pad
          ParentFont = False
          TabOrder = 0
          OnChange = DBL_PadChange
        end
        object DBL_Well: TRxDBLookupCombo
          Left = 250
          Top = 86
          Width = 111
          Height = 23
          DropDownCount = 8
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          LookupField = 'ID'
          LookupDisplay = 'NAME_R'
          LookupSource = ds_well
          ParentFont = False
          TabOrder = 1
          OnChange = DBL_WellChange
        end
        object DBL_Bolt: TRxDBLookupCombo
          Left = 428
          Top = 85
          Width = 97
          Height = 23
          DropDownCount = 8
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          LookupField = 'ID'
          LookupDisplay = 'NAME_R'
          LookupSource = ds_bolt
          ParentFont = False
          TabOrder = 2
          OnChange = DBL_ul1Change
        end
        object TE_Remont: TDateTimePicker
          Left = 457
          Top = 63
          Width = 72
          Height = 21
          Date = 36306.452353356500000000
          Time = 36306.452353356500000000
          DateMode = dmUpDown
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Kind = dtkTime
          ParentFont = False
          TabOrder = 3
          OnChange = DBL_ul1Change
        end
        object DBL_Remont: TRxDBLookupCombo
          Left = 72
          Top = 62
          Width = 129
          Height = 23
          DropDownCount = 8
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          LookupField = 'NAME_R'
          LookupDisplay = 'NAME_R'
          LookupSource = DS_Remont
          ParentFont = False
          TabOrder = 4
          OnChange = DBL_ul1Change
        end
        object DE_Remont: TDateEdit
          Left = 370
          Top = 63
          Width = 91
          Height = 20
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ButtonWidth = 17
          NumGlyphs = 2
          ParentFont = False
          YearDigits = dyFour
          TabOrder = 5
          OnChange = DBL_ul1Change
        end
        object DBL_diam: TRxDBLookupCombo
          Left = 250
          Top = 4
          Width = 91
          Height = 23
          DropDownCount = 8
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          LookupField = 'ID'
          LookupDisplay = 'DIAM_STR'
          LookupSource = DS_diam
          ParentFont = False
          TabOrder = 6
          OnChange = DBL_ul1Change
        end
        object chb_IsPervichViezd: TCheckBox
          Left = 22
          Top = 8
          Width = 129
          Height = 17
          Caption = #1055#1077#1088#1074#1080#1095#1085#1099#1081' '#1101#1090#1072#1087
          TabOrder = 7
          OnClick = chb_IsPervichViezdClick
        end
        object cb_is_sbros: TCheckBox
          Left = 22
          Top = 32
          Width = 129
          Height = 17
          Caption = #1057#1073#1088#1086#1089#1085#1072#1103' '#1079#1072#1076#1074#1080#1078#1082#1072
          TabOrder = 8
        end
        object DBL_norm: TRxDBLookupCombo
          Left = 303
          Top = 33
          Width = 91
          Height = 23
          DropDownCount = 8
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          LookupField = 'ID'
          LookupDisplay = 'NAME_R'
          LookupSource = ds_norm
          ParentFont = False
          TabOrder = 9
          OnChange = DBL_ul1Change
        end
      end
      object MainZadvPanel: TPanel
        Left = 2
        Top = 182
        Width = 580
        Height = 132
        Align = alClient
        TabOrder = 3
        object Label14: TLabel
          Left = 25
          Top = 63
          Width = 57
          Height = 13
          Alignment = taRightJustify
          Caption = #1055#1077#1088#1077#1082#1088#1099#1090#1072
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 29
          Top = 11
          Width = 44
          Height = 13
          Alignment = taRightJustify
          Caption = #1054#1090#1082#1088#1099#1090#1072
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object DE_in: TDateEdit
          Left = 76
          Top = 7
          Width = 91
          Height = 20
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ButtonWidth = 17
          NumGlyphs = 2
          ParentFont = False
          YearDigits = dyFour
          TabOrder = 0
          OnChange = DBL_ul1Change
        end
        object DE_out: TDateEdit
          Left = 84
          Top = 59
          Width = 91
          Height = 20
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ButtonWidth = 17
          NumGlyphs = 2
          ParentFont = False
          YearDigits = dyFour
          TabOrder = 1
          OnButtonClick = DE_outButtonClick
          OnChange = DBL_ul1Change
        end
        object TE_in: TDateTimePicker
          Left = 167
          Top = 7
          Width = 72
          Height = 21
          Date = 36306.452353356500000000
          Time = 36306.452353356500000000
          DateMode = dmUpDown
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Kind = dtkTime
          ParentFont = False
          TabOrder = 2
          OnChange = DBL_ul1Change
        end
        object TE_Out: TDateTimePicker
          Left = 183
          Top = 59
          Width = 72
          Height = 21
          Date = 36306.452494444400000000
          Time = 36306.452494444400000000
          DateMode = dmUpDown
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Kind = dtkTime
          ParentFont = False
          TabOrder = 3
          OnChange = DBL_ul1Change
        end
        object DBL_brIn: TRxDBLookupCombo
          Left = 27
          Top = 30
          Width = 390
          Height = 23
          DropDownCount = 8
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          LookupField = 'NAME_R'
          LookupDisplay = 'NAME_R'
          LookupSource = DS_brIn
          ParentFont = False
          TabOrder = 4
          OnChange = DBL_ul1Change
        end
        object DBL_brOut: TRxDBLookupCombo
          Left = 27
          Top = 82
          Width = 390
          Height = 23
          DropDownCount = 8
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          LookupField = 'NAME_R'
          LookupDisplay = 'NAME_R'
          LookupSource = DS_brOut
          ParentFont = False
          TabOrder = 5
          OnChange = DBL_ul1Change
        end
        object BB_Open: TBitBtn
          Left = 429
          Top = 5
          Width = 116
          Height = 44
          BiDiMode = bdLeftToRight
          Caption = #1054#1090#1082#1088#1099#1090#1100' '#1079#1072#1076#1074#1080#1078#1082#1091
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 6
          WordWrap = True
          OnClick = BB_OpenClick
          NumGlyphs = 2
        end
      end
      object GrB_adres: TGroupBox
        Left = 2
        Top = 2
        Width = 580
        Height = 77
        Align = alTop
        Caption = ' '#1040#1076#1088#1077#1089' '#1087#1077#1088#1077#1082#1088#1099#1090#1086#1081' '#1079#1072#1076#1074#1080#1078#1082#1080' '
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label12: TLabel
          Left = 20
          Top = 18
          Width = 20
          Height = 15
          Caption = #1058#1080#1087
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_NmUl: TLabel
          Left = 5
          Top = 47
          Width = 41
          Height = 15
          Caption = #1059#1083#1080#1094#1072'  '
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Ndom: TLabel
          Left = 189
          Top = 44
          Width = 70
          Height = 15
          Caption = #1085#1086#1084#1077#1088' '#1076#1086#1084#1072
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_cross: TLabel
          Left = 197
          Top = 48
          Width = 81
          Height = 15
          Caption = #1087#1077#1088#1077#1082#1088#1077#1089#1090#1086#1082' '#1089
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_place: TLabel
          Left = 5
          Top = 47
          Width = 35
          Height = 15
          Caption = #1059#1083#1080#1094#1072
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object DBL_ul1: TRxDBLookupCombo
          Left = 46
          Top = 44
          Width = 195
          Height = 25
          DropDownCount = 8
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          LookupField = 'name_r'
          LookupDisplay = 'name_r'
          LookupSource = DS_ul1
          ParentFont = False
          TabOrder = 0
          OnChange = DBL_ul1Change
        end
        object Ed_ndom: TEdit
          Left = 260
          Top = 44
          Width = 50
          Height = 23
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          MaxLength = 8
          ParentFont = False
          TabOrder = 1
          OnChange = DBL_ul1Change
        end
        object DBL_ul2: TRxDBLookupCombo
          Left = 274
          Top = 44
          Width = 195
          Height = 25
          DropDownCount = 8
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          LookupField = 'name_r'
          LookupDisplay = 'name_r'
          LookupSource = DS_ul2
          ParentFont = False
          TabOrder = 2
          Visible = False
          OnChange = DBL_ul1Change
        end
        object Ed_dopAdr: TEdit
          Left = 260
          Top = 16
          Width = 209
          Height = 23
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          OnChange = DBL_ul1Change
        end
        object CB_tadr: TRxDBLookupCombo
          Left = 46
          Top = 16
          Width = 135
          Height = 25
          DropDownCount = 8
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          LookupField = 'NAME_R'
          LookupDisplay = 'NAME_R'
          LookupSource = DS_tadr
          ParentFont = False
          TabOrder = 4
          OnChange = CB_tAdrChange
        end
        object DBL_DopAdres: TRxDBLookupCombo
          Left = 265
          Top = 44
          Width = 183
          Height = 25
          DropDownCount = 8
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          LookupField = 'name_r'
          LookupDisplay = 'name_r'
          LookupSource = ds_DopAdres
          ParentFont = False
          TabOrder = 5
          Visible = False
          OnChange = DBL_ul1Change
        end
      end
      object GrB_Object: TGroupBox
        Left = 2
        Top = 79
        Width = 580
        Height = 103
        Align = alTop
        Caption = #1054#1073#1098#1077#1082#1090' '#1087#1077#1088#1077#1082#1088#1099#1090#1086#1081' '#1079#1072#1076#1074#1080#1078#1082#1080' '
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object Label20: TLabel
          Left = 20
          Top = 18
          Width = 42
          Height = 15
          Caption = #1054#1073#1098#1077#1082#1090
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label21: TLabel
          Left = 5
          Top = 47
          Width = 41
          Height = 15
          Caption = #1059#1083#1080#1094#1072'  '
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label24: TLabel
          Left = 5
          Top = 47
          Width = 72
          Height = 15
          Caption = #1057#1086#1086#1088#1091#1078#1077#1085#1080#1077
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label22: TLabel
          Left = 5
          Top = 79
          Width = 83
          Height = 15
          Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object DBL_Soorug: TRxDBLookupCombo
          Left = 89
          Top = 44
          Width = 428
          Height = 25
          DropDownCount = 8
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          LookupField = 'name_r'
          LookupDisplay = 'name_r'
          LookupSource = ds_Soorug
          ParentFont = False
          TabOrder = 0
          OnChange = DBL_SoorugChange
        end
        object DBL_Object: TRxDBLookupCombo
          Left = 89
          Top = 16
          Width = 428
          Height = 25
          DropDownCount = 8
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          LookupField = 'NAME_R'
          LookupDisplay = 'NAME_R'
          LookupSource = ds_Object
          ParentFont = False
          TabOrder = 1
          OnChange = DBL_ObjectChange
        end
        object DBL_ObjObor: TRxDBLookupCombo
          Left = 89
          Top = 73
          Width = 428
          Height = 25
          DropDownCount = 8
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          LookupField = 'name_r'
          LookupDisplay = 'name_r'
          LookupSource = ds_ObjObor
          ParentFont = False
          TabOrder = 2
          OnChange = DBL_ul1Change
        end
      end
    end
  end
  object GridPanel: TPanel
    Left = 0
    Top = 449
    Width = 592
    Height = 126
    Align = alClient
    TabOrder = 1
    object DBGr_zadv: TRxDBGrid
      Left = 1
      Top = 1
      Width = 590
      Height = 124
      Align = alClient
      DataSource = DS_zadv
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = RUSSIAN_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      Columns = <
        item
          Expanded = False
          FieldName = 'adres'
          Title.Alignment = taCenter
          Title.Caption = #1040#1076#1088#1077#1089' '#1087#1077#1088#1077#1082#1088#1099#1090#1086#1081' '#1079#1072#1076#1074#1080#1078#1082#1080
          Width = 273
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OBJECT'
          Title.Caption = #1054#1073#1100#1077#1082#1090', '#1089#1086#1086#1088#1091#1078#1077#1085#1080#1077', '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DT_IN'
          Title.Alignment = taCenter
          Title.Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1080#1079#1084#1077#1085#1077#1085#1086
          Width = 159
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'brin_look'
          Title.Alignment = taCenter
          Title.Caption = #1041#1088#1080#1075#1072#1076#1080#1088
          Width = 197
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'disp_in_look'
          Title.Alignment = taCenter
          Title.Caption = #1044#1080#1089#1087#1077#1090#1095#1077#1088
          Width = 102
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DT_OUT'
          Title.Alignment = taCenter
          Title.Caption = #1048#1089#1093#1086#1076#1085#1086#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077
          Width = 152
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'brout_look'
          Title.Alignment = taCenter
          Title.Caption = #1041#1088#1080#1075#1072#1076#1080#1088
          Width = 161
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'disp_out_look'
          Title.Alignment = taCenter
          Title.Caption = #1044#1080#1089#1087#1077#1090#1095#1077#1088
          Width = 88
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DOP_ADR'
          Title.Alignment = taCenter
          Title.Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1081' '#1072#1076#1088#1077#1089
          Width = 195
          Visible = True
        end>
    end
  end
  object OldRaskopPanel: TPanel
    Left = 640
    Top = 112
    Width = 553
    Height = 177
    Enabled = False
    TabOrder = 2
    Visible = False
    object lbl_Gran: TLabel
      Left = 0
      Top = 55
      Width = 58
      Height = 26
      Alignment = taCenter
      Caption = #1047#1072#1089#1099#1087#1082#1072#13#10#1075#1088#1072#1085#1086#1090#1089#1077#1074#1072
      Visible = False
    end
    object Label10: TLabel
      Left = 7
      Top = 10
      Width = 55
      Height = 39
      Alignment = taCenter
      Caption = #1042#1086#1089#1089#1090#1072#1085#13#10#1076#1086#1088#1086#1078#1085#1086#1075#1086#13#10#1087#1086#1082#1088#1099#1090#1080#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label2: TLabel
      Left = 431
      Top = 7
      Width = 55
      Height = 13
      Alignment = taRightJustify
      Caption = #1056#1072#1089#1082#1086#1087#1072#1085#1086
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label3: TLabel
      Left = 501
      Top = 4
      Width = 49
      Height = 26
      Alignment = taRightJustify
      Caption = #1054#1073#1088#1072#1090#1085#1072#1103#13#10#1079#1072#1089#1099#1087#1082#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object DE_Gran: TDateEdit
      Left = 66
      Top = 61
      Width = 91
      Height = 20
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ButtonWidth = 17
      NumGlyphs = 2
      ParentFont = False
      YearDigits = dyFour
      TabOrder = 0
      Visible = False
      OnButtonClick = DE_outButtonClick
      OnChange = DBL_ul1Change
    end
    object DE_Rec: TDateEdit
      Left = 67
      Top = 13
      Width = 91
      Height = 20
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ButtonWidth = 17
      NumGlyphs = 2
      ParentFont = False
      YearDigits = dyFour
      TabOrder = 1
      Visible = False
      OnButtonClick = DE_outButtonClick
      OnChange = DBL_ul1Change
    end
    object TE_Gran: TDateTimePicker
      Left = 158
      Top = 60
      Width = 72
      Height = 21
      Date = 36306.452494444400000000
      Time = 36306.452494444400000000
      DateMode = dmUpDown
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Kind = dtkTime
      ParentFont = False
      TabOrder = 2
      Visible = False
      OnChange = DBL_ul1Change
    end
    object TE_Rec: TDateTimePicker
      Left = 166
      Top = 12
      Width = 72
      Height = 21
      Date = 36306.452494444400000000
      Time = 36306.452494444400000000
      DateMode = dmUpDown
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Kind = dtkTime
      ParentFont = False
      TabOrder = 3
      Visible = False
      OnChange = DBL_ul1Change
    end
    object DBL_brGran: TRxDBLookupCombo
      Left = 232
      Top = 58
      Width = 183
      Height = 23
      DropDownCount = 8
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      LookupField = 'NAME_R'
      LookupDisplay = 'NAME_R'
      LookupSource = ds_brGran
      ParentFont = False
      TabOrder = 4
      Visible = False
      OnChange = DBL_ul1Change
    end
    object DBL_BRREC: TRxDBLookupCombo
      Left = 240
      Top = 10
      Width = 183
      Height = 23
      DropDownCount = 8
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      LookupField = 'NAME_R'
      LookupDisplay = 'NAME_R'
      LookupSource = ds_BrRec
      ParentFont = False
      TabOrder = 5
      Visible = False
      OnChange = DBL_ul1Change
    end
    object DopRaskopPanel: TPanel
      Left = 0
      Top = 90
      Width = 545
      Height = 87
      TabOrder = 6
      object Label16: TLabel
        Left = 6
        Top = 7
        Width = 53
        Height = 26
        Caption = #1056#1072#1079#1088#1099#1090#1080#1077' '#13#10#1087#1077#1088#1077#1076#1072#1085#1086
      end
      object Label17: TLabel
        Left = 184
        Top = 12
        Width = 31
        Height = 13
        Caption = #1072#1082#1090' '#1086#1090
      end
      object Label18: TLabel
        Left = 8
        Top = 44
        Width = 95
        Height = 26
        Alignment = taCenter
        Caption = #1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#13#10#1074#1099#1087#1086#1083#1085#1080#1090#1100' '#1088#1072#1073#1086#1090#1099
      end
      object TE_Act: TDateTimePicker
        Left = 316
        Top = 8
        Width = 72
        Height = 21
        Date = 38868.543546724540000000
        Time = 38868.543546724540000000
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Kind = dtkTime
        ParentFont = False
        TabOrder = 0
        OnChange = DBL_ul1Change
      end
      object DE_Act: TDateEdit
        Left = 217
        Top = 8
        Width = 99
        Height = 21
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 1
        OnChange = DBL_ul1Change
      end
      object ed_Peredano: TEdit
        Left = 74
        Top = 9
        Width = 121
        Height = 21
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        MaxLength = 20
        ParentFont = False
        TabOrder = 2
        OnChange = DBL_ul1Change
      end
      object DBL_BrAct: TRxDBLookupCombo
        Left = 392
        Top = 8
        Width = 137
        Height = 21
        DropDownCount = 8
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        LookupField = 'NAME_R'
        LookupDisplay = 'NAME_R'
        LookupSource = ds_BrAct
        ParentFont = False
        TabOrder = 3
        OnChange = DBL_ul1Change
      end
      object mem_NeedWorks: TMemo
        Left = 120
        Top = 41
        Width = 415
        Height = 40
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        MaxLength = 150
        ParentFont = False
        TabOrder = 4
        OnChange = DBL_ul1Change
        OnKeyPress = mem_NeedWorksKeyPress
      end
    end
  end
  object BtnPanel: TPanel
    Left = 0
    Top = 575
    Width = 592
    Height = 35
    Align = alBottom
    TabOrder = 3
    object BB_Add: TBitBtn
      Left = 4
      Top = 5
      Width = 86
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 0
      OnClick = BB_AddClick
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
    object BB_del: TBitBtn
      Left = 90
      Top = 5
      Width = 85
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 1
      OnClick = BB_delClick
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
      Left = 175
      Top = 5
      Width = 85
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Enabled = False
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
    object BB_Copy: TBitBtn
      Left = 260
      Top = 5
      Width = 85
      Height = 25
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1074' '#1085#1086#1074#1091#1102
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = BB_CopyClick
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
    object ChB_Exist: TCheckBox
      Left = 356
      Top = 8
      Width = 189
      Height = 22
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1077#1079#1072#1082#1088#1099#1090#1091#1102' '#1079#1072#1076#1074#1080#1078#1082#1091' '#1080#1079' '#1079#1072#1082#1088#1099#1090#1086#1081' '#1079#1072#1103#1074#1082#1080
      TabOrder = 4
      Visible = False
      WordWrap = True
      OnClick = ChB_ExistClick
    end
    object BB_Exit: TBitBtn
      Left = 462
      Top = 5
      Width = 76
      Height = 25
      Caption = '&'#1042#1099#1093#1086#1076
      TabOrder = 5
      OnClick = BB_ExitClick
      Kind = bkClose
    end
  end
  object Qry_adr: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 484
    Top = 284
  end
  object Qry_ul1: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'select u.id id, rtrim(u.name_r)||" "||rtrim(v.name_r) as name_r,' +
        ' id_rayon'
      'from s_ulic u,s_vidul v'
      'where u.del in ('#39'-'#39','#39'd'#39') and u.id_vidul>-2 and u.id_vidul=v.id'
      'order by 2')
    Left = 276
    Top = 268
  end
  object Qry_ul2: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'select u.id id, rtrim(u.name_r)||" "||rtrim(v.name_r) as name_r,' +
        'id_rayon'
      'from s_ulic u,s_vidul v'
      'where u.del in ('#39'-'#39','#39'd'#39') and u.id_vidul>-2 and u.id_vidul=v.id'
      'order by 2')
    Left = 392
    Top = 272
  end
  object DS_ul1: TDataSource
    DataSet = Qry_ul1
    Left = 264
    Top = 256
  end
  object DS_ul2: TDataSource
    DataSet = Qry_ul2
    Left = 380
    Top = 260
  end
  object DS_zadv: TDataSource
    DataSet = Qry_Zadv
    Left = 160
    Top = 480
  end
  object Qry_tadr: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select * '
      'from tadr'
      '')
    Left = 332
    Top = 268
  end
  object __Qry_diam: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select d.id,cast(d.diam as char(4)) diam from s_diam d'
      ' where d.id<0 or d.diam>9 or d.diam<=1400 order by d.diam')
    Left = 548
    Top = 136
  end
  object DS_tadr: TDataSource
    DataSet = Qry_tadr
    Left = 320
    Top = 260
  end
  object __DS_diam: TDataSource
    DataSet = __Qry_diam
    Left = 536
    Top = 128
  end
  object Qry_tmp: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 20
    Top = 528
  end
  object Qry_BrIn: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,rtrim(name_r)||"  ["||rtrim(dolgn)||"]" name_r '
      'from s_brig'
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r')
    Left = 220
    Top = 268
  end
  object DS_brIn: TDataSource
    DataSet = Qry_BrIn
    Left = 208
    Top = 260
  end
  object Qry_brOut: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,rtrim(name_r)||"  ["||rtrim(dolgn)||"]" name_r  '
      'from s_brig'
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r')
    Left = 172
    Top = 292
  end
  object DS_brOut: TDataSource
    DataSet = Qry_brOut
    Left = 164
    Top = 280
  end
  object Qry_tmp2: TQuery
    DatabaseName = 'DBN_AVAR'
    RequestLive = True
    Left = 28
    Top = 504
  end
  object Qry_diam: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT d.id, d.diam, cast(diam as char(5)) as diam_str, d.del'
      'FROM s_diam d'
      'WHERE d.del in ('#39'-'#39','#39'd'#39')'
      'ORDER BY d.diam')
    Left = 97
    Top = 122
  end
  object DS_diam: TDataSource
    DataSet = Qry_diam
    Left = 122
    Top = 122
  end
  object qry_pad: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT id, name_r, del'
      'FROM s_pad '
      'WHERE del in ('#39'-'#39','#39'd'#39')'
      'ORDER BY name_r')
    Left = 108
    Top = 198
  end
  object qry_well: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT w.id, w.name_r, w.del'
      'FROM s_well w'
      'WHERE (w.del in ('#39'-'#39','#39'd'#39')) and (w.id_pad=:pad)'
      '        and (w.id_attach=:att)'
      'ORDER BY w.name_r')
    Left = 244
    Top = 230
    ParamData = <
      item
        DataType = ftInteger
        Name = 'pad'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'att'
        ParamType = ptInput
      end>
  end
  object qry_bolt: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT b.id, b.name_r, b.del'
      'FROM s_bolt b'
      'WHERE (b.del in ('#39'-'#39','#39'd'#39')) and (id_well=:well)'
      'ORDER BY b.name_r')
    Left = 480
    Top = 185
    ParamData = <
      item
        DataType = ftInteger
        Name = 'well'
        ParamType = ptInput
      end>
  end
  object ds_pad: TDataSource
    DataSet = qry_pad
    Left = 136
    Top = 201
  end
  object ds_well: TDataSource
    DataSet = qry_well
    Left = 280
    Top = 233
  end
  object ds_bolt: TDataSource
    DataSet = qry_bolt
    Left = 488
    Top = 193
  end
  object Qry_BrRec: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r||" "||dolgn name_r '
      'from s_brig'
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r')
    Left = 188
    Top = 252
  end
  object ds_BrRec: TDataSource
    DataSet = Qry_BrRec
    Left = 172
    Top = 240
  end
  object DS_DispOut: TDataSource
    DataSet = Qry_DispOut
    Left = 172
    Top = 328
  end
  object Qry_DispOut: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,rtrim(name_r)||"  ["||rtrim(dolgn)||"]" name_r  '
      'from s_brig'
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r')
    Left = 180
    Top = 340
  end
  object DS_DispIn: TDataSource
    DataSet = Qry_DispIn
    Left = 224
    Top = 332
  end
  object Qry_DispIn: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,rtrim(name_r)||"  ["||rtrim(dolgn)||"]" name_r '
      'from s_brig'
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r')
    Left = 236
    Top = 340
  end
  object DS_Remont: TDataSource
    DataSet = Qry_Remont
    Left = 180
    Top = 160
  end
  object Qry_Remont: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,rtrim(name_r)  name_r'
      'from s_remont'
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r')
    Left = 156
    Top = 164
  end
  object Qry_Zadv: TQuery
    AfterScroll = Qry_zadvAfterScroll
    OnCalcFields = Qry_zadvCalcFields
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select '
      
        '    ID, ID_ZAVIN, ID_NARIN, ID_ZAVOUT, ID_NAROUT, ID_UL1, ID_UL2' +
        ', UL_KOD, DOP_ADR, ID_DIAM, DT_IN, ID_BRIN'
      
        '    , DT_OUT, ID_BROUT, ID_WELL, ID_BOLT, ID_PAD, ID_DISP_IN, ID' +
        '_DISP_OUT, ID_REMONT, DT_REMONT'
      
        '    , IS_PERVICH_VIEZD, ID_DOPADRES, IS_SBROS, ID_NORMAL_STATE, ' +
        'ID_OBJECT, ID_SOORUG, ID_OBJOBOR'
      
        '    , (select so.name_r from s_object so where so.id = zadv.id_o' +
        'bject) objname '
      
        '    , (select ss.name_r from s_soorug ss where ss.id = zadv.id_s' +
        'oorug) soorname '
      
        '    , (select soo.name_r from s_objobor soo where soo.id = zadv.' +
        'id_objobor) oborname '
      ' from zadv')
    Left = 168
    Top = 496
    object IntegerField1: TIntegerField
      FieldName = 'ID'
      Origin = 'ZADV.ID'
      Visible = False
    end
    object IntegerField2: TIntegerField
      FieldName = 'ID_UL1'
      Origin = 'ZADV.ID_UL1'
      Visible = False
    end
    object StringField1: TStringField
      FieldName = 'ID_UL2'
      Origin = 'ZADV.ID_UL2'
      Visible = False
      Size = 10
    end
    object IntegerField3: TIntegerField
      FieldName = 'UL_KOD'
      Origin = 'ZADV.UL_KOD'
      Visible = False
    end
    object StringField2: TStringField
      FieldName = 'DOP_ADR'
      Origin = 'ZADV.DOP_ADR'
      Visible = False
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'DT_IN'
      Origin = 'ZADV.DT_IN'
      Visible = False
    end
    object IntegerField4: TIntegerField
      FieldName = 'ID_BRIN'
      Origin = 'ZADV.ID_BRIN'
      Visible = False
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'DT_OUT'
      Origin = 'ZADV.DT_OUT'
      Visible = False
    end
    object IntegerField5: TIntegerField
      FieldName = 'ID_BROUT'
      Origin = 'ZADV.ID_BROUT'
      Visible = False
    end
    object StringField3: TStringField
      FieldKind = fkCalculated
      FieldName = 'adres'
      Visible = False
      Size = 55
      Calculated = True
    end
    object StringField4: TStringField
      FieldKind = fkLookup
      FieldName = 'brin_look'
      LookupDataSet = Qry_BrIn
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_BRIN'
      Visible = False
      Size = 31
      Lookup = True
    end
    object StringField5: TStringField
      FieldKind = fkLookup
      FieldName = 'disp_in_look'
      LookupDataSet = Qry_DispIn
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_DISP_IN'
      Visible = False
      Size = 31
      Lookup = True
    end
    object StringField6: TStringField
      FieldKind = fkLookup
      FieldName = 'brout_look'
      LookupDataSet = Qry_brOut
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_BROUT'
      Visible = False
      Size = 31
      Lookup = True
    end
    object StringField7: TStringField
      FieldKind = fkLookup
      FieldName = 'disp_out_look'
      LookupDataSet = Qry_DispOut
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'ID_DISP_OUT'
      Visible = False
      Size = 31
      Lookup = True
    end
    object IntegerField6: TIntegerField
      FieldName = 'ID_ZAVIN'
      Origin = 'ZADV.ID'
      Visible = False
    end
    object IntegerField7: TIntegerField
      FieldName = 'ID_NARIN'
      Origin = 'ZADV.ID_ZAVIN'
      Visible = False
    end
    object IntegerField8: TIntegerField
      FieldName = 'ID_ZAVOUT'
      Origin = 'ZADV.ID_NARIN'
      Visible = False
    end
    object IntegerField9: TIntegerField
      FieldName = 'ID_NAROUT'
      Origin = 'ZADV.ID_ZAVOUT'
      Visible = False
    end
    object IntegerField10: TIntegerField
      FieldName = 'ID_BOLT'
      Visible = False
    end
    object IntegerField11: TIntegerField
      FieldName = 'ID_PAD'
      Visible = False
    end
    object IntegerField12: TIntegerField
      FieldName = 'ID_WELL'
      Visible = False
    end
    object IntegerField14: TIntegerField
      FieldName = 'ID_DIAM'
      Origin = 'DBN_AVAR.ZADV.ID_DIAM'
      Visible = False
    end
    object IntegerField15: TIntegerField
      FieldName = 'ID_DISP_IN'
      Origin = 'DBN_AVAR.ZADV.ID_DISP_IN'
      Visible = False
    end
    object IntegerField16: TIntegerField
      FieldName = 'ID_DISP_OUT'
      Origin = 'DBN_AVAR.ZADV.ID_DISP_OUT'
      Visible = False
    end
    object IntegerField17: TIntegerField
      FieldName = 'ID_REMONT'
      Origin = 'DBN_AVAR.ZADV.ID_REMONT'
      Visible = False
    end
    object DateTimeField4: TDateTimeField
      FieldName = 'DT_REMONT'
      Origin = 'DBN_AVAR.ZADV.DT_REMONT'
      Visible = False
    end
    object Qry_ZadvDT_REC: TDateTimeField
      FieldName = 'DT_REC'
      Origin = 'DBN_AVAR.RASKOP.DT_REC'
    end
    object Qry_ZadvID_BRREC: TIntegerField
      FieldName = 'ID_BRREC'
      Origin = 'DBN_AVAR.RASKOP.ID_BRREC'
      Visible = False
    end
    object Qry_ZadvIS_PERVICH_VIEZD: TIntegerField
      FieldName = 'IS_PERVICH_VIEZD'
    end
    object Qry_ZadvPEREDANO: TStringField
      FieldName = 'PEREDANO'
    end
    object Qry_ZadvDT_ACT: TDateTimeField
      FieldName = 'DT_ACT'
    end
    object Qry_ZadvID_BRACT: TIntegerField
      FieldName = 'ID_BRACT'
    end
    object Qry_ZadvNEEDWORKS: TStringField
      FieldName = 'NEEDWORKS'
      Size = 150
    end
    object Qry_ZadvID_DOPADRES: TIntegerField
      FieldName = 'ID_DOPADRES'
    end
    object Qry_ZadvDT_GRAN: TDateTimeField
      FieldName = 'DT_GRAN'
      Origin = 'DBN_AVAR.RASKOP.DT_GRAN'
    end
    object Qry_ZadvID_BRGRAN: TIntegerField
      FieldName = 'ID_BRGRAN'
      Origin = 'DBN_AVAR.RASKOP.ID_BRGRAN'
    end
    object Qry_ZadvIS_SBROS: TSmallintField
      FieldName = 'IS_SBROS'
    end
    object Qry_ZadvID_NORMAL_STATE: TSmallintField
      FieldName = 'ID_NORMAL_STATE'
    end
    object Qry_ZadvID_OBJECT: TIntegerField
      FieldName = 'ID_OBJECT'
      Origin = 'AVARKREMEN.ZADV.ID_OBJECT'
    end
    object Qry_ZadvID_SOORUG: TIntegerField
      FieldName = 'ID_SOORUG'
      Origin = 'AVARKREMEN.ZADV.ID_SOORUG'
    end
    object Qry_ZadvID_OBJOBOR: TIntegerField
      FieldName = 'ID_OBJOBOR'
      Origin = 'AVARKREMEN.ZADV.ID_OBJOBOR'
    end
    object Qry_ZadvOBJECT: TStringField
      FieldKind = fkCalculated
      FieldName = 'OBJECT'
      Size = 120
      Calculated = True
    end
    object Qry_Zadvobjname: TStringField
      FieldName = 'objname'
      Size = 40
    end
    object Qry_Zadvsoorname: TStringField
      FieldName = 'soorname'
      Size = 64
    end
    object Qry_Zadvoborname: TStringField
      FieldName = 'oborname'
      Size = 40
    end
  end
  object Qry_BrAct: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,rtrim(name_r)||"  ["||rtrim(dolgn)||"]" name_r  '
      'from s_brig'
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r'
      '')
    Left = 352
    Top = 348
  end
  object ds_BrAct: TDataSource
    DataSet = Qry_BrAct
    Left = 368
    Top = 356
  end
  object Qry_DopAdres: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r '
      'from s_DopAdres '
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r'
      ''
      '')
    Left = 456
    Top = 340
  end
  object ds_DopAdres: TDataSource
    DataSet = Qry_DopAdres
    Left = 472
    Top = 348
  end
  object qry_brGran: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r||" "||dolgn name_r '
      'from s_brig'
      'where del in ('#39'-'#39','#39'd'#39')'
      'order by name_r'
      '')
    Left = 364
    Top = 134
  end
  object ds_brGran: TDataSource
    DataSet = qry_brGran
    Left = 396
    Top = 134
  end
  object qry_norm: TQuery
    CachedUpdates = True
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT     ID,'
      '    NAME_R,'
      '    DEL'
      'FROM S_ZADV_NORMAL_STATE'
      'WHERE del in ('#39'-'#39','#39'd'#39')'
      'ORDER BY NAME_R')
    Left = 409
    Top = 186
  end
  object ds_norm: TDataSource
    DataSet = qry_norm
    Left = 426
    Top = 194
  end
  object ds_Object: TDataSource
    DataSet = Qry_Object
    Left = 338
    Top = 24
  end
  object ds_Soorug: TDataSource
    DataSet = Qry_Soorug
    Left = 378
    Top = 24
  end
  object ds_ObjObor: TDataSource
    DataSet = Qry_ObjObor
    Left = 418
    Top = 24
  end
  object Qry_Object: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id, name_r, id_attach, id_revs,del'
      'from s_object'
      'where ( 1=1 )'
      'order by name_r')
    Left = 352
    Top = 40
  end
  object Qry_Soorug: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT s.id, s.Name_r,  s.id_object,s.del'
      'FROM s_soorug s'
      'WHERE (1=1)'
      'ORDER BY s.Name_r')
    Left = 392
    Top = 40
  end
  object Qry_ObjObor: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'select id, name_r, id_object, id_obortype, id_soorug, id_diam, d' +
        'el'
      'from s_objobor'
      'where ( rtrim(upper(name_r)) starting with '#39#1047#1040#1044#1042#39')'
      'or ( rtrim(name_r) starting with '#39#1079#1072#1076#1074#39')'
      'or ( rtrim(name_r) starting with '#39#1047#1072#1076#1074#39')'
      'order by name_r')
    Left = 432
    Top = 40
  end
end
