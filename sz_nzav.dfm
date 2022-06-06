object FormSZ_nzav: TFormSZ_nzav
  Left = 204
  Top = 239
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1091#1095#1077#1090#1072'  '#1085#1072#1088#1103#1076#1086#1074
  ClientHeight = 321
  ClientWidth = 453
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 453
    Height = 321
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 2
    TabOrder = 0
    object Label3: TLabel
      Left = 22
      Top = 76
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = #1058#1080#1087' '#1085#1072#1088#1103#1076#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 31
      Top = 103
      Width = 36
      Height = 16
      Caption = #1056#1069#1042#1057
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 5
      Top = 241
      Width = 422
      Height = 11
      Shape = bsTopLine
    end
    object ZayavType_rg: TRadioGroup
      Left = 7
      Top = 34
      Width = 418
      Height = 34
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        #1047#1072#1082#1088#1099#1090#1099#1077' '#1079#1072#1103#1074#1082#1080
        #1053#1077#1079#1072#1082#1088#1099#1090#1099#1077' '#1079#1072#1103#1074#1082#1080)
      TabOrder = 0
      OnClick = ZayavType_rgClick
    end
    inline Frm_Dt: TFrm_Date
      Left = 5
      Top = 4
      Width = 420
      Height = 36
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      inherited Label1: TLabel
        Left = 7
      end
      inherited Label2: TLabel
        Left = 208
        Top = 6
      end
      inherited DE_In: TDateEdit
        Left = 21
        Top = 4
        Width = 93
        Height = 22
        ButtonWidth = 19
        ParentShowHint = False
        ShowHint = True
      end
      inherited Te_in: TDateTimePicker
        Left = 120
        Top = 4
        Width = 82
        ParentShowHint = False
        ShowHint = True
      end
      inherited DE_Out: TDateEdit
        Left = 229
        Top = 4
        Width = 93
        Height = 22
        ButtonWidth = 19
        ParentShowHint = False
        ShowHint = True
      end
      inherited Te_Out: TDateTimePicker
        Left = 330
        Top = 4
        Width = 75
        ParentShowHint = False
        ShowHint = True
      end
    end
    object DBL_tZav: TRxDBLookupCombo
      Left = 95
      Top = 72
      Width = 314
      Height = 24
      DropDownCount = 8
      LookupField = 'NAME_R'
      LookupDisplay = 'NAME_R'
      LookupSource = DS_damg
      TabOrder = 2
    end
    object RB_Rask: TRadioButton
      Left = 334
      Top = 101
      Width = 96
      Height = 15
      Caption = #1089' '#1088#1072#1089#1082#1086#1087#1082#1086#1081
      Checked = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      TabStop = True
      Visible = False
    end
    object RB_NoRask: TRadioButton
      Left = 334
      Top = 118
      Width = 91
      Height = 15
      Caption = #1073#1077#1079' '#1088#1072#1089#1082#1086#1087#1082#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Visible = False
    end
    object DBL_rayon: TRxDBLookupCombo
      Left = 151
      Top = 100
      Width = 178
      Height = 24
      DropDownCount = 8
      LookupField = 'NAME_R'
      LookupDisplay = 'NAME_R'
      LookupSource = DS_rayon
      TabOrder = 5
    end
    object BB_Ok: TBitBtn
      Left = 235
      Top = 287
      Width = 93
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100
      TabOrder = 6
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
    object BB_esc: TBitBtn
      Left = 333
      Top = 287
      Width = 92
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 7
      OnClick = BB_ESCClick
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
    object CheckBox1: TCheckBox
      Left = 8
      Top = 288
      Width = 217
      Height = 17
      Caption = #1087#1077#1095#1072#1090#1072#1090#1100' '#1074#1089#1077' '#1088#1072#1073#1086#1090#1099' '#1074' '#1079#1072#1103#1074#1082#1077
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      Visible = False
      OnClick = CheckBox1Click
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 136
      Width = 409
      Height = 73
      Caption = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077' '#1079#1072#1103#1074#1082#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      Visible = False
      object rbAllCrash: TRadioButton
        Left = 8
        Top = 16
        Width = 393
        Height = 17
        Caption = #1053#1077' '#1091#1095#1080#1090#1099#1074#1072#1090#1100' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103' '#1085#1072' '#1082#1086#1083#1083#1077#1082#1090#1086#1088#1072#1093' ('#1042#1089#1077' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103')'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object rbCrashColl: TRadioButton
        Left = 8
        Top = 32
        Width = 393
        Height = 17
        Caption = #1058#1086#1083#1100#1082#1086' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103' '#1085#1072' '#1082#1086#1083#1083#1077#1082#1090#1086#1088#1072#1093
        TabOrder = 1
      end
      object rbCrashNotColl: TRadioButton
        Left = 8
        Top = 48
        Width = 393
        Height = 17
        Caption = #1042#1089#1077', '#1082#1088#1086#1084#1077' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1081' '#1085#1072' '#1082#1086#1083#1083#1077#1082#1090#1086#1088#1072#1093
        TabOrder = 2
      end
    end
    object chb_otl: TCheckBox
      Left = 8
      Top = 216
      Width = 97
      Height = 17
      Caption = #1054#1090#1083#1086#1078#1077#1085#1085#1099#1077
      Checked = True
      State = cbChecked
      TabOrder = 10
    end
    inline frame_SelOwner1: Tframe_SelOwner
      Left = 8
      Top = 248
      Width = 209
      Height = 33
      TabOrder = 11
      Visible = False
      inherited btn_SelItem: TBitBtn
        OnClick = frame_SelOwner1btn_SelItemClick
      end
    end
  end
  object Qry_damg: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'select ss.id, rtrim(ss.name_r)||'#39'('#39'||rtrim(st.name_r)||'#39','#39'||rtri' +
        'm(sp.name_r)||'#39')'#39' as name_r'
      'from s_sod ss'
      'left join s_tzav st on (st.id=ss.ftype)'
      'left join s_place sp on (sp.id=ss.place_type)'
      'where ((del in ('#39'-'#39','#39'd'#39')) ) or id=-1'
      'order by name_r'
      '')
    Left = 188
    Top = 16
  end
  object DS_damg: TDataSource
    DataSet = Qry_damg
    Left = 72
    Top = 16
  end
  object Qry_tmp: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 304
    Top = 8
  end
  object Qry_rayon: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r from s_revs where del='#39'-'#39' order by name_r')
    Left = 244
    Top = 8
  end
  object DS_rayon: TDataSource
    DataSet = Qry_rayon
    Left = 120
    Top = 8
  end
end
