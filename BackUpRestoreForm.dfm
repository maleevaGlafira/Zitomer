object BRForm: TBRForm
  Left = 199
  Top = 191
  BorderStyle = bsDialog
  Caption = 'BRForm'
  ClientHeight = 125
  ClientWidth = 493
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 84
    Width = 493
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 200
      Top = 8
      Width = 75
      Height = 25
      Caption = #1055#1091#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 493
    Height = 84
    Align = alClient
    Color = clBtnFace
    Lines.Strings = (
      'Memo1')
    ReadOnly = True
    TabOrder = 1
  end
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 493
    Height = 84
    Align = alClient
    ItemHeight = 13
    TabOrder = 2
    Visible = False
  end
end
