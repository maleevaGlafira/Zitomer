inherited frm_RepClosedExcavOpt: Tfrm_RepClosedExcavOpt
  Left = 600
  Top = 476
  Width = 309
  Height = 221
  Caption = 'frm_RepClosedExcavOpt'
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  inline frame_SelRevs1: Tframe_SelRevs
    Left = 48
    Top = 64
    Width = 191
    Height = 31
    TabOrder = 0
    inherited btn_SelItem: TBitBtn
      OnClick = frame_SelRevs1btn_SelItemClick
    end
  end
  inline frame_SelDatePeriod1: Tframe_SelDatePeriod
    Left = 8
    Top = 16
    Width = 281
    Height = 33
    Hint = #1076#1083#1103' '#1076#1072#1090#1099' '#1085#1072#1095#1072#1083#1072' '#1088#1072#1089#1082#1086#1087#1082#1080#13#10#1074' '#1074#1099#1077#1079#1076#1077' '#1089' '#1088#1072#1073#1086#1090#1086#1081' '#1088#1072#1089#1082#1086#1087#1082#1072' '
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 144
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    TabOrder = 2
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 192
    Top = 144
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 3
    Kind = bkCancel
  end
  inline frame_SelMest1: Tframe_SelMest
    Left = 48
    Top = 104
    Width = 187
    Height = 32
    TabOrder = 4
    inherited btn_SelItem: TBitBtn
      OnClick = frame_SelMest1btn_SelItemClick
    end
  end
end
