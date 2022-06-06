inherited frm_SvodkaSESOpt: Tfrm_SvodkaSESOpt
  Left = 424
  Top = 191
  Caption = #1057#1074#1086#1076#1082#1072' '#1074' '#1057#1069#1057
  ClientHeight = 523
  ClientWidth = 568
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel [0]
    Left = 0
    Top = 0
    Width = 568
    Height = 49
    Align = alTop
  end
  object Bevel2: TBevel [1]
    Left = 5
    Top = 52
    Width = 274
    Height = 3
  end
  object Label1: TLabel [2]
    Left = 170
    Top = 9
    Width = 32
    Height = 13
    Caption = #1074#1088#1077#1084#1103
  end
  inherited btn_ok: TBitBtn
    Top = 391
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = btn_okClick
  end
  inherited btn_close: TBitBtn
    Top = 391
    Width = 89
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited mem_Info: TMemo [5]
    Top = 420
    Width = 568
    Height = 103
  end
  inline frame_SelDates: Tframe_SelDatePeriod [6]
    Left = 7
    Top = 56
    Width = 267
    Height = 23
    TabOrder = 4
  end
  inherited btn_save: TBitBtn
    Left = 9
    Top = 391
  end
  object gb_Opt: TGroupBox
    Left = 8
    Top = 145
    Width = 273
    Height = 240
    TabOrder = 5
    object pg_Option: TPageControl
      Left = 8
      Top = 62
      Width = 257
      Height = 168
      ActivePage = ts_Voda
      TabOrder = 0
      object ts_Voda: TTabSheet
        Caption = #1042#1086#1076#1086#1087#1088#1086#1074#1086#1076
        inline frame_SelTZav_voda: Tframe_SelTZav
          Left = 31
          Top = 42
          Width = 192
          Height = 30
          TabOrder = 0
          inherited btn_SelItem: TBitBtn
            Caption = #1058#1080#1087' '#1085#1072#1088#1103#1076#1072
          end
        end
        inline frame_SelPlace_voda: Tframe_SelPlace
          Left = 30
          Top = 72
          Width = 188
          Height = 29
          TabOrder = 1
        end
        inline frame_SelSod_voda: Tframe_SelSod
          Left = 31
          Top = 104
          Width = 189
          Height = 27
          TabOrder = 2
        end
        inline frame_SelOwner_voda: Tframe_SelOwner
          Left = 30
          Top = 10
          Width = 194
          Height = 31
          TabOrder = 3
          inherited btn_SelItem: TBitBtn
            Caption = #1042#1080#1076' '#1085#1072#1088#1103#1076#1072
          end
        end
      end
      object ts_Kanal: TTabSheet
        Caption = #1050#1072#1085#1072#1083#1080#1079#1072#1094#1080#1103
        ImageIndex = 1
        inline frame_SelTZav_kanal: Tframe_SelTZav
          Left = 31
          Top = 42
          Width = 192
          Height = 30
          TabOrder = 0
          inherited btn_SelItem: TBitBtn
            Caption = #1058#1080#1087' '#1085#1072#1088#1103#1076#1072
          end
        end
        inline frame_SelPlace_kanal: Tframe_SelPlace
          Left = 30
          Top = 72
          Width = 188
          Height = 29
          TabOrder = 1
        end
        inline frame_SelSod_kanal: Tframe_SelSod
          Left = 31
          Top = 104
          Width = 189
          Height = 27
          TabOrder = 2
        end
        inline frame_SelOwner_kanal: Tframe_SelOwner
          Left = 30
          Top = 10
          Width = 194
          Height = 34
          TabOrder = 3
          inherited btn_SelItem: TBitBtn
            Caption = #1042#1080#1076' '#1085#1072#1088#1103#1076#1072
            OnClick = frame_SelOwner_kanalbtn_SelItemClick
          end
        end
      end
    end
  end
  object gb_DispInfo: TGroupBox
    Left = 7
    Top = 81
    Width = 274
    Height = 68
    TabOrder = 6
    object Label2: TLabel
      Left = 12
      Top = 43
      Width = 38
      Height = 13
      Caption = #1055#1088#1080#1085#1103#1083
    end
    inline frame_SelSdalBrig: Tframe_SelSingleBrig
      Left = 4
      Top = 9
      Width = 263
      Height = 28
      TabOrder = 0
      inherited lbl_Caption: TLabel
        Left = 20
        Top = 9
        Width = 25
        Caption = #1057#1076#1072#1083
      end
      inherited dbl_Item: TRxDBLookupCombo
        Left = 51
        Width = 210
      end
    end
    object ed_Prinyal: TEdit
      Left = 56
      Top = 40
      Width = 209
      Height = 21
      TabOrder = 1
    end
  end
  inline frame_SelSvodkaDate: Tframe_SelDatePeriod
    Left = 4
    Top = 4
    Width = 163
    Height = 23
    HorzScrollBar.Visible = False
    VertScrollBar.Visible = False
    TabOrder = 7
    inherited Label1: TLabel
      Width = 65
      Caption = #1044#1072#1090#1072' '#1089#1074#1086#1076#1082#1080
    end
    inherited Label2: TLabel
      Left = 187
    end
    inherited de_Begin: TDateEdit
      Left = 71
      OnChange = chb_IsReCreateClick
    end
    inherited de_End: TDateEdit
      Left = 202
    end
  end
  object chb_IsReCreate: TCheckBox
    Left = 10
    Top = 30
    Width = 150
    Height = 15
    Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1085#1086#1074#1086
    Checked = True
    State = cbChecked
    TabOrder = 8
    WordWrap = True
    OnClick = chb_IsReCreateClick
  end
  object pnl_Attach: TPanel
    Left = 16
    Top = 153
    Width = 209
    Height = 48
    BevelOuter = bvNone
    TabOrder = 9
    object chb_Voda: TCheckBox
      Left = 4
      Top = 1
      Width = 201
      Height = 17
      Caption = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1079#1072#1103#1074#1082#1080' '#1087#1086' '#1074#1086#1076#1086#1087#1088#1086#1074#1086#1076#1091
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = chb_VodaClick
    end
    object chb_Kanal: TCheckBox
      Left = 4
      Top = 17
      Width = 201
      Height = 17
      Caption = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1079#1072#1103#1074#1082#1080' '#1087#1086' '#1082#1072#1085#1072#1083#1080#1079#1072#1094#1080#1080
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = chb_KanalClick
    end
    object cbh_VRK: TCheckBox
      Left = 3
      Top = 32
      Width = 198
      Height = 17
      Caption = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1079#1072#1103#1074#1082#1080' '#1087#1086' '#1042#1056#1050
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = cbh_VRKClick
    end
  end
  object me_Time: TMaskEdit
    Left = 208
    Top = 5
    Width = 37
    Height = 21
    EditMask = '!90:00;1;0'
    MaxLength = 5
    TabOrder = 10
    Text = '  :  '
  end
  object dblb_Saves: TDBGrid
    Left = 288
    Top = 91
    Width = 294
    Height = 270
    DataSource = ds_Saves
    ReadOnly = True
    TabOrder = 11
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    OnDblClick = btn_okClick
  end
  object ds_Saves: TDataSource
    DataSet = dset_MTSaves
    Left = 320
    Top = 72
  end
  object dset_MTSaves: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 376
    Top = 72
    object dset_MTSavesID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object dset_MTSavesDT: TDateTimeField
      DisplayLabel = #1057#1086#1093#1088#1072#1085#1105#1085#1085#1099#1077' '#1089#1074#1086#1076#1082#1080
      FieldName = 'DT'
    end
    object dset_MTSavesAtt: TStringField
      DisplayLabel = #1055#1088#1080#1085#1072#1076#1083#1077#1078#1085#1086#1089#1090#1100
      DisplayWidth = 24
      FieldName = 'Att'
      Size = 24
    end
    object dset_MTSavesAttID: TIntegerField
      FieldName = 'AttID'
    end
  end
end
