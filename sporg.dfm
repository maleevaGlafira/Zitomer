object FormOrg: TFormOrg
  Left = 290
  Top = 260
  Width = 308
  Height = 188
  Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 11
    Top = 14
    Width = 87
    Height = 15
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object Label2: TLabel
    Left = 11
    Top = 39
    Width = 51
    Height = 15
    Caption = #1058#1077#1083#1077#1092#1086#1085
  end
  object Label3: TLabel
    Left = 11
    Top = 64
    Width = 53
    Height = 15
    Caption = #1092#1072#1084#1080#1083#1080#1103
  end
  object Ed_name: TEdit
    Left = 102
    Top = 11
    Width = 160
    Height = 23
    MaxLength = 20
    TabOrder = 0
    OnChange = Ed_nameChange
  end
  object Ed_tf: TEdit
    Left = 102
    Top = 35
    Width = 160
    Height = 23
    MaxLength = 20
    TabOrder = 1
    OnChange = Ed_nameChange
  end
  object Ed_Fam: TEdit
    Left = 102
    Top = 60
    Width = 160
    Height = 23
    MaxLength = 20
    TabOrder = 2
    OnChange = Ed_nameChange
  end
  object BB_Ok: TBitBtn
    Left = 11
    Top = 106
    Width = 87
    Height = 29
    Caption = #1055#1088#1080#1085#1103#1090#1100
    TabOrder = 3
    OnClick = BB_OkClick
    Kind = bkOK
  end
  object BB_ESC: TBitBtn
    Left = 176
    Top = 106
    Width = 88
    Height = 29
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = BB_ESCClick
    Kind = bkAbort
  end
end
