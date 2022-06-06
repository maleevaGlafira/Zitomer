object ProsmForm2: TProsmForm2
  Left = 274
  Top = 352
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072
  ClientHeight = 389
  ClientWidth = 607
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
  PixelsPerInch = 96
  TextHeight = 15
  object Memo1: TRichEdit
    Left = 0
    Top = 0
    Width = 607
    Height = 349
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 349
    Width = 607
    Height = 40
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      607
      40)
    object BB_Print: TBitBtn
      Left = 442
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight]
      Caption = #1055#1077#1095#1072#1090#1100
      TabOrder = 0
      OnClick = BB_PrintClick
    end
    object BB_Close: TBitBtn
      Left = 525
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight]
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
  end
end
