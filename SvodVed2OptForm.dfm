inherited frm_SvodVed2Opt: Tfrm_SvodVed2Opt
  Left = 433
  Top = 260
  BorderStyle = bsDialog
  Caption = 'frm_SvodVed2Opt'
  ClientHeight = 326
  ClientWidth = 249
  OldCreateOrder = True
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 4
    Top = 36
    Width = 241
    Height = 240
  end
  object Bevel1: TBevel
    Left = 4
    Top = 4
    Width = 241
    Height = 29
  end
  object Label1: TLabel
    Left = 13
    Top = 12
    Width = 53
    Height = 13
    Caption = #1047#1072' '#1089#1091#1090#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dp_Time: TDateTimePicker
    Left = 160
    Top = 8
    Width = 73
    Height = 21
    Date = 39021.333333333340000000
    Format = 'hh:mm'
    Time = 39021.333333333340000000
    Kind = dtkTime
    TabOrder = 0
  end
  object dp_Date: TDateEdit
    Left = 67
    Top = 8
    Width = 89
    Height = 21
    NumGlyphs = 2
    TabOrder = 1
  end
  object btn_revs: TBitBtn
    Left = 16
    Top = 44
    Width = 217
    Height = 25
    Caption = #1059#1095#1072#1089#1090#1086#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btn_revsClick
  end
  object btn_ok: TBitBtn
    Left = 6
    Top = 282
    Width = 99
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
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
  object btn_cancel: TBitBtn
    Left = 152
    Top = 282
    Width = 93
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btn_cancelClick
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
  object gb_Attach: TGroupBox
    Left = 16
    Top = 75
    Width = 217
    Height = 70
    Caption = #1055#1088#1080#1085#1072#1076#1083#1077#1078#1085#1086#1089#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object chb_Voda: TCheckBox
      Left = 8
      Top = 16
      Width = 153
      Height = 17
      Caption = #1042#1086#1076#1086#1087#1088#1086#1074#1086#1076
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chb_Kanal: TCheckBox
      Left = 8
      Top = 32
      Width = 177
      Height = 17
      Caption = #1050#1072#1085#1072#1083#1080#1079#1072#1094#1080#1103
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object chb_Vrk: TCheckBox
      Left = 8
      Top = 48
      Width = 97
      Height = 17
      Caption = #1047#1072#1103#1074#1082#1080' '#1042#1056#1050
      TabOrder = 2
      Visible = False
    end
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 152
    Width = 217
    Height = 89
    Caption = #1058#1080#1087' '#1079#1072#1103#1074#1086#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object chb_Close: TCheckBox
      Left = 8
      Top = 16
      Width = 97
      Height = 17
      Caption = #1047#1072#1082#1088#1099#1090#1099#1077
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chb_Open: TCheckBox
      Left = 8
      Top = 33
      Width = 97
      Height = 17
      Caption = #1054#1090#1082#1088#1099#1090#1099#1077
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object chb_Viesnen: TCheckBox
      Left = 8
      Top = 50
      Width = 97
      Height = 17
      Caption = #1053#1072' '#1074#1099#1103#1089#1085#1077#1085#1080#1080
      TabOrder = 2
    end
    object chb_Lozh: TCheckBox
      Left = 8
      Top = 67
      Width = 97
      Height = 17
      Caption = #1051#1086#1078#1085#1099#1077
      TabOrder = 3
    end
  end
  object chb_otl: TCheckBox
    Left = 24
    Top = 248
    Width = 113
    Height = 17
    Caption = #1054#1090#1083#1086#1078#1077#1085#1085#1099#1077
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 7
  end
end
