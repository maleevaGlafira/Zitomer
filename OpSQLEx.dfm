object FormOpSQL: TFormOpSQL
  Left = 371
  Top = 257
  BorderStyle = bsDialog
  Caption = #1042#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1079#1072#1087#1088#1086#1089#1072' ...'
  ClientHeight = 90
  ClientWidth = 277
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 40
    Top = 7
    Width = 152
    Height = 19
    Caption = #1054#1090#1084#1077#1085#1072' '#1079#1072#1087#1088#1086#1089#1072' ...'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object BB_ESC: TBitBtn
    Left = 61
    Top = 60
    Width = 154
    Height = 28
    Caption = #1055#1088#1077#1088#1074#1072#1090#1100
    TabOrder = 0
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
  object Anim: TAnimate
    Left = 0
    Top = 0
    Width = 277
    Height = 60
    Align = alTop
    Active = True
    CommonAVI = aviCopyFile
    StopFrame = 1
  end
  object Db_ESC: TDatabase
    AliasName = 'AVARODESSA'
    DatabaseName = 'ESC_al'
    LoginPrompt = False
    SessionName = 'Default'
    Left = 92
    Top = 8
  end
  object Qry_ESC: TQuery
    DatabaseName = 'ESC_al'
    Left = 144
    Top = 12
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 12
    Top = 60
  end
  object Qry_exit: TQuery
    Left = 40
    Top = 8
  end
end
