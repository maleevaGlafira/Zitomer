object frm_EditWork: Tfrm_EditWork
  Left = 411
  Top = 173
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1088#1072#1073#1086#1090#1099
  ClientHeight = 272
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 409
    Height = 239
    Align = alTop
  end
  object Label1: TLabel
    Left = 85
    Top = 7
    Width = 32
    Height = 13
    Caption = #1052#1077#1089#1090#1086
  end
  object Label2: TLabel
    Left = 82
    Top = 32
    Width = 36
    Height = 13
    Caption = #1056#1072#1073#1086#1090#1072
  end
  object Label3: TLabel
    Left = 8
    Top = 57
    Width = 101
    Height = 13
    Caption = #1051#1080#1082#1074#1080#1076#1072#1094#1080#1103' '#1079#1072#1089#1086#1088#1072
  end
  object Label4: TLabel
    Left = 43
    Top = 81
    Width = 75
    Height = 13
    Caption = #1052#1077#1090#1086#1076' '#1086#1090#1082#1072#1095#1082#1080
  end
  object Label5: TLabel
    Left = 13
    Top = 102
    Width = 104
    Height = 13
    Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1057#1040#1050
  end
  object Label6: TLabel
    Left = 72
    Top = 129
    Width = 46
    Height = 13
    Caption = #1044#1080#1072#1084#1077#1090#1088
  end
  object Label7: TLabel
    Left = 58
    Top = 153
    Width = 59
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
  end
  object Label9: TLabel
    Left = 33
    Top = 183
    Width = 75
    Height = 13
    Caption = #1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099':'
  end
  object dbt_Trudozatrat: TDBText
    Left = 113
    Top = 182
    Width = 230
    Height = 17
    DataField = 'clcTRUDOZATRAT'
    DataSource = ds_main
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object dbl_place: TRxDBLookupCombo
    Left = 123
    Top = 4
    Width = 225
    Height = 21
    DropDownCount = 8
    DataField = 'ID_PLACE'
    DataSource = ds_main
    LookupField = 'ID'
    LookupDisplay = 'NAME_R'
    LookupSource = ds_place
    TabOrder = 0
    OnChange = dbl_placeChange
  end
  object dbl_work: TRxDBLookupCombo
    Left = 123
    Top = 28
    Width = 225
    Height = 21
    DropDownCount = 8
    DataField = 'ID_WORK'
    DataSource = ds_main
    LookupField = 'ID'
    LookupDisplay = 'clcFULL_NAME'
    LookupSource = ds_work
    TabOrder = 1
    OnChange = dbl_workChange
  end
  object dbl_killclog: TRxDBLookupCombo
    Left = 123
    Top = 52
    Width = 225
    Height = 21
    DropDownCount = 8
    DataField = 'ID_KILLCLOG'
    DataSource = ds_main
    LookupField = 'ID'
    LookupDisplay = 'NAME_R'
    LookupSource = ds_killclog
    TabOrder = 2
  end
  object dbl_pump: TRxDBLookupCombo
    Left = 123
    Top = 76
    Width = 225
    Height = 21
    DropDownCount = 8
    DataField = 'ID_PUMP'
    DataSource = ds_main
    LookupField = 'ID'
    LookupDisplay = 'NAME_R'
    LookupSource = ds_pump
    TabOrder = 3
  end
  object dbl_pes: TRxDBLookupCombo
    Left = 123
    Top = 100
    Width = 225
    Height = 21
    DropDownCount = 8
    DataField = 'ID_PES'
    DataSource = ds_main
    LookupField = 'ID'
    LookupDisplay = 'NAME_R'
    LookupSource = ds_pes
    TabOrder = 4
  end
  object dbl_diam: TRxDBLookupCombo
    Left = 123
    Top = 124
    Width = 225
    Height = 21
    DropDownCount = 8
    DataField = 'ID_DIAM'
    DataSource = ds_main
    LookupField = 'ID'
    LookupDisplay = 'DIAM'
    LookupSource = ds_diam
    TabOrder = 5
    OnChange = dbl_workChange
  end
  object ed_Kolwork: TDBEdit
    Left = 123
    Top = 148
    Width = 121
    Height = 21
    DataField = 'KOL_WORK'
    DataSource = ds_main
    TabOrder = 6
  end
  object btn_ok: TBitBtn
    Left = 196
    Top = 245
    Width = 81
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    TabOrder = 7
    OnClick = btn_okClick
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
  object btn_exit: TBitBtn
    Left = 288
    Top = 245
    Width = 81
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 8
    OnClick = btn_exitClick
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
  object btn_AddRaskop: TBitBtn
    Left = 264
    Top = 208
    Width = 75
    Height = 25
    Caption = #1056#1072#1089#1082#1086#1087#1082#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = btn_AddRaskopClick
  end
  object pnl_Raskop: TPanel
    Left = 5
    Top = 204
    Width = 373
    Height = 29
    BevelOuter = bvNone
    TabOrder = 10
    Visible = False
    object Label8: TLabel
      Left = 8
      Top = 6
      Width = 49
      Height = 13
      Caption = #1056#1072#1089#1082#1086#1087#1082#1072
    end
    object dbl_raskop: TRxDBLookupCombo
      Left = 61
      Top = 4
      Width = 308
      Height = 21
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'clc_RASKOP_INFO'
      LookupSource = ds_Raskop
      TabOrder = 0
    end
  end
  object ds_place: TDataSource
    Left = 347
    Top = 65532
  end
  object ds_work: TDataSource
    Left = 347
    Top = 28
  end
  object ds_killclog: TDataSource
    Left = 347
    Top = 60
  end
  object ds_pump: TDataSource
    Left = 347
    Top = 92
  end
  object ds_pes: TDataSource
    Left = 347
    Top = 124
  end
  object ds_diam: TDataSource
    Left = 347
    Top = 156
  end
  object ds_main: TDataSource
    Left = 35
    Top = 12
  end
  object ds_Raskop: TDataSource
    Left = 168
    Top = 192
  end
end
