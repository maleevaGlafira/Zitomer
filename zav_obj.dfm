inherited FormZavObj: TFormZavObj
  Left = 265
  Top = 230
  Caption = 'FormZavObj'
  ClientHeight = 680
  ClientWidth = 747
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 16
  inherited Panel1: TPanel
    Width = 747
    Height = 655
    inherited Label9: TLabel
      Top = 452
    end
    inherited BShowonMap: TSpeedButton
      Left = 580
      Top = 261
      Visible = False
    end
    inherited SpeedButton1: TSpeedButton
      Top = 419
    end
    inherited Label1: TLabel
      Left = 786
      Top = 68
      Visible = False
    end
    inherited Label3: TLabel
      Left = 140
    end
    inherited Label20: TLabel
      Left = 6
      Top = 337
    end
    inherited Bevel4: TBevel
      Height = 73
    end
    inherited Label25: TLabel
      Left = 19
      Top = 196
    end
    inherited Bevel5: TBevel
      Top = 482
    end
    inherited Bevel1: TBevel
      Top = 299
    end
    inherited Label5: TLabel
      Top = 452
      Visible = False
    end
    inherited Label11: TLabel
      Top = 404
    end
    inherited Label17: TLabel
      Left = 241
      Top = 58
    end
    object Label26: TLabel [30]
      Left = 8
      Top = 312
      Width = 84
      Height = 16
      Caption = #1057#1086#1086#1088#1091#1078#1077#1085#1080#1077
    end
    inherited DBL_zav: TRxDBLookupCombo
      Width = 113
    end
    inherited DBL_tzav: TRxDBLookupCombo
      Top = 447
    end
    inherited GrB_adres: TGroupBox
      Left = 783
      Top = 171
      Visible = False
    end
    inherited GrB_damg: TGroupBox
      Top = 507
      inherited Label19: TLabel
        Width = 87
        Visible = False
      end
      inherited DBL_Mest: TRxDBLookupCombo
        Visible = False
      end
      inherited bt_COORD: TButton
        Left = 568
        Top = 97
      end
      inherited PCoord: TPanel
        Left = 576
        Visible = False
      end
      inherited Frm_GEOCOORD1: TFrm_GEOCOORD
        Left = 584
        Top = 107
      end
    end
    inherited BB_Save: TBitBtn
      Left = 639
      Top = 587
    end
    inherited BB_Exit: TBitBtn
      Left = 664
      Top = 613
    end
    inherited BB_zadv: TBitBtn
      Left = 628
    end
    inherited BB_Narad: TBitBtn
      Left = 639
      Top = 562
    end
    inherited BB_Ras: TBitBtn
      Left = 788
      Top = 250
    end
    inherited Panel2: TPanel
      inherited Lb_Nzav: TStaticText
        Caption = #1053#1086#1074#1099#1081
      end
    end
    inherited Panel3: TPanel
      Left = 636
      Top = 504
      Height = 57
    end
    inherited Ed_dopinfORG: TEdit
      Left = 136
      Width = 227
    end
    inherited DBL_Raon: TRxDBLookupCombo
      Left = 784
      Top = 85
      Visible = False
    end
    inherited cbAttach: TComboBox
      Width = 226
    end
    inherited edDop_inf: TMemo
      Left = 103
      Top = 336
      Height = 43
    end
    inherited Ed_dopinfTEL: TEdit
      Height = 26
    end
    inherited DBL_owner: TRxDBLookupCombo
      Left = 86
      Top = 199
    end
    inherited ChB_Cont: TCheckBox
      Left = 401
      Top = 106
    end
    inherited DBLC_brig: TRxDBLookupCombo
      Left = 399
      Top = 127
    end
    inherited DBL_place: TRxDBLookupCombo
      Top = 447
      Visible = False
    end
    inherited BB_Poteri: TBitBtn
      Left = 628
      Top = 130
    end
    inherited DE_Poluch: TDateEdit
      Top = 400
    end
    inherited TE_Poluch: TDateTimePicker
      Top = 400
    end
    inherited DBL_BrPoluch: TRxDBLookupCombo
      Top = 400
    end
    inherited BB_Image: TBitBtn
      Left = 629
      Top = 199
    end
    inherited DBL_Revs: TRxDBLookupCombo
      Left = 239
    end
    inherited cb_OTL: TCheckBox
      TabOrder = 41
    end
    inherited dbl_settlers: TRxDBLookupCombo
      TabOrder = 40
    end
    inherited BB_WithoutWater: TBitBtn
      Left = 628
      Top = 157
      TabOrder = 36
    end
    inherited btn_linkOtlZav: TButton
      Left = 631
      Top = 224
      TabOrder = 42
    end
    object dbl_Object: TRxDBLookupCombo
      Left = 73
      Top = 242
      Width = 256
      Height = 24
      DropDownCount = 8
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      LookupField = 'NAME_R'
      LookupDisplay = 'NAME_R'
      LookupSource = DM_Zavv.ds_Object
      ParentFont = False
      TabOrder = 35
      OnChange = dbl_ObjectChange
      OnKeyPress = DBL_RaonKeyPress
    end
    object dbl_Soorug: TRxDBLookupCombo
      Left = 105
      Top = 306
      Width = 368
      Height = 24
      DropDownCount = 8
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      LookupField = 'NAME_R'
      LookupDisplay = 'NAME_R'
      LookupSource = DM_Zavv.ds_soorug
      ParentFont = False
      TabOrder = 37
      OnChange = DBL_RaonChange
      OnKeyPress = DBL_RaonKeyPress
    end
    object cb_ObjObor: TCheckBox
      Left = 9
      Top = 274
      Width = 192
      Height = 17
      TabStop = False
      Caption = #1091#1095#1080#1090#1099#1074#1072#1090#1100' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 38
      OnClick = cb_ObjOborClick
      OnKeyPress = DBL_RaonKeyPress
    end
    object bt_Objobor: TButton
      Left = 492
      Top = 304
      Width = 108
      Height = 25
      Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
      TabOrder = 39
      OnClick = bt_ObjoborClick
    end
  end
  inherited Pn_stat: TPanel
    Top = 655
    Width = 747
    inherited Lb_save: TLabel
      Left = 585
    end
  end
  inherited bbMap: TBitBtn
    Left = 638
    Top = 613
  end
  inherited PopupMenu1: TPopupMenu
    Left = 796
    Top = 372
  end
  inherited PopAutoVvod: TPopupMenu
    Left = 792
    Top = 320
  end
end
