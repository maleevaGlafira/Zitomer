inherited frm_OptDiscon13Group: Tfrm_OptDiscon13Group
  Left = 531
  Top = 305
  Width = 333
  Height = 373
  Caption = 'frm_OptDiscon13Group'
  PixelsPerInch = 96
  TextHeight = 13
  inherited btn_ok: TBitBtn
    Top = 272
  end
  inherited btn_cansel: TBitBtn
    Left = 192
    Top = 272
  end
  inherited rg_disconType: TRadioGroup
    Top = 216
    Visible = False
  end
  inherited frame_SelStreetsDiscon: Tframe_SelStreets
    TabOrder = 7
  end
  object gb_withouwater: TGroupBox
    Left = 16
    Top = 136
    Width = 217
    Height = 81
    TabOrder = 5
    Visible = False
    object rg_wthoutwater: TRadioGroup
      Left = 0
      Top = 0
      Width = 217
      Height = 41
      Caption = #1057#1091#1090#1082' '#1073#1077#1079' '#1074#1086#1076#1099
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        #1042#1089#1077
        #1052#1077#1085#1100#1096#1077
        #1041#1086#1083#1100#1096#1077)
      TabOrder = 0
      OnClick = rg_wthoutwaterClick
    end
    object spe_withoutwater: TSpinEdit
      Left = 8
      Top = 48
      Width = 65
      Height = 22
      Enabled = False
      MaxValue = 32000
      MinValue = 1
      TabOrder = 1
      Value = 1
    end
  end
end
