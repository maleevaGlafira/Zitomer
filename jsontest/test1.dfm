object Form1: TForm1
  Left = 192
  Top = 124
  Width = 645
  Height = 346
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 24
    Top = 16
    Width = 553
    Height = 81
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 32
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    Visible = False
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 120
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 2
    Visible = False
    OnClick = Button2Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 289
    Width = 629
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object Button3: TButton
    Left = 208
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 4
    Visible = False
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 296
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Button4'
    TabOrder = 5
    Visible = False
    OnClick = Button4Click
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 160
    Width = 545
    Height = 113
    Caption = 'tetclass'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 42
      Height = 20
      Caption = 'N obj'
    end
    object Button5: TButton
      Left = 16
      Top = 72
      Width = 75
      Height = 25
      Caption = 'Create'
      Enabled = False
      TabOrder = 0
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 104
      Top = 72
      Width = 81
      Height = 25
      Caption = 'SentNew'
      Enabled = False
      TabOrder = 1
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 208
      Top = 72
      Width = 75
      Height = 25
      Caption = 'Button7'
      Enabled = False
      TabOrder = 2
      OnClick = Button7Click
    end
    object Button8: TButton
      Left = 312
      Top = 72
      Width = 75
      Height = 25
      Caption = 'sentDel'
      Enabled = False
      TabOrder = 3
      OnClick = Button8Click
    end
    object ComboBox1: TComboBox
      Left = 64
      Top = 29
      Width = 145
      Height = 28
      ItemHeight = 20
      TabOrder = 4
      Text = 'ComboBox1'
    end
    object Button9: TButton
      Left = 264
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Button9'
      TabOrder = 5
      OnClick = Button9Click
    end
  end
end
