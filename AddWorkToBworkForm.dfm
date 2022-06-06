object frm_AddWorkToBwork: Tfrm_AddWorkToBwork
  Left = 430
  Top = 507
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1088#1072#1073#1086#1090#1099
  ClientHeight = 117
  ClientWidth = 289
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
    Left = 20
    Top = 9
    Width = 32
    Height = 13
    Caption = #1052#1077#1089#1090#1086
  end
  object Label2: TLabel
    Left = 15
    Top = 34
    Width = 36
    Height = 13
    Caption = #1056#1072#1073#1086#1090#1072
  end
  object Label3: TLabel
    Left = 6
    Top = 58
    Width = 46
    Height = 13
    Caption = #1044#1080#1072#1084#1077#1090#1088
  end
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 289
    Height = 84
    Align = alTop
  end
  object dbl_Place: TRxDBLookupCombo
    Left = 56
    Top = 6
    Width = 225
    Height = 21
    DropDownCount = 8
    LookupField = 'id'
    LookupDisplay = 'name_r'
    LookupSource = ds_s_place
    TabOrder = 0
  end
  object dbl_Work: TRxDBLookupCombo
    Left = 56
    Top = 32
    Width = 225
    Height = 21
    DropDownCount = 8
    LookupField = 'id'
    LookupDisplay = 'name_r'
    LookupSource = ds_s_work
    TabOrder = 1
  end
  object dbl_Diam: TRxDBLookupCombo
    Left = 56
    Top = 56
    Width = 89
    Height = 21
    DropDownCount = 8
    LookupField = 'id'
    LookupDisplay = 'name_r'
    LookupSource = ds_s_diam
    TabOrder = 2
  end
  object btn_ok: TBitBtn
    Left = 120
    Top = 88
    Width = 83
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    TabOrder = 3
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
    Left = 208
    Top = 88
    Width = 81
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 4
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
  object dset_s_place: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    SelectSQL.Strings = (
      'select id, name_r'
      'from s_place'
      'where (del='#39'-'#39')'
      'order by name_r')
    Left = 8
    Top = 96
    object dset_s_placeID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_PLACE.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_s_placeNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_PLACE.NAME_R'
      FixedChar = True
    end
  end
  object dset_s_work: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    SelectSQL.Strings = (
      'select id, name_r'
      'from s_work'
      'where (del='#39'-'#39')'
      'and (ftype = :id)'
      'and ( not( id_work_type in (1,2) ) or ( id_work_type is null ) )'
      'order by name_r')
    DataSource = ds_s_place
    Left = 8
    Top = 152
    object dset_s_workID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_WORK.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_s_workNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'S_WORK.NAME_R'
      FixedChar = True
      Size = 50
    end
  end
  object dset_s_diam: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_Spr
    OnCalcFields = dset_s_diamCalcFields
    SelectSQL.Strings = (
      'select id, diam'
      'from s_diam'
      'where (del='#39'-'#39')'
      'order by diam')
    Left = 8
    Top = 208
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
  object ds_s_place: TDataSource
    DataSet = dset_s_place
    Left = 40
    Top = 96
  end
  object ds_s_work: TDataSource
    DataSet = dset_s_work
    Left = 40
    Top = 152
  end
  object ds_s_diam: TDataSource
    DataSet = dset_s_diam
    Left = 40
    Top = 200
  end
  object tran_Spr: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 136
    Top = 161
  end
end
