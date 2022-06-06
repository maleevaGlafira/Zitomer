object OborChoiseForm: TOborChoiseForm
  Left = 387
  Top = 300
  Width = 392
  Height = 178
  Caption = #1079#1072#1103#1074#1082#1072'/'#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object p_Bottom: TPanel
    Left = 0
    Top = 99
    Width = 376
    Height = 41
    Align = alBottom
    TabOrder = 0
    object bt_OK: TButton
      Left = 144
      Top = 8
      Width = 75
      Height = 25
      Caption = #1054#1050
      ModalResult = 1
      TabOrder = 0
      OnClick = bt_OKClick
    end
    object bt_Cancel: TButton
      Left = 288
      Top = 8
      Width = 75
      Height = 25
      Caption = 'bt_Cancel'
      ModalResult = 2
      TabOrder = 1
      Visible = False
    end
  end
  object p_Main: TPanel
    Left = 0
    Top = 0
    Width = 376
    Height = 99
    Align = alClient
    TabOrder = 1
    object rb_AllZavWork: TRadioButton
      Left = 16
      Top = 16
      Width = 113
      Height = 17
      Caption = #1079#1072#1103#1074#1082#1072
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rb_AllZavWorkClick
    end
    object rb_OborWork: TRadioButton
      Left = 16
      Top = 40
      Width = 113
      Height = 17
      Caption = #1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
      TabOrder = 1
      OnClick = rb_OborWorkClick
    end
    object DBL_ObjObor: TRxDBLookupCombo
      Left = 8
      Top = 72
      Width = 361
      Height = 21
      DropDownCount = 8
      LookupField = 'name_r'
      LookupSource = ds_LookupObor
      TabOrder = 2
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Left = 232
  end
  object dset: TIBQuery
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 192
  end
  object ds_LookupObor: TDataSource
    DataSet = dset
    Left = 288
  end
end
