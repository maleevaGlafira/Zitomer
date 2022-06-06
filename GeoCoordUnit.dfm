object Frm_GEOCOORD: TFrm_GEOCOORD
  Left = 0
  Top = 0
  Width = 416
  Height = 21
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object RxLabelN: TRxLabel
    Left = 8
    Top = 5
    Width = 10
    Height = 13
    Caption = 'N'
  end
  object RxLabelE: TRxLabel
    Left = 196
    Top = 4
    Width = 9
    Height = 13
    Caption = 'E'
  end
  object se_Deg_N: TRxSpinEdit
    Left = 24
    Top = 1
    Width = 49
    Height = 20
    Decimal = 0
    MaxValue = 89.000000000000000000
    Value = 49.000000000000000000
    MaxLength = 2
    TabOrder = 0
  end
  object se_Min_N: TRxSpinEdit
    Left = 72
    Top = 1
    Width = 49
    Height = 20
    Decimal = 0
    MaxValue = 59.000000000000000000
    Value = 4.000000000000000000
    MaxLength = 2
    TabOrder = 1
  end
  object se_Sec_N: TRxSpinEdit
    Left = 120
    Top = 1
    Width = 65
    Height = 20
    Decimal = 4
    MaxValue = 59.000000000000000000
    ValueType = vtFloat
    TabOrder = 2
  end
  object se_Deg_E: TRxSpinEdit
    Left = 208
    Top = 1
    Width = 49
    Height = 20
    Decimal = 0
    MaxValue = 89.000000000000000000
    Value = 33.000000000000000000
    MaxLength = 2
    TabOrder = 3
  end
  object se_Min_E: TRxSpinEdit
    Left = 256
    Top = 1
    Width = 49
    Height = 20
    Decimal = 0
    MaxValue = 59.000000000000000000
    Value = 25.000000000000000000
    MaxLength = 2
    TabOrder = 4
  end
  object se_Sec_E: TRxSpinEdit
    Left = 304
    Top = 1
    Width = 65
    Height = 20
    Decimal = 4
    MaxValue = 59.000000000000000000
    ValueType = vtFloat
    TabOrder = 5
  end
  object BitBtn1: TBitBtn
    Left = 373
    Top = 1
    Width = 37
    Height = 19
    Caption = 'OK'
    TabOrder = 6
    OnClick = bt_OKClick
  end
end
