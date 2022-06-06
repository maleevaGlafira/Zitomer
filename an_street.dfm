object AnFormStreet: TAnFormStreet
  Left = 97
  Top = 197
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1040#1085#1072#1083#1080#1079' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1081' '#1087#1086' '#1091#1083#1080#1094#1077' ('#1079#1072#1082#1088#1099#1090#1099#1077' '#1079#1072#1103#1074#1082#1080')'
  ClientHeight = 149
  ClientWidth = 437
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 437
    Height = 149
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Label1: TLabel
      Left = 7
      Top = 37
      Width = 32
      Height = 13
      Caption = #1059#1083#1080#1094#1072
    end
    object Label2: TLabel
      Left = 145
      Top = 63
      Width = 70
      Height = 13
      Caption = #1055#1086#1074#1088#1077#1078#1076#1077#1085#1080#1077
    end
    object Bevel1: TBevel
      Left = 4
      Top = 110
      Width = 429
      Height = 13
      Shape = bsTopLine
    end
    object DBL_street: TRxDBLookupCombo
      Left = 49
      Top = 33
      Width = 352
      Height = 22
      DropDownCount = 8
      LookupField = 'NAME_R'
      LookupDisplay = 'NAME_R'
      LookupSource = DS_street
      TabOrder = 0
      OnChange = DBL_streetChange
    end
    object BB_Ok: TBitBtn
      Left = 228
      Top = 117
      Width = 85
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100
      TabOrder = 1
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
    object BB_Exit: TBitBtn
      Left = 320
      Top = 117
      Width = 80
      Height = 25
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 2
      OnClick = BB_ExitClick
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
    inline FrmDt_ul: TFrm_Date
      Left = 5
      Top = 4
      Width = 422
      Height = 30
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      inherited Label2: TLabel
        Left = 202
      end
      inherited DE_In: TDateEdit
        Left = 15
        Width = 93
        Height = 22
        ButtonWidth = 19
        OnChange = FrmDtChange
      end
      inherited Te_in: TDateTimePicker
        Left = 114
        Width = 82
        OnChange = FrmDtChange
      end
      inherited DE_Out: TDateEdit
        Left = 222
        Width = 94
        Height = 22
        ButtonWidth = 19
        OnChange = FrmDtChange
      end
      inherited Te_Out: TDateTimePicker
        Left = 321
        Width = 75
        OnChange = FrmDtChange
      end
    end
    object Work_rg: TRadioGroup
      Left = 282
      Top = 59
      Width = 95
      Height = 50
      ItemIndex = 0
      Items.Strings = (
        #1057' '#1088#1072#1089#1082#1086#1087#1082#1086#1081
        #1041#1077#1079' '#1088#1072#1089#1082#1086#1087#1082#1080)
      TabOrder = 4
      Visible = False
    end
    object Damg_lcb: TRxDBLookupCombo
      Left = 144
      Top = 82
      Width = 257
      Height = 22
      DropDownCount = 8
      DisplayEmpty = '<'#1087#1091#1089#1090#1086'>'
      LookupField = 'ID'
      LookupDisplay = 'NAME_R'
      LookupSource = DM1.S_Damg_sur
      TabOrder = 5
      OnChange = Damg_lcbChange
    end
    object Excavation_chb: TCheckBox
      Left = 8
      Top = 64
      Width = 97
      Height = 17
      Caption = #1057' '#1088#1072#1089#1082#1086#1087#1082#1086#1081
      Checked = True
      State = cbChecked
      TabOrder = 6
      Visible = False
      OnClick = ChbClick
    end
    object NotExcavation_chb: TCheckBox
      Left = 8
      Top = 84
      Width = 97
      Height = 17
      Caption = #1041#1077#1079' '#1088#1072#1089#1082#1086#1087#1082#1080
      Checked = True
      State = cbChecked
      TabOrder = 7
      Visible = False
      OnClick = ChbClick
    end
  end
  object Qry_street: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'select u.id id,u.name_r||" "||v.name_r||" "||cast(u.id as char(9' +
        ')) name_r,'
      'u.orint  from s_ulic u,s_vidul v where u.id>0 '
      'and u.id_vidul=v.id order by 2')
    Left = 132
    Top = 104
  end
  object DS_street: TDataSource
    DataSet = Qry_street
    Left = 188
    Top = 104
  end
  object Qry_tmp: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 76
    Top = 104
  end
end
