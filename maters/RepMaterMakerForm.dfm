inherited frm_RepMaterMaker: Tfrm_RepMaterMaker
  Left = 352
  Top = 165
  Width = 771
  Height = 653
  Caption = 'frm_RepMaterMaker'
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_Data: TPanel
    Left = 0
    Top = 0
    Width = 753
    Height = 121
    TabOrder = 0
    object lbl_brigcap: TLabel
      Left = 19
      Top = 14
      Width = 57
      Height = 13
      Caption = #1041#1088#1080#1075#1072#1076#1080#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_capReport: TLabel
      Left = 412
      Top = 21
      Width = 80
      Height = 13
      Caption = 'lbl_capReport'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RxDBLBrigs: TRxDBLookupCombo
      Left = 117
      Top = 13
      Width = 276
      Height = 21
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'CONCATENATION'
      LookupSource = ds_brigs
      TabOrder = 0
      OnChange = RxDBLBrigsChange
    end
    object RxDBLReports_out: TRxDBLookupCombo
      Left = 501
      Top = 15
      Width = 145
      Height = 21
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'show_title'
      LookupSource = ds_reports_out
      TabOrder = 1
      OnChange = RxDBLBrigsChange
    end
    object btn_openDeps: TButton
      Left = 24
      Top = 80
      Width = 97
      Height = 25
      Caption = 'btn_openDeps'
      TabOrder = 2
      OnClick = btn_openDepsClick
    end
    object btn_CloseDeps: TButton
      Left = 616
      Top = 88
      Width = 129
      Height = 25
      Caption = 'btn_CloseDeps'
      TabOrder = 4
      OnClick = btn_CloseDepsClick
    end
    object btn_set_nums: TButton
      Left = 128
      Top = 80
      Width = 113
      Height = 25
      Caption = #1055#1088#1086#1085'- '#1091#1084#1077#1088#1086#1074#1072#1090#1100
      TabOrder = 3
      WordWrap = True
      OnClick = btn_set_numsClick
    end
  end
  object DBG_deps: TDBGridEh
    Left = 0
    Top = 128
    Width = 753
    Height = 417
    DataSource = ds_deps
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        FieldName = 'nomer'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1053#1072#1088#1103#1076
      end
      item
        FieldName = 'dt'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1044#1072#1090#1072
        Width = 215
      end
      item
        FieldName = 'address'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1040#1076#1088#1077#1089
        Width = 255
      end
      item
        FieldName = 'n_col'
        Footers = <>
        Title.Caption = #8470' '#1050#1086#1083
        Title.SortIndex = 1
        Title.SortMarker = smUpEh
        Width = 65
      end>
  end
  object pnl_Bottums: TPanel
    Left = 0
    Top = 555
    Width = 755
    Height = 41
    Align = alBottom
    TabOrder = 2
    object btn_DoReport: TBitBtn
      Left = 56
      Top = 8
      Width = 107
      Height = 25
      Caption = 'btn_DoReport'
      TabOrder = 0
      OnClick = btn_DoReportClick
    end
    object btn_Close: TBitBtn
      Left = 184
      Top = 8
      Width = 97
      Height = 25
      TabOrder = 1
      Kind = bkClose
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 596
    Width = 755
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object ds_deps: TDataSource
    DataSet = dm_RepMaterMaker.mem_deps
    Left = 264
    Top = 208
  end
  object ds_brigs: TDataSource
    DataSet = dm_RepMaterMaker.dset_brigs
    Left = 328
    Top = 24
  end
  object ds_reports_out: TDataSource
    DataSet = dm_RepMaterMaker.dset_reports_out
    Left = 552
    Top = 16
  end
end
