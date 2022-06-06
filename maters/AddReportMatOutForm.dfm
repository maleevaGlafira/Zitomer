inherited frm_AddReportMatOut: Tfrm_AddReportMatOut
  Left = 596
  Top = 429
  Width = 420
  Height = 193
  Caption = 'frm_AddReportMatOut'
  OldCreateOrder = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_brigname: TLabel
    Left = 184
    Top = 8
    Width = 59
    Height = 13
    Caption = 'lbl_brigname'
  end
  object lbl_brigcap: TLabel
    Left = 8
    Top = 8
    Width = 51
    Height = 13
    Caption = 'lbl_brigcap'
  end
  object lbl_month: TLabel
    Left = 168
    Top = 56
    Width = 45
    Height = 13
    Caption = 'lbl_month'
  end
  object lbl_year: TLabel
    Left = 8
    Top = 56
    Width = 36
    Height = 13
    Caption = 'lbl_year'
  end
  object cb_month: TComboBox
    Left = 256
    Top = 56
    Width = 121
    Height = 21
    ItemHeight = 13
    TabOrder = 0
  end
  object cb_year: TComboBox
    Left = 56
    Top = 56
    Width = 97
    Height = 21
    ItemHeight = 13
    TabOrder = 1
  end
  object btn_Save: TBitBtn
    Left = 8
    Top = 96
    Width = 105
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btn_SaveClick
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
    Left = 272
    Top = 96
    Width = 107
    Height = 25
    TabOrder = 3
    OnClick = btn_exitClick
    Kind = bkCancel
  end
end
