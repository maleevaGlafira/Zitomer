object ProsmForm: TProsmForm
  Left = 262
  Top = 265
  Width = 738
  Height = 431
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Memo1: TRichEdit
    Left = 0
    Top = 25
    Width = 722
    Height = 329
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      
        '0123456789012345678901234567890123456789012345678901234567890123' +
        '4567890123456789')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 354
    Width = 722
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      722
      39)
    object BB_Print: TBitBtn
      Left = 471
      Top = 7
      Width = 75
      Height = 29
      Anchors = [akLeft]
      Caption = #1055#1077#1095#1072#1090#1100
      TabOrder = 0
      OnClick = BB_PrintClick
    end
    object BB_Close: TBitBtn
      Left = 563
      Top = 7
      Width = 75
      Height = 29
      Anchors = [akLeft]
      Caption = #1042#1099#1093#1086#1076
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Kind = bkClose
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 12
      Width = 113
      Height = 17
      Caption = #1059#1084#1077#1089#1090#1080#1090#1100' '#1085#1072' A4'
      TabOrder = 2
      OnClick = CheckBox1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 722
    Height = 25
    Align = alTop
    TabOrder = 2
    object MarkPagePanel: TPanel
      Left = 1
      Top = 1
      Width = 1100
      Height = 5
      TabOrder = 0
      object MarkPage80Label: TLabel
        Left = 640
        Top = -7
        Width = 8
        Height = 16
        Caption = '|'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object MarkPage136Label: TLabel
        Left = 1088
        Top = -7
        Width = 8
        Height = 16
        Caption = '|'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object MarkPage136_2Label: TLabel
        Left = 1091
        Top = -7
        Width = 8
        Height = 16
        Caption = '|'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 19
      Width = 1100
      Height = 5
      TabOrder = 1
      object Label1: TLabel
        Left = 640
        Top = -7
        Width = 8
        Height = 16
        Caption = '|'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        Left = 1088
        Top = -7
        Width = 8
        Height = 16
        Caption = '|'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label3: TLabel
        Left = 1091
        Top = -7
        Width = 8
        Height = 16
        Caption = '|'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 6
      Width = 644
      Height = 13
      TabOrder = 2
      object Label4: TLabel
        Left = 627
        Top = -1
        Width = 15
        Height = 15
        Caption = 'A4'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
    end
  end
end
