inherited frm_OtlNaradList: Tfrm_OtlNaradList
  Left = 448
  Top = 477
  Width = 696
  Height = 245
  Caption = 'frm_OtlNaradList'
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object save_panel: TPanel
    Left = 0
    Top = 177
    Width = 688
    Height = 41
    Align = alBottom
    TabOrder = 0
    object btn_linked: TBitBtn
      Left = 8
      Top = 8
      Width = 121
      Height = 25
      Caption = #1057#1074#1103#1079#1072#1090#1100' '#1085#1072#1088#1103#1076
      TabOrder = 0
      OnClick = btn_linkedClick
    end
    object btn_saved: TBitBtn
      Left = 240
      Top = 8
      Width = 75
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 1
      OnClick = btn_savedClick
    end
    object BitBtn3: TBitBtn
      Left = 472
      Top = 8
      Width = 75
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object btn_del: TBitBtn
      Left = 136
      Top = 8
      Width = 105
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1074#1103#1079#1100
      TabOrder = 3
      OnClick = btn_delClick
    end
  end
  object Grid: TStringAlignGrid
    Left = 0
    Top = 0
    Width = 688
    Height = 177
    Align = alClient
    Ctl3D = False
    DefaultRowHeight = 18
    ParentCtl3D = False
    TabOrder = 1
    OnDblClick = GridDblClick
    OnFixedColClick = GridFixedColClick
    PropCell = ()
    PropCol = ()
    PropRow = ()
    PropFixedCol = ()
    PropFixedRow = ()
  end
end
