inherited frm_OptMatUse: Tfrm_OptMatUse
  Left = 502
  Top = 374
  Caption = 'frm_OptMatUse'
  ClientHeight = 146
  ClientWidth = 274
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel [0]
    Left = 0
    Top = 0
    Width = 274
    Height = 113
    Align = alTop
  end
  inherited btn_ok: TBitBtn
    Left = 103
    Top = 120
    OnClick = btn_okClick
  end
  inherited btn_close: TBitBtn
    Left = 190
    Top = 120
  end
  inline frame_SelAttach: Tframe_SelAttach
    Left = 48
    Top = 40
    Width = 192
    Height = 29
    TabOrder = 2
  end
  inline frame_Dates: Tframe_SelDatePeriod
    Left = 4
    Top = 8
    Width = 267
    Height = 23
    TabOrder = 3
  end
  inline frame_SelMat: Tframe_SelMat
    Left = 49
    Top = 70
    Width = 189
    Height = 32
    TabOrder = 4
  end
end
