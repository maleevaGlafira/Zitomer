object ProizZForm: TProizZForm
  Left = 380
  Top = 234
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1088#1086#1080#1079#1074#1086#1083#1100#1085#1099#1081' '#1074#1099#1073#1086#1088
  ClientHeight = 311
  ClientWidth = 344
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
  object GrB_Zav: TGroupBox
    Left = 3
    Top = 0
    Width = 338
    Height = 129
    Caption = ' '#1047#1072#1103#1074#1082#1080' '
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 17
      Width = 18
      Height = 13
      Caption = #1043#1086#1076
    end
    object Label2: TLabel
      Left = 122
      Top = 18
      Width = 34
      Height = 13
      Caption = #1053#1086#1084#1077#1088
    end
    object CB_Year: TComboBox
      Left = 34
      Top = 13
      Width = 84
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      OnKeyPress = Ed_nomKeyPress
    end
    object Ed_nom: TEdit
      Left = 162
      Top = 14
      Width = 82
      Height = 21
      TabOrder = 0
      OnKeyPress = Ed_nomKeyPress
    end
    object BB_sear: TBitBtn
      Left = 247
      Top = 91
      Width = 82
      Height = 25
      Caption = #1048#1089#1082#1072#1090#1100
      TabOrder = 1
      OnClick = BB_searClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
    end
    object gb_Attach: TGroupBox
      Left = 10
      Top = 40
      Width = 321
      Height = 39
      Caption = #1055#1088#1080#1085#1072#1076#1083#1077#1078#1085#1086#1089#1090#1100
      TabOrder = 3
      object rbWaterAtt: TRadioButton
        Tag = 1
        Left = 6
        Top = 18
        Width = 91
        Height = 17
        Caption = #1074#1086#1076#1086#1087#1088#1086#1074#1086#1076
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object rbServityAtt: TRadioButton
        Tag = 2
        Left = 110
        Top = 18
        Width = 91
        Height = 17
        Caption = #1082#1072#1085#1072#1083#1080#1079#1072#1094#1080#1103
        TabOrder = 1
      end
      object rbVrkAtt: TRadioButton
        Tag = 3
        Left = 230
        Top = 18
        Width = 75
        Height = 17
        Caption = #1042#1056#1050
        TabOrder = 2
      end
    end
    object GroupBox1: TGroupBox
      Left = 9
      Top = 79
      Width = 234
      Height = 41
      TabOrder = 4
      object RB_All: TRadioButton
        Left = 8
        Top = 18
        Width = 50
        Height = 15
        Caption = #1042#1089#1077
        Checked = True
        TabOrder = 0
        TabStop = True
        OnKeyPress = Ed_nomKeyPress
      end
      object RB_zak: TRadioButton
        Left = 58
        Top = 18
        Width = 83
        Height = 15
        Caption = #1047#1072#1082#1088#1099#1090#1099#1077
        TabOrder = 1
        OnKeyPress = Ed_nomKeyPress
      end
      object RB_nZak: TRadioButton
        Left = 137
        Top = 18
        Width = 88
        Height = 15
        Caption = #1053#1077#1079#1072#1082#1088#1099#1090#1099#1077
        TabOrder = 2
        OnKeyPress = Ed_nomKeyPress
      end
    end
  end
  object DBLL_zav: TRxDBLookupList
    Left = 3
    Top = 133
    Width = 337
    Height = 147
    Ctl3D = True
    LookupField = 'VVOD'
    LookupDisplay = 'VVOD'
    LookupSource = DS_zav
    ParentCtl3D = False
    TabOrder = 1
    OnDblClick = BB_OkClick
  end
  object BB_Ok: TBitBtn
    Left = 143
    Top = 284
    Width = 98
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    Enabled = False
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
    Left = 244
    Top = 284
    Width = 93
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
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
  object Qry_zav: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select cast(nomer as char(6))||" "||cast(dt_in as char(20)) '
      'vvod,id from nzavjav where (delz=0) and fyear=1999'
      'order by fyear desc,nomer desc')
    Left = 152
    Top = 144
  end
  object DS_zav: TDataSource
    DataSet = Qry_zav
    Left = 212
    Top = 160
  end
  object Qry_tmp: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 284
    Top = 148
  end
end
