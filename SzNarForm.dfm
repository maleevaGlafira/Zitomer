inherited frm_sz_nar: Tfrm_sz_nar
  Left = 427
  Top = 277
  Width = 517
  Height = 222
  Caption = 'frm_sz_nar'
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inline Frm_Dt: TFrm_Date
    Left = 2
    Top = 4
    Width = 431
    Height = 36
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    inherited Label1: TLabel
      Left = 7
    end
    inherited Label2: TLabel
      Left = 216
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
      Left = 245
      Top = 4
      Width = 93
      Height = 22
      ButtonWidth = 19
      ParentShowHint = False
      ShowHint = True
    end
    inherited Te_Out: TDateTimePicker
      Left = 346
      Top = 4
      Width = 75
      ParentShowHint = False
      ShowHint = True
    end
  end
  object RG_Sort: TRadioGroup
    Left = 8
    Top = 40
    Width = 481
    Height = 65
    BiDiMode = bdLeftToRight
    Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
    Columns = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      #1087#1086' '#1074#1088#1077#1084#1077#1085#1080' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1085#1072#1088#1103#1076#1072
      #1087#1086' '#1074#1088#1077#1084#1077#1085#1080' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1101#1090#1072#1087#1072)
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 1
  end
  object BtnOk: TBitBtn
    Left = 312
    Top = 144
    Width = 83
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = BtnOkClick
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
  object btnCansel: TBitBtn
    Left = 400
    Top = 144
    Width = 89
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 3
    OnClick = btnCanselClick
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
  object sel_revs: TButton
    Left = 8
    Top = 144
    Width = 89
    Height = 25
    Caption = #1059#1095#1072#1089#1090#1086#1082
    TabOrder = 4
    OnClick = sel_revsClick
  end
  object sel_brig: TButton
    Left = 120
    Top = 144
    Width = 75
    Height = 25
    Caption = #1041#1088#1080#1075#1072#1076#1080#1088
    TabOrder = 5
    OnClick = sel_brigClick
  end
  object cb_otl: TCheckBox
    Left = 16
    Top = 112
    Width = 129
    Height = 17
    Caption = #1054#1090#1083#1086#1078#1077#1085#1085#1099#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object Q_count: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 160
    Top = 104
  end
end
