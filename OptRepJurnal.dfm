inherited frm_OptRepJurnal: Tfrm_OptRepJurnal
  Left = 545
  Top = 465
  Width = 320
  Height = 281
  Caption = 'frm_OptRepJurnal'
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 20
    Width = 74
    Height = 13
    Caption = #1044#1072#1090#1072' '#1089#1084#1077#1085#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 32
    Top = 60
    Width = 50
    Height = 13
    Caption = #1059#1095#1072#1089#1090#1086#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object dt_in: TDateEdit
    Left = 136
    Top = 16
    Width = 121
    Height = 21
    NumGlyphs = 2
    TabOrder = 0
  end
  object rle_revs: TRxLookupEdit
    Left = 88
    Top = 176
    Width = 177
    Height = 21
    LookupDisplay = 'NAME_R'
    LookupField = 'ID'
    LookupSource = ds_revs
    TabOrder = 1
    Visible = False
  end
  object btn_ok: TBitBtn
    Left = 16
    Top = 208
    Width = 81
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
    Left = 184
    Top = 208
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btn_cancelClick
    Kind = bkCancel
  end
  object cb_otl: TCheckBox
    Left = 32
    Top = 56
    Width = 97
    Height = 17
    Caption = #1054#1090#1083#1086#1078#1077#1085#1085#1099#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  inline frame_SelOwner1: Tframe_SelOwner
    Left = 8
    Top = 88
    Width = 265
    Height = 34
    TabOrder = 5
    inherited btn_SelItem: TBitBtn
      Width = 255
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = frame_SelOwner1btn_SelItemClick
    end
  end
  inline frame_SelRevs1: Tframe_SelRevs
    Left = 8
    Top = 120
    Width = 265
    Height = 31
    TabOrder = 6
    inherited btn_SelItem: TBitBtn
      Width = 257
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = frame_SelRevs1btn_SelItemClick
    end
  end
  object dset_revs: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = DM_main.tran
    SelectSQL.Strings = (
      'select id, name_r from s_revs ')
    Left = 120
    Top = 80
  end
  object ds_revs: TDataSource
    DataSet = dset_revs
    Left = 160
    Top = 80
  end
end
