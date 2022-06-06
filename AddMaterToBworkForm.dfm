object frm_AddMaterToBwork: Tfrm_AddMaterToBwork
  Left = 462
  Top = 401
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1072
  ClientHeight = 91
  ClientWidth = 262
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 7
    Width = 50
    Height = 13
    Caption = #1052#1072#1090#1077#1088#1080#1072#1083
  end
  object Label2: TLabel
    Left = 16
    Top = 31
    Width = 46
    Height = 13
    Caption = #1044#1080#1072#1084#1077#1090#1088
  end
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 262
    Height = 53
    Align = alTop
  end
  object dbl_Mater: TRxDBLookupCombo
    Left = 64
    Top = 3
    Width = 193
    Height = 21
    DropDownCount = 8
    LookupField = 'ID'
    LookupDisplay = 'NAME_R'
    LookupSource = ds_s_mat
    TabOrder = 0
  end
  object dbl_Diam: TRxDBLookupCombo
    Left = 64
    Top = 27
    Width = 89
    Height = 21
    DropDownCount = 8
    LookupField = 'ID'
    LookupDisplay = 'name_r'
    LookupSource = ds_s_diam
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 86
    Top = 64
    Width = 81
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    TabOrder = 2
    OnClick = BitBtn1Click
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
  object BitBtn2: TBitBtn
    Left = 171
    Top = 64
    Width = 83
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 3
    OnClick = BitBtn2Click
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
  object dset_s_mat: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_spr
    SelectSQL.Strings = (
      'select id, name_r'
      'from s_mat'
      'where del = '#39'-'#39
      'order by name_r')
    Left = 232
    Top = 16
    object dset_s_matID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_MAT.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_s_matNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_MAT.NAME_R'
      FixedChar = True
    end
  end
  object dset_s_diam: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_spr
    OnCalcFields = dset_s_diamCalcFields
    SelectSQL.Strings = (
      'select id, diam'
      'from s_diam'
      'where (del='#39'-'#39')'
      'order by diam')
    Left = 248
    Top = 40
    object dset_s_diamID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_DIAM.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_s_diamDIAM: TIntegerField
      FieldName = 'DIAM'
      Origin = 'S_DIAM.DIAM'
    end
    object dset_s_diamname_r: TStringField
      FieldKind = fkCalculated
      FieldName = 'name_r'
      Size = 10
      Calculated = True
    end
  end
  object ds_s_mat: TDataSource
    DataSet = dset_s_mat
    Left = 280
    Top = 16
  end
  object ds_s_diam: TDataSource
    DataSet = dset_s_diam
    Left = 288
    Top = 64
  end
  object tran_spr: TIBTransaction
    Active = True
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 24
    Top = 72
  end
end
