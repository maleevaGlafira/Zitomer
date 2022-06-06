object frm_FastAddWork: Tfrm_FastAddWork
  Left = 352
  Top = 273
  Width = 421
  Height = 334
  Caption = #1041#1099#1089#1090#1088#1086#1077' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Grid: TDBGridEh
    Left = 0
    Top = 0
    Width = 413
    Height = 266
    Align = alClient
    DataSource = ds_Main
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    UseMultiTitle = True
    Columns = <
      item
        AutoFitColWidth = False
        FieldName = 'is_add_bwork'
        Footers = <>
        Title.Caption = ' '
        Width = 26
      end
      item
        AutoFitColWidth = False
        FieldName = 'BWork'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1056#1072#1073#1086#1090#1072
        Width = 208
      end
      item
        AutoFitColWidth = False
        FieldName = 'is_add_work'
        Footers = <>
        Title.Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1086#1086#1090#1074#1077#1090'.||'#1087#1086#1076#1088#1072#1073#1086#1090#1099
        Width = 67
      end
      item
        AutoFitColWidth = False
        FieldName = 'is_add_mater'
        Footers = <>
        Title.Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1086#1086#1090#1074#1077#1090'.||'#1084#1072#1090#1077#1088#1080#1072#1083#1099
        Width = 65
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 266
    Width = 413
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      413
      41)
    object btn_ok: TBitBtn
      Left = 232
      Top = 8
      Width = 83
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1055#1088#1080#1085#1103#1090#1100
      Default = True
      TabOrder = 0
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
    object btn_exit: TBitBtn
      Left = 320
      Top = 8
      Width = 83
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      TabOrder = 1
      OnClick = btn_exitClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
  object ds_Main: TDataSource
    DataSet = mt_FastAdd
    Left = 200
    Top = 72
  end
  object mt_FastAdd: TkbmMemTable
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
    Left = 104
    Top = 120
    object mt_FastAddBWork: TStringField
      FieldName = 'BWork'
      Size = 40
    end
    object mt_FastAddid_bwork: TIntegerField
      FieldName = 'id_bwork'
    end
    object mt_FastAddis_add_bwork: TBooleanField
      FieldName = 'is_add_bwork'
      OnChange = mt_FastAddis_add_bworkChange
    end
    object mt_FastAddis_add_work: TBooleanField
      FieldName = 'is_add_work'
    end
    object mt_FastAddis_add_mater: TBooleanField
      FieldName = 'is_add_mater'
    end
  end
  object dset: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 264
    Top = 144
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 264
    Top = 192
  end
end
